#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Desofuscador TIPO 2b: "Base64 por variables + eval"
==============================================================================
 Tecnica detectada en:
   - Instalador/LATAM                  (By @ChumoGH|Plus)
   - plus.ltmcgh.site/pack_new         (ya volcado por deobf_type2_vars.py)
   - Plugin patron `z="\n";xx='BASE64';...;eval "$xx$yy..."`

 Como funciona (100% estatico, NO se ejecuta bash):
   1. Cada variable contiene un fragmento de texto codificado en BASE64.
   2. La linea `eval "$Az$fDx$Cz..."` concatena (en orden de aparicion)
      todos los fragmentos.
   3. El resultado concatenado es un BASE64 gigante.
   4. Al decodificarlo se obtiene el script bash real.

 Este script NO usa eval, NO usa bash: solo lee el archivo, extrae los
 pares  nombre='base64'  (o nombre="base64"), los une en el mismo orden en
 que aparecen en el archivo, decodifica y guarda el resultado.

 Uso:
   python deobf_type2b_latam.py <archivo_ofuscado> [salida.sh]
==============================================================================
"""
import base64
import os
import re
import sys

# Marcadores que revelan donde empieza el BASE64 real (el resto es cebo)
B64_MARKERS = [
    "IyEvYmluL2Jhc2g",   #!/bin/bash
    "IyEvYmlu",          #!/bin
    "IyEv",              #!/
    "IyAt",              # - (comentario bash)
]
ASSIGN_RE = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)\s*=\s*'([A-Za-z0-9+/=]*)'")


def extract_fragments(text):
    """Extrae (nombre, base64) en el MISMO orden de aparicion en el archivo."""
    frags = []
    seen = set()
    for m in ASSIGN_RE.finditer(text):
        name, b64 = m.group(1), m.group(2)
        if name == "z":          # contenedor del salto de linea
            continue
        if not b64 or name in seen:
            continue
        seen.add(name)
        frags.append((name, b64))
    return frags


def rebuild_b64(frags):
    """Orden real de concatenacion = orden de declaracion en el archivo."""
    return "".join(b64 for _n, b64 in frags)


def try_b64(blob, label):
    # Decodifica un blob base64. Devuelve (texto, offset_cebo, cabecera_cebo).
    # Un resultado valido debe PARECER un script bash legible, si no es cebo.
    def looks_like_shell(x):
        if not x.strip():
            return False
        printable = sum(1 for c in x[:2000] if c.isprintable() or c in "\n\r\t")
        ratio = printable / max(1, len(x[:2000]))
        return ratio > 0.9 and ("\n" in x)

    # 1) Intento directo (solo si el resultado es legible)
    for pad in ("", "=", "==", "==="):
        try:
            data = base64.b64decode(blob + pad, validate=False)
            txt = data.decode("utf-8", "replace")
            if looks_like_shell(txt):
                print("[+] Decodificacion %s OK: %d bytes / %d lineas"
                      % (label, len(data), txt.count("\n") + 1))
                return txt, 0, ""
        except Exception:
            pass
    # 2) El ofuscado mete una CABEZA DE CEBO antes del base64 real.
    for m in B64_MARKERS:
        i = blob.find(m)
        if i < 0:
            continue
        seg = blob[i:]
        seg = seg[:len(seg) // 4 * 4]
        try:
            data = base64.b64decode(seg, validate=False)
            txt = data.decode("utf-8", "replace")
            if looks_like_shell(txt):
                print("[+] Decodificacion %s OK (cebo de %d chars: %r): "
                      "%d bytes / %d lineas"
                      % (label, i, blob[:i], len(data), txt.count("\n") + 1))
                return txt, i, blob[:i]
        except Exception as e:
            print("[!] Fallo con marcador %r: %s" % (m, e))
    print("[!] No se pudo decodificar (%s)" % label)
    return None, -1, ""


def deobfuscate(path, out_path):
    print("[*] Leyendo: %s" % path)
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        text = f.read()

    frags = extract_fragments(text)
    print("[+] Fragmentos base64 encontrados: %d" % len(frags))
    if not frags:
        print("[ERROR] No se encontro el patron de variables base64.")
        return None

    total = sum(len(b) for _n, b in frags)
    print("[+] Total base64 concatenado: %d caracteres" % total)

    # --- Orden real = el de la linea `eval "$a$b$c..."` ---
    eval_line = ""
    for ln in text.splitlines():
        if ln.lstrip().startswith("eval"):
            eval_line = ln
            break
    order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", eval_line)
    d = dict(frags)
    seq = [d[n] for n in order if n in d]
    if not seq:
        seq = [b for _n, b in frags]
    print("[+] Orden tomado de la linea eval (%d tokens de %d fragmentos)"
          % (len(seq), len(frags)))

    txt, _dl, _dc = try_b64("".join(seq), "orden-eval")
    if txt is None:
        print("[!] Intentando orden declaracion...")
        txt, decoy_len, decoy = try_b64(rebuild_b64(frags), "orden-declaracion")
    if txt is None:
        print("[!] Intentando orden inverso...")
        txt, decoy_len, decoy = try_b64("".join(reversed(seq)), "orden-inverso")
    if txt is None:
        print("[ERROR] Imposible reconstruir el payload.")
        return None

    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(txt)
    print("[OK] Volcado guardado en: %s" % out_path)
    return txt


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python deobf_type2b_latam.py <ofuscado> [salida.sh]")
        sys.exit(1)
    src = sys.argv[1]
    if len(sys.argv) > 2:
        dst = sys.argv[2]
    else:
        base = os.path.splitext(os.path.basename(src))[0]
        dst = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           "..", "3_CODIGOVOLCADOFINAL", base + "_limpio.sh")
    deobfuscate(src, os.path.abspath(dst))

