#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sonda 3: localiza el bloque BASE64 continuo dentro del archivo y lo decodifica.
En este ofuscado, las variables sueltas son ruido/cebo y el payload real es una
unica cadena base64 larga embebida. Se detecta por heuristica y se decodifica.
"""
import base64
import re
import sys

path = sys.argv[1]
t = open(path, encoding="utf-8", errors="replace").read()

# 1) Todas las cadenas entre comillas simples que parezcan base64 largas
cands = re.findall(r"'([A-Za-z0-9+/=]{40,})'", t)
print("candidatos base64 >=40 chars:", len(cands))
cands.sort(key=len, reverse=True)
for c in cands[:5]:
    print("   len=%d  inicio=%r" % (len(c), c[:60]))
    try:
        d = base64.b64decode(c + "===", validate=False)
        head = d[:120].decode("utf-8", "replace")
        print("      -> decodifica %d bytes : %r" % (len(d), head))
    except Exception as e:
        print("      -> fallo:", e)

# 2) Prueba definitiva: concatenar los fragmentos en el orden EXACTO del archivo
#    pero SOLO los que sean base64 validos, y buscar el prefijo '#!/bin/bash'
decl = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t)
names = [n for n, _ in decl]
vals = {n: v for n, v in decl}
print("\ntotal fragmentos declarados:", len(decl))

def try_orders(seq_names, label):
    blob = "".join(vals.get(n, "") for n in seq_names)
    for pad in ("", "=", "==", "==="):
        try:
            d = base64.b64decode(blob + pad, validate=False)
        except Exception:
            continue
        if d.startswith(b"#!") or b"#!/bin" in d[:40]:
            txt = d.decode("utf-8", "replace")
            print("[%s] EXITO: %d bytes / %d lineas" % (label, len(d), txt.count(chr(10)) + 1))
            open(path + ".order.txt", "w", encoding="utf-8").write(label)
            out = re.sub(r"\.(txt|sh|\w+)\.order\.txt$", "") + "_ORDEN_" + label.replace("/", "_") + ".sh"
            open(out, "w", encoding="utf-8", newline="\n").write(txt)
            print("      guardado:", out)
            return True
    return False

ev = [l for l in t.splitlines() if l.lstrip().startswith("eval")]
if ev:
    order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev[0])
    try_orders([n for n in order if n in vals], "eval-order")
    try_orders([n for n in order if n in vals][::-1], "eval-reversed")
try_orders(names, "decl-order")
try_orders(names[::-1], "decl-reversed")

# 3) Probar decodificacion incremental buscando el prefijo
raw = "".join(vals.get(n, "") for n in names)
idx = raw.find("IyEvYmlu")
print("\n'#' base64 (IyEvYmlu) aparece en la concatenacion decl-order en offset:", idx)
if idx >= 0:
    seg = raw[idx:]
    try:
        d = base64.b64decode(seg[:len(seg) // 4 * 4], validate=False)
        txt = d.decode("utf-8", "replace")
        print("decodificado desde ese offset: %d bytes" % len(d))
        print(repr(txt[:300]))
    except Exception as e:
        print("fallo:", e)
