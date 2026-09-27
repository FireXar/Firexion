#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sonda 2: descubre que fragmentos son BASE64 reales y cuales son TEXTO PLANO,
respetando el orden exacto del `eval "$a$b$c..."`.
"""
import base64
import re
import sys

path = sys.argv[1]
t = open(path, encoding="utf-8", errors="replace").read()

ev = [l for l in t.splitlines() if l.lstrip().startswith("eval")][0]
order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev)

# mapa nombre -> valor (incluye asignaciones de texto plano entre comillas dobles)
assign = {m[0]: m[1] for m in re.findall(r"([A-Za-z_][A-Za-z0-9_]*)=(['\"])(.*?)\2", t)}
# refinar: solo los que son tokens cortos '...'
assign2 = dict(re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t))
print("asign totales (cualquier comilla):", len(assign))
print("asign base64-ish:", len(assign2))

n_b64 = 0
n_plain = 0
n_empty = 0
out_b64 = []
out_mix = []
for name in order:
    v = assign2.get(name)
    if v is None:
        v2 = assign.get(name)
        if v2 is None:
            n_empty += 1
            out_mix.append("")
            continue
        # texto plano entre comillas dobles (salto de linea, etc)
        n_plain += 1
        out_mix.append(v2)
        continue
    out_b64.append(v)
    out_mix.append(v)
    n_b64 += 1

print("vars del eval -> base64:%d  plano:%d  vacias:%d" % (n_b64, n_plain, n_empty))

mix = "".join(out_mix)
print("\nlen(mezcla):", len(mix))

# Intentar base64 sobre la mezcla
try:
    dec = base64.b64decode(mix + "===", validate=False)
    print("[b64 directo] %d bytes" % len(dec))
    print(repr(dec[:200]))
except Exception as e:
    print("[b64 directo] fallo:", e)

print("\n--- muestra de la mezcla (primeros 300 chars) ---")
print(repr(mix[:300]))
