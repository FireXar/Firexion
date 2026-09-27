#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Inventario completo de repos clonados (estatico, sin ejecucion)
==============================================================================
 Recorre los repos clonados y clasifica cada archivo:
   SCRIPT/PY   -> texto legible
   OFUSCADO    -> binario/ELF o alto porcentaje de no imprimibles
   ARCHIVO     -> zip/tar/gz/apk
 Marca los que son relevantes para el runtime (msg, ssl, menu, key, etc.)
==============================================================================
"""
import os
import re
import sys

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "1_CODIGOORIGINAL", "github_repo")

KEYWORDS = ("msg", "ssl", "menu", "key", "control", "bot", "lista-arq",
            "shadowsocks", "token", "pack", "setup", "sourcesfix", "swap")


def classify(p):
    with open(p, "rb") as f:
        d = f.read(4096)
    size = os.path.getsize(p)
    if d[:4] == b"\x7fELF":
        return "ELF-BINARIO", size
    if d[:2] == b"\x1f\x8b":
        return "GZIP", size
    if d[:2] == b"PK":
        return "ZIP/APK", size
    if d[:2] == b"BZ":
        return "BZIP2", size
    if d[:3] == b"\xef\xbb\xbf":
        return "TEXTO-BOM", size
    try:
        txt = d.decode("utf-8")
        if txt.lstrip().startswith(("#!", "import", "<?php", "<!", "//", "#")):
            return "SCRIPT/TEXTO", size
        return "TEXTO", size
    except Exception:
        pass
    # heuristica binaria
    printable = sum(1 for b in d if 32 <= b < 127 or b in (9, 10, 13))
    r = printable / max(1, len(d))
    if r > 0.85:
        return "TEXTO?", size
    return "BINARIO-OFUSCADO", size


def main():
    print("=" * 110)
    print(" INVENTARIO DE REPOSITORIOS CLONADOS")
    print("=" * 110)
    for repo in sorted(os.listdir(BASE)):
        rp = os.path.join(BASE, repo)
        if not os.path.isdir(rp) or repo.startswith("_"):
            continue
        files = []
        for dp, _d, fns in os.walk(rp):
            for fn in fns:
                if ".git" in dp.split(os.sep):
                    continue
                files.append(os.path.join(dp, fn))
        print("\n### %s  (%d archivos)" % (repo, len(files)))
        for p in sorted(files):
            kind, size = classify(p)
            rel = os.path.relpath(p, rp)
            flag = ""
            low = rel.lower()
            if any(k in low for k in KEYWORDS):
                flag = " <== RELEVANTE"
            print("   %-16s %9d  %s%s" % (kind, size, rel, flag))


if __name__ == "__main__":
    main()
