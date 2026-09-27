#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sonda 5 (definitiva): el ofuscado tiene CABEZA DE CEBO.
La concatenacion en orden `eval` empieza con fragmentos de ruido
('Chum','oGH=','temp','base','umoG','DIXI'...) y DESPUES viene el BASE64 real
que arranca en 'IyEvYmluL2Jhc2gK' ( = '#!/bin/bash' ).

Por eso: localizar el offset del marcador base64 de '#!/bin' y decodificar
desde ahi hasta el final de la concatenacion.
"""
import base64
import re
import sys

MARKERS = ["IyEvYmluL2Jhc2g",   #!/bin/bash
           "IyEvYmlu",          #!/bin
           "IyEv"]              #!/

path = sys.argv[1]
t = open(path, encoding="utf-8", errors="replace").read()

ev = [l for l in t.splitlines() if l.lstrip().startswith("eval")]
if not ev:
    print("[ERROR] no hay linea eval")
    sys.exit(1)
order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev[0])

decl = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t)
vals = {}
for n, v in decl:
    vals.setdefault(n, v)
print("[*] vars=%d  assigns=%d" % (len(order), len(vals)))

blob = "".join(vals.get(n, "") for n in order)
print("[*] concatenacion eval-order: %d chars" % len(blob))

start = -1
for m in MARKERS:
    i = blob.find(m)
    if i >= 0:
        print("[+] marcador %r encontrado en offset %d" % (m, i))
        start = i
        break
if start < 0:
    print("[ERROR] sin marcador base64")
    sys.exit(1)

payload = blob[start:]
payload = payload[:len(payload) // 4 * 4]
raw = base64.b64decode(payload, validate=False)
txt = raw.decode("utf-8", "replace")
print("[OK] decodificado: %d bytes / %d lineas" % (len(raw), txt.count(chr(10)) + 1))
print("[i] cabecera de cebo descartada:", blob[:start])

out = sys.argv[2] if len(sys.argv) > 2 else (path + "_limpio.sh")
open(out, "w", encoding="utf-8", newline="\n").write(txt)
print("[OK] guardado en:", out)
print("\n---- primeras 25 lineas del volcado ----")
for ln in txt.splitlines()[:25]:
    print("   " + ln)
