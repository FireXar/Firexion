#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Desofuscador TIPO 3: "Expansion de parametros ${@...}"
==============================================================================
 Tecnica detectada en:
   - Plugins/system/pack3.tar          (ya volcado)
   - version/v-ant.bin
   - Plugins/system/SCRIPT.tar.gz -> 'menu'   (el MENU REAL de 1.6 MB)

 Como funciona (SIN ejecutar bash):
   El script define `set -- ` y luego escribe 3800+ tokens del tipo
       ${@~} ${@,} ${@^} ${@//pat/rep} ${@#pat} ${@%%pat} ${*~~} ...
   Cada token NO produce texto util por si mismo; lo que importa es que
   ENTRE token y token hay espacios/tabs que SON los caracteres reales.
   El base64 final se forma con los espacios significativos.

 Este script reconstruye el flujo de caracteres que el shell produciria:
   - los tokens ${...} se eliminan
   - los espacios/tabs se conservan
   Luego busca el bloque base64 y lo decodifica (con soporte para capas
   BZIP2/GZIP adicionales).

 Uso:
   python deobf_type3b_param.py <archivo> [salida]
==============================================================================
"""
import base64
import bz2
import gzip
import re
import sys
import zlib

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

# Tokens de expansion de parametros de bash
TOKEN = re.compile(r"\$\{[^{}]*\}|\$\*|\$@|\$\d")


def strip_tokens(text):
    """Elimina tokens ${...} conservando espacios/tabs (que son los datos)."""
    return TOKEN.sub("", text)


def try_layers(blob, label):
    """Intenta decodificar `blob` con las capas habituales."""
    results = []

    def add(name, data):
        if data:
            results.append((name, data))

    # base64 directo
    for pad in ("", "=", "==", "==="):
        try:
            raw = base64.b64decode(blob + pad, validate=False)
            add("b64", raw)
            break
        except Exception:
            pass

    for name, raw in list(results):
        # gzip
        try:
            add("b64+gzip", gzip.decompress(raw))
        except Exception:
            pass
        # bz2
        try:
            add("b64+bz2", bz2.decompress(raw))
        except Exception:
            pass
        # zlib
        try:
            add("b64+zlib", zlib.decompress(raw))
        except Exception:
            pass

    out = []
    for name, data in results:
        try:
            txt = data.decode("utf-8")
            printable = sum(1 for c in txt[:3000] if c.isprintable() or c in "\n\r\t")
            ratio = printable / max(1, len(txt[:3000]))
            out.append((name, len(data), ratio, txt))
        except Exception:
            pass
    return out


def decode_longest_blob(t):
    # Quita tokens, busca el bloque base64 mas largo y devuelve (texto, capa).
    ws = strip_tokens(t)
    blobs = re.findall(r"[A-Za-z0-9+/=]{500,}", ws)
    if not blobs:
        return None
    blobs.sort(key=len, reverse=True)
    best = None
    for b in blobs[:5]:
        for name, size, ratio, txt in try_layers(b, "bloque"):
            if best is None or size > best[1]:
                best = (txt, size, name)
    return best

def is_param_obfuscated(text):
    # Detecta si la salida es OTRA capa de ${@...} (ofuscado anidado).
    n = len(re.findall(r"\$\{[@*!][^{}]*\}", text))
    return n > 200

def main():
    src = sys.argv[1]
    dst = sys.argv[2] if len(sys.argv) > 2 else (src + "_limpio.sh")
    t = open(src, encoding="utf-8", errors="replace").read()
    print("[*] Archivo: %s (%d chars)" % (src, len(t)))

    best = decode_longest_blob(t)
    if best is None:
        print("[ERROR] No se encontro bloque base64.")
        return 1
    txt, size, name = best
    print("[+] Capa 1 desempacada: %s (%d bytes)" % (name, size))

    # Pelar capas anidadas mientras sigan apareciendo tokens ${@...}
    layer = 1
    while is_param_obfuscated(txt) and layer < 8:
        layer += 1
        print("[*] Capa %d tambien esta ofuscada con ${@...}: pelando..." % layer)
        nxt = decode_longest_blob(txt)
        if nxt is None:
            print("[!] Capa %d no tiene bloque base64, se detiene." % layer)
            break
        txt, size, name = nxt
        print("[+] Capa %d desempacada: %s (%d bytes)" % (layer, name, size))

    open(dst, "w", encoding="utf-8", newline="\n").write(txt)
    print("[OK] %d capas -> %s (%d bytes)" % (layer, dst, len(txt)))
    head = [ln for ln in txt.splitlines() if ln.strip()][:15]
    print("---- primeras lineas con contenido ----")
    for ln in head:
        print("   " + ln[:160])
    return 0


if __name__ == "__main__":
    sys.exit(main())
