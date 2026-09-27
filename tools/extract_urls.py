#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Extractor de URLs / endpoints de todos los archivos auditados
==============================================================================
 Recorre los .sh/.py/.txt legibles del proyecto y extrae TODA url o endpoint
 remoto, agrupando por dominio. Es la base del mapa de reescritura a
 http://localhost/pkdlatamsrc/CHUMOPLUS/mirror/...
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

SCAN_DIRS = [
    "3_CODIGOVOLCADOFINAL",
    "1_CODIGOORIGINAL",
    "mirror/github/main",
]
EXTS = (".sh", ".py", ".txt", ".bin", ".json", ".list", ".html", ".js", ".md", ".log")

URL_RE = re.compile(r"""https?://[^\s"'\\)<>|`]+""")
IP_RE = re.compile(r"""\b\d{1,3}(?:\.\d{1,3}){3}(?::\d+)?""")

IGNORE_HOSTS = {
    "localhost", "127.0.0.1",
}


def scan(path):
    urls, ips = set(), set()
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            txt = f.read()
    except Exception:
        return urls, ips
    for m in URL_RE.finditer(txt):
        u = m.group(0).rstrip(".,;)")
        urls.add(u)
    for m in IP_RE.finditer(txt):
        ips.add(m.group(0))
    return urls, ips


def main():
    allurls = {}
    allips = {}
    for d in SCAN_DIRS:
        base = os.path.join(ROOT, d)
        if not os.path.isdir(base):
            continue
        for dirpath, _dirs, files in os.walk(base):
            for fn in files:
                if not fn.lower().endswith(EXTS):
                    continue
                p = os.path.join(dirpath, fn)
                if os.path.getsize(p) > 8_000_000:
                    continue
                urls, ips = scan(p)
                rel = os.path.relpath(p, ROOT)
                for u in urls:
                    allurls.setdefault(u, set()).add(rel)
                for i in ips:
                    allips.setdefault(i, set()).add(rel)

    import io
    out = io.StringIO()
    def w(s=""):
        out.write(s + "\n")

    print("=" * 100)
    print(" URLs / ENDPOINTS REMOTOS DETECTADOS (%d unicos)" % len(allurls))
    print("=" * 100)
    for u in sorted(allurls):
        srcs = sorted(allurls[u])
        print("\n%s" % u)
        print("    usado en: %s" % ", ".join(srcs[:4]) + (" (+%d mas)" % (len(srcs) - 4) if len(srcs) > 4 else ""))

    print("\n" + "=" * 100)
    print(" IPs DETECTADAS (%d unicas)" % len(allips))
    print("=" * 100)
    for i in sorted(allips, key=lambda x: tuple(int(n) for n in re.match(r"[\d.]+", x).group(0).split("."))):
        srcs = sorted(allips[i])
        print("  %-22s %s" % (i, ", ".join(srcs[:3])))

    # resumen por host
    print("\n" + "=" * 100)
    print(" RESUMEN POR HOST")
    print("=" * 100)
    hosts = {}
    for u in allurls:
        h = re.match(r"https?://([^/]+)", u)
        if h:
            hosts.setdefault(h.group(1), []).append(u)
    for h in sorted(hosts):
        print("  %-45s %d URLs" % (h, len(hosts[h])))

    # Volcar SIEMPRE en UTF-8 (evita el UTF-16 de PowerShell >)
    outp = os.path.join(ROOT, "1_CODIGOORIGINAL", "URLS_DETECTADAS.txt")
    with open(outp, "w", encoding="utf-8", newline="\n") as f:
        f.write("# INVENTARIO DE URLs DETECTADAS - CHUMOPLUS\n")
        f.write("# Formato: <url>\t<archivos_donde_aparece>\n\n")
        for u in sorted(allurls):
            f.write("%s\t%s\n" % (u, ";".join(sorted(allurls[u]))))
        f.write("\n# --- IPs ---\n")
        for i in sorted(allips):
            f.write("%s\t%s\n" % (i, ";".join(sorted(allips[i]))))
    print("\n[OK] inventario UTF-8 escrito en: %s" % outp)


if __name__ == "__main__":
    main()
