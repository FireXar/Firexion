#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sonda 4: verifica si la concatenacion en orden 'eval' forma base64 VALIDO.
Si no, revisa si el orden correcto es el de la linea de asignaciones (no la eval).
"""
import base64
import re
import sys

path = sys.argv[1]
t = open(path, encoding="utf-8", errors="replace").read()
lines = t.splitlines()

ev = [l for l in lines if l.lstrip().startswith("eval")][0]
order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev)

# asignaciones en orden de aparicion textual
decl = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t)
vals = {}
for n, v in decl:
    vals.setdefault(n, v)

print("vars eval:", len(order), "| assigns:", len(vals))

def b64_try(blob, label):
    good = sum(1 for ch in blob if ch.isalnum() or ch in "+/=")
    print("  %-14s len=%5d  chars-base64=%d (%.1f%%)" % (
        label, len(blob), good, 100.0 * good / max(1, len(blob))))
    for pad in ("", "=", "==", "==="):
        try:
            d = base64.b64decode(blob + pad, validate=True)
            print("     -> VALIDO con pad %r : %d bytes" % (pad, len(d)))
            return d
        except Exception:
            pass
    return None

seq_eval = "".join(vals.get(n, "") for n in order)
seq_decl = "".join(v for _n, v in decl)
seq_decl_u = "".join(vals[n] for n in dict.fromkeys(n for n, _ in decl))

print("concatenaciones:")
b64_try(seq_eval, "eval-order")
b64_try(seq_decl, "decl-order")
b64_try(seq_decl_u, "decl-uniq")
b64_try(seq_eval[::-1], "eval-rev")
b64_try(seq_decl[::-1], "decl-rev")

# muestra cruda de la concatenacion eval
print("\nraw eval-order[:200] :", repr(seq_eval[:200]))

# Comprobar los 20 primeros fragmentos del eval y su valor
print("\nprimeros 20 fragmentos del eval:")
for n in order[:20]:
    print("   %-6s = %r" % (n, vals.get(n)))
