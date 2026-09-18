#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Desofuscador TIPO 2c: "vars + eval con posicionales borrados"
==============================================================================
 Variante detectada en: ScriptCGH/setup

 Diferencia con el TIPO 2b (LATAM):
   - NO es base64. Los fragmentos son TEXTO PLANO (`expo`, `ATH=/usr`...).
   - El `eval` concatena   $Var  y  $1..$9 / $@ / $* .
   - Los posicionales $1..$9 NO estan definidos en el archivo (se pasan al
     ejecutar el script), por lo que cada uno "borra" 1 caracter del texto.
     Ej: 'ipefail'  es 'pipefail' sin la 'p' (el $1 se comio la 'p').

 Como el valor de los posicionales NO esta en el archivo, la reconstruccion
 EXACTA es imposible de forma estatica. Lo que SI podemos hacer de forma
 segura es:
   1) Recuperar el "esqueleto" del script (todas las cadenas de texto).
   2) Marcar con '?' cada posicion donde falta 1 caracter.
   3) Extraer TODAS las URLs/endpoints, que quedan legibles igual.

 Uso:
   python deobf_type2c_posicional.py <archivo> [salida]
==============================================================================
"""
import re
import sys

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

ASSIGN = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)='((?:[^'\\]|\\.)*)'")


def main():
    src = sys.argv[1]
    dst = sys.argv[2] if len(sys.argv) > 2 else (src + "_esqueleto.sh")
    t = open(src, encoding="utf-8", errors="replace").read()

    evs = [l for l in t.splitlines() if l.lstrip().startswith("eval")]
    if not evs:
        print("[ERROR] no hay linea eval")
        return 1
    ev = evs[0]

    decl = ASSIGN.findall(t)
    vals = {}
    for n, v in decl:
        vals.setdefault(n, v)
    print("[*] fragmentos: %d | vars unicas: %d" % (len(decl), len(vals)))

    order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", ev)
    print("[*] tokens en eval: %d (%d unicos)" % (len(order), len(set(order))))

    out = []
    missing = 0
    for n in order:
        if n in vals:
            out.append(vals[n])
        elif n.isdigit() or n in ("@", "*", "?"):
            out.append("\x00")      # 1 caracter borrado por el posicional
            missing += 1
        else:
            out.append("")          # var vacia (z, $Bin, etc.)
    skeleton = "".join(out)
    # Marcar huecos
    marked = skeleton.replace("\x00", "?")

    # Des-escapes basicos de bash para que se lea mejor
    marked = marked.replace("\\'", "'").replace('\\"', '"') \
                   .replace("\\n", "\n").replace("\\e", "\x1b") \
                   .replace("\\t", "\t").replace("\\/", "/")

    open(dst, "w", encoding="utf-8", newline="\n").write(marked)
    print("[OK] esqueleto -> %s (%d chars, %d huecos '?')"
          % (dst, len(marked), missing))

    urls = sorted(set(re.findall(r"https?://[^\s\"'\\<>|`]+", marked)))
    print("\n[+] URLs/endpoints recuperados: %d" % len(urls))
    for u in urls:
        print("   " + u)

    print("\n---- primeras 30 lineas del esqueleto ----")
    for ln in [l for l in marked.splitlines() if l.strip()][:30]:
        print("   " + ln[:150])
    return 0


if __name__ == "__main__":
    sys.exit(main())
