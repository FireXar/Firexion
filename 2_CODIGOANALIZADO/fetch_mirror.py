#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - Constructor de ESPEJO LOCAL (mirror) de todos los recursos remotos
==============================================================================
 Modo: SOLO DESCARGA ESTATICA. NO ejecuta nada. NO interpreta bash.
 Objetivo:
   Copiar cada URL remota detectada en los scripts auditados a una carpeta
   local, de modo que las rutas publicas de produccion queden como:
       http://localhost/pkdlatamsrc/CHUMOPLUS/mirror/<ruta original>

 Mapeo de URL -> ruta local:
   https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/A/B  -> mirror/github/main/A/B
   https://plus.ltmcgh.site/A/B                              -> mirror/plus.ltmcgh.site/A/B
   https://www.dropbox.com/scl/fi/xxx/msg?rlkey=y            -> mirror/dropbox/msg
   http://<IP_GENERADOR>:81/key/arch                         -> mirror/keygen81/<arch>

 Uso:
   php ..\\php-cli-wrapper  (no requiere PHP)  ->  usar python de XAMPP:
   C:\\xampp\\php\\php.exe no aplica; usar el interprete Python disponible.
==============================================================================
"""
import os
import re
import ssl
import sys
import urllib.request

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # CHUMOPLUS/
MIRROR = os.path.join(BASE, "mirror")
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Auditoria-Estatica-Local"

CTX = ssl.create_default_context()
CTX.check_hostname = False
CTX.verify_mode = ssl.CERT_NONE

# ---------------------------------------------------------------------------
# 1) Repositorio GitHub principal (rama main) - archivos sueltos via raw
# ---------------------------------------------------------------------------
RAW = "https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/"

# --- Repos adicionales del ecosistema ChumoGH (raw de ramas master/main) ---
EXTRA_RAW = [
    # ChumoGH-Script (rama master)
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/ssl",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/shadowsocks.sh",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/manager",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/lista-arq",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/sourcesfix.sh",
    "https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/swap.sh",
    # ScriptCGH
    "https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/setup",
    "https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/IMG/icon.ico",
    "https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/CLASH/ClashForAndroidGLOBAL.sh",
]

GITHUB_FILES = [
    # Plugins / system  (los nucleo ya auditados)
    "Plugins/system/toolmaster.py",
    "Plugins/system/styles.cpp",
    "Plugins/system/pack.tar",
    "Plugins/system/pack2.tar",
    "Plugins/system/pack3.tar",
    "Plugins/system/SCRIPT.tar.gz",
    "Plugins/system/hysteria.service",
    # Plugins / WEB
    "Plugins/WEB/plugin.html",
    "Plugins/WEB/index.html",
    "Plugins/WEB/gen-backend.js",
    "Plugins/WEB/hora.js",
    "Plugins/WEB/icon.PNG",
    # Plugins / V2ray
    "Plugins/V2ray/api_v2ray.py",
    "Plugins/V2ray/go.sh",
    "Plugins/V2ray/v2r.sh/adduser.bin",
    "Plugins/V2ray/v2r.sh/v2r.bin",
    "Plugins/V2ray/v2r.sh/xr.bin",
    # Plugins raiz
    "Plugins/budp.sh",
    "Plugins/config.json",
    "Plugins/SlowDNS.sh",
    "Plugins/UDP_menu.sh",
    "Plugins/HCR",
    "Plugins/authSSH",
    "Plugins/autoStart",
    # Plugins / Extras
    "Plugins/Extras/blockT.sh",
    "Plugins/Extras/fai2ban.sh",
    "Plugins/Extras/flouds.sh",
    "Plugins/Extras/flouds_etx.sh",
    "Plugins/Extras/RUsersAUTO.sh",
    "Plugins/Extras/zh.sh",
    "Plugins/Extras/server.key",
    "Plugins/Extras/server.pub",
    "Plugins/Extras/aarch64/killram.sh",
    "Plugins/Extras/x86_64/killram.sh",
    # Instalador
    "Instalador/LATAM",
    "Instalador/Control-IP",
    "Instalador/GPT/setup",
    "Instalador/autoStart",
    # Tokens / versiones  (los que MAS se consultan en runtime)
    "TOKENS/dinamicos/control",
    "TOKENS/dinamicos/token",
    "TOKENS/cache.sh",
    "TOKENS/BackupOnline.sh",
    "version/v-new.log",
    "version/v-ant.bin",
    # Repositorios apt (.list por version de distro)
    "Repositorios/8.list",
    "Repositorios/9.list",
    "Repositorios/10.list",
    "Repositorios/11.list",
    "Repositorios/12.list",
    "Repositorios/14.04.list",
    "Repositorios/16.04.list",
    "Repositorios/18.04.list",
    "Repositorios/20.04.list",
    "Repositorios/20.10.list",
    "Repositorios/21.04.list",
    "Repositorios/21.10.list",
    "Repositorios/22.04.list",
    # Binarios gestion de usuarios (los del script pack_new)
    "BINARIOS/x86_64/add_new_user.bin",
    "BINARIOS/aarch64/add_new_user.bin",
    "BINARIOS/x86_64/atoken_setup.bin",
    "BINARIOS/aarch64/atoken_setup.bin",
    "BINARIOS/cache.bin",
    "BINARIOS/Cjson_USERS.bin",
    "BINARIOS/readme.md",
    # Raiz
    "costos",
    "c123",
]

# Rutas exactas tal como las escribe el instalador en runtime
RUNTIME_OTHERS = [
    ("https://plus.ltmcgh.site/setup",            "plus.ltmcgh.site/setup"),
    ("https://plus.ltmcgh.site/pack_new",         "plus.ltmcgh.site/pack_new"),
    ("https://plus.ltmcgh.site/ChumoGH/msg",      "plus.ltmcgh.site/ChumoGH/msg"),
    ("https://plus.ltmcgh.site/main/control",     "plus.ltmcgh.site/main/control"),
    ("https://www.dropbox.com/scls/hl9vyo8mf94z0h5/root-pass.sh",
     "dropbox/root-pass.sh"),
    ("https://www.dropbox.com/s/hl9vyo8mf94z0h5/root-pass.sh",
     "dropbox/root-pass.sh"),
    ("https://www.dropbox.com/scl/fi/je70qpfmwu6416ail48zq/msg?rlkey=jg8eazt0p95pkq0xj4ckrrt1y",
     "dropbox/msg"),
]

# Nombres de archivo clave dentro de BINARIOS/ (para el inventario de espejo)
BIN_TREE = ["BINARIOS/x86_64", "BINARIOS/aarch64"]


def fetch(url, dest, timeout=60):
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    if os.path.exists(dest) and os.path.getsize(dest) > 0:
        return "SKIP", os.path.getsize(dest)
    try:
        req = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
            data = r.read()
        if not data:
            return "EMPTY", 0
        with open(dest, "wb") as f:
            f.write(data)
        return "OK", len(data)
    except Exception as e:
        return "FAIL(%s)" % type(e).__name__, 0


def main():
    results = []
    print("[*] Espejo GitHub (raw main) -> %s" % os.path.join(MIRROR, "github", "main"))
    for rel in GITHUB_FILES:
        url = RAW + rel.replace("\\", "/")
        dest = os.path.join(MIRROR, "github", "main", *rel.split("/"))
        st, size = fetch(url, dest)
        results.append((st, size, url, dest))
        print("  [%-12s] %8s  %s" % (st, size, rel))

    # Repos adicionales del ecosistema (ChumoGH-Script / ScriptCGH)
    print("[*] Espejo repos extra (ChumoGH-Script / ScriptCGH)")
    for full in EXTRA_RAW:
        # ruta local = <usuario-repo-rama>/<resto>
        m = re.match(r"https?://raw\.githubusercontent\.com/([^/]+)/([^/]+)/([^/]+)/(.*)$", full)
        if not m:
            continue
        repo_dir = "%s-%s-%s" % (m.group(1), m.group(2), m.group(3))
        rel = os.path.join(repo_dir, *m.group(4).split("/"))
        dest = os.path.join(MIRROR, "github-extra", *rel.split(os.sep))
        st, size = fetch(full, dest)
        results.append((st, size, full, dest))
        print("  [%-12s] %8s  %s" % (st, size, rel))

    print("[*] Espejo de otros orígenes (plus/dropbox)")
    for url, rel in RUNTIME_OTHERS:
        dest = os.path.join(MIRROR, *rel.split("/"))
        st, size = fetch(url, dest)
        results.append((st, size, url, dest))
        print("  [%-12s] %8s  %s" % (st, size, url))

    ok = sum(1 for r in results if r[0] == "OK")
    skip = sum(1 for r in results if r[0] == "SKIP")
    fail = [r for r in results if r[0].startswith("FAIL") or r[0] == "EMPTY"]
    print("\n[RESUMEN] OK=%d  SKIP=%d  FALLOS=%d  (total %d)" % (ok, skip, len(fail), len(results)))
    for r in fail:
        print("  !! %s  <- %s" % (r[0], r[2]))
    return 0 if not fail else 2


if __name__ == "__main__":
    sys.exit(main())
