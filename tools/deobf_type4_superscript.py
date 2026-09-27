#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Desofuscador TIPO 4: "Digitos Unicode en Superindice"
==============================================================================
 Tecnica detectada en:  TOKENS/dinamicos/token
   Los numeros reales se escriben con digitos unicode de superindice
   (U+2070..U+2079) y el punto decimal como U+00B7.
   Ej:  '\u2075\u2077\u2075,\u2075\u2078\u2077'  ->  '575,587'

 Modo 100% estatico: solo traduce caracteres, no ejecuta nada.
 Uso:  python deobf_type4_superscript.py <archivo> [salida.txt]
==============================================================================
"""
import sys

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass
DIGITS = {
    "\u2070": "0", "\u00b9": "1", "\u00b2": "2", "\u00b3": "3", "\u2074": "4",
    "\u2075": "5", "\u2076": "6", "\u2077": "7", "\u2078": "8", "\u2079": "9",
    "\u00b7": ".", "\u207a": "+", "\u207b": "-", "\u207f": "n",
}


def decode(text):
    out = []
    for ch in text:
        out.append(DIGITS.get(ch, ch))
    return "".join(out)


def main():
    src = sys.argv[1]
    dst = sys.argv[2] if len(sys.argv) > 2 else (src + "_decoded.txt")
    raw = open(src, encoding="utf-8", errors="replace").read()
    txt = decode(raw)
    open(dst, "w", encoding="utf-8", newline="\n").write(txt)
    print("[OK] %d chars -> %s" % (len(txt), dst))
    print("---- primeras 30 lineas ----")
    for ln in txt.splitlines()[:30]:
        print("   " + ln)


if __name__ == "__main__":
    main()

