#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Sonda estatica para comprender la estructura del ofuscado tipo LATAM/pack_new."""
import re
import sys
from collections import Counter

path = sys.argv[1]
t = open(path, encoding="utf-8", errors="replace").read()
lines = t.splitlines()

ev = [l for l in lines if l.lstrip().startswith("eval")]
print("lineas eval:", len(ev))
ev = ev[0]
order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev)
print("tokens en eval:", len(order), " unicos:", len(set(order)))
c = Counter(order)
print("nombres repetidos:", [(k, v) for k, v in c.items() if v > 1][:10])

assign = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)\s*=\s*'([A-Za-z0-9+/=]*)'", t)
d = {}
dup = 0
for n, b in assign:
    if n in d:
        dup += 1
    d.setdefault(n, b)
print("asignaciones totales:", len(assign), " unicas:", len(d), " duplicadas:", dup)
print("valor de la variable z:", repr(d.get("z"))[:120])

miss = [n for n in dict.fromkeys(order) if n not in d]
print("vars del eval sin asignacion base64:", len(miss), miss[:25])

print("\nprimeros 12 assigns:")
for n, b in assign[:12]:
    print("   %-8s %r" % (n, b))

print("\nultimos 8 assigns:")
for n, b in assign[-8:]:
    print("   %-8s %r" % (n, b))

print("\norden real (primeras 25 vars del eval):", order[:25])
print("orden real (ultimas 10 vars del eval):", order[-10:])

# Longitud total si se concatenan las vars del eval en su orden exacto
seq = [d.get(n, "") for n in order]
print("\nlen(concat segun eval):", sum(len(x) for x in seq), " (con %d vars vacias)" % seq.count(""))
print("len(concat unicas):", sum(len(x) for x in d.values()))
