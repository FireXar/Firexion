#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Constructor del MAPA DE REESCRITURA URL Remota -> localhost
==============================================================================
 Lee el inventario de URLs detectadas, agrupa por host y genera:
   1) mirror_targets.txt      -> lista de URLs a espejar (con ruta local)
   2) REESCRITURA_URLS.md     -> tabla markdown URL remota -> URL localhost
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
INV = os.path.join(ROOT, "1_CODIGOORIGINAL", "URLS_DETECTADAS.txt")

PUBLIC_PREFIX = "http://localhost/pkdlatamsrc/CHUMOPLUS/mirror"

# Hosts que vamos a espejar (los del ecosistema ChumoGH + recursos usados en runtime)
MIRROR_HOSTS = {
    "raw.githubusercontent.com": "github",
    "github.com": "github-web",
    "www.dropbox.com": "dropbox",
    "plus.ltmcgh.site": "plus.ltmcgh.site",
    "plus.admcgh.site": "plus.admcgh.site",
    "cdn.sessionstack.com": "cdn.sessionstack.com",
    "multi.netlify.app": "multi.netlify.app",
    "multi.netlify.com": "multi.netlify.com",
    "dl.lamp.sh": "dl.lamp.sh",
}

SKIP_PREFIX = (
    "http://$", "https://$", "http://%", "https://%",
    "http://127.0.0.1", "http://localhost",
)


def local_path_for(url):
    """Devuelve la ruta local (dentro de mirror/) para una URL."""
    m = re.match(r"https?://([^/]+)/?(.*)$", url)
    if not m:
        return None
    host = m.group(1)
    rest = m.group(2).split("?")[0].split("#")[0].rstrip("/")
    if not rest:
        rest = "_index"
    # Sanitizar nombre por si hay caracteres raros
    rest = rest.replace("//", "/")
    parts = [p for p in rest.split("/") if p not in ("", ".", "..")]
    if not parts:
        parts = ["_index"]
    folder = MIRROR_HOSTS.get(host, host)
    return "/".join(["mirror", folder] + parts)


def main():
    urls = set()
    for line in open(INV, encoding="utf-8", errors="replace"):
        s = line.strip()
        if s.startswith("#") or not s:
            continue
        # formato TSV: <url>\t<archivos...>
        u = s.split("\t")[0].strip()
        if u.startswith("http://") or u.startswith("https://"):
            urls.add(u)

    rows = []
    targets = []
    for u in sorted(urls):
        if u.startswith(SKIP_PREFIX):
            continue
        lp = local_path_for(u)
        if not lp:
            continue
        m = re.match(r"https?://([^/]+)", u)
        host = m.group(1)
        mirrored = host in MIRROR_HOSTS
        public = "%s/%s" % (PUBLIC_PREFIX, "/".join(lp.split("/")[1:]))
        rows.append((host, u, lp, public, mirrored))
        if mirrored:
            targets.append(u)

    # --- 1) lista de objetivos de espejo
    tf = os.path.join(ROOT, "1_CODIGOORIGINAL", "mirror_targets.txt")
    with open(tf, "w", encoding="utf-8", newline="\n") as f:
        for u in targets:
            f.write(u + "\n")
    print("[OK] %d URLs objetivo -> %s" % (len(targets), tf))

    # --- 2) tabla markdown
    md = os.path.join(ROOT, "MAPA_REESCRITURA_URLS.md")
    with open(md, "w", encoding="utf-8", newline="\n") as f:
        f.write("# Mapa de Reescritura: URL Remota -> Localhost (CHUMOPLUS)\n\n")
        f.write("> Prefijo publico de produccion: `%s/`\n\n" % PUBLIC_PREFIX)
        f.write("> `ESPEJADO` = el archivo ya esta descargado en `CHUMOPLUS/mirror/`.\n\n")
        f.write("| # | Host | URL remota original | Ruta local espejo | URL produccion localhost | Estado |\n")
        f.write("| -: | :--- | :--- | :--- | :--- | :---: |\n")
        for i, (host, u, lp, pub, mirrored) in enumerate(rows, 1):
            state = "ESPEJADO" if mirrored else "externo"
            f.write("| %d | `%s` | `%s` | `%s` | `%s` | %s |\n"
                    % (i, host, u, lp, pub, state))
    print("[OK] tabla de reescritura -> %s (%d filas)" % (md, len(rows)))

    # --- 3) resumen por host
    print("\nResumen por host:")
    hosts = {}
    for host, u, lp, pub, mirrored in rows:
        hosts.setdefault(host, [0, 0])
        hosts[host][0] += 1
        hosts[host][1] += 1 if mirrored else 0
    for h in sorted(hosts, key=lambda x: -hosts[x][0]):
        tot, mir = hosts[h]
        print("  %-42s %3d URLs  (%d espejadas)" % (h, tot, mir))


if __name__ == "__main__":
    main()
