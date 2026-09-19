#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 cghlatamsrc - BUILD DEL INSTALADOR PROPIO (repo SNIPER754186)
==============================================================================
 Toma los volcados de la Capa 3 y produce:

   4_INSTALACION/build/
        setup_latamsrc.sh      instalador principal (key fija latamsrcddev)
        pack_new_latamsrc.sh   capa 2 (instalador real, reescrito)
        pack3_latamsrc.sh      capa 2 fallback, reescrito
        menu_latamsrc.sh       menu real (SCRIPT.tar.gz -> menu)
        msg_latamsrc.sh        estilos/msg
        LATAM_latamsrc.sh      variante @Kalix1 (key fija compartida)

 Reescribe:
   - claves de descarga (ENLACES de msg, control, version) -> keygen local
   - bootstrap (pack_new / pack3)                          -> espejo propio
   - archivos de runtime (toolmaster, plugin.html, upLIC, BINARIOS)
   - key de instalacion -> se fuerza 'latamsrcddev' (no se pide teclado)

 NO ejecuta nada de bash: solo escribe ficheros.
==============================================================================
"""
import os
import re
import sys
import hashlib

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "3_CODIGOVOLCADOFINAL")
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "build")

# --- clave fija pedida por el usuario ---------------------------------------
FIXED_KEY = "latamsrcddev"

# --- endpoints del keygen propio --------------------------------------------
# Control-IP (lista de IPs autorizadas)
URL_CONTROL = "http://64.176.5.61:81/ChumoGH/control"
# IP:8888 -> registro de IP + devuelve la lista de arquitectura (lista-arq)
URL_GEN8888 = "http://64.176.5.61:8888"
# IP:81/<key>/<arch> -> descarga de cada modulo
URL_GEN81 = "http://64.176.5.61:81/latamsrcddev"
# lista-arq propia (modulos que se instalan)
URL_LISTA_ARQ = "http://64.176.5.61:81/ChumoGH/lista-arq"

RAW = "https://raw.githubusercontent.com/SNIPER754186/cghlatamsrc/main/CHUMOPLUS/mirror"

# URL remota -> URL nueva
RULES = [
    # bootstrap / control / version / repos
    ("https://plus.ltmcgh.site/pack_new",        RAW + "/plus.ltmcgh.site/pack_new"),
    ("https://plus.ltmcgh.site/ChumoGH/msg",     RAW + "/plus.ltmcgh.site/ChumoGH/msg"),
    ("https://plus.ltmcgh.site/main/control",    RAW + "/plus.ltmcgh.site/main/control"),
    ("https://www.dropbox.com/scl/fi/je70qpfmwu6416ail48zq/msg?rlkey=jg8eazt0p95pkq0xj4ckrrt1y",
                                                 RAW + "/dropbox/msg"),
    # GitHub principal (rama main / refs heads main)
    ("https://raw.githubusercontent.com/ChumoGH/ADMcgh/refs/heads/main/", RAW + "/github/main/"),
    ("https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/",           RAW + "/github/main/"),
    # repos extra
    ("https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/",
     RAW + "/github-extra/ChumoGH-ChumoGH-Script-master/"),
    ("https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/",
     RAW + "/github-extra/ChumoGH-ScriptCGH-main/"),
    # dropbox sueltos
    ("https://www.dropbox.com/s/hl9vyo8mf94z0h5/root-pass.sh", RAW + "/dropbox/root-pass.sh"),
]

# Parche 1: setup -> key fija (no pide teclado, no consulta /file)
PATCH_FUNKEY_OLD = """local _filtro=''
while [[ ! $_filtro ]]; do
clear"""
PATCH_FUNKEY_NEW = """local _filtro='%(key)s'
while [[ ! $_filtro ]]; do
clear"""

PATCH_READKEY_OLD = """echo "           PEGA TU KEY DE INSTALACION " | lolcat
msg -bar3
read -p "$(echo -e " \\033[1;41m Key : \\033[0;33m")" _filtro
#Key=$(echo -e ${_filtro} | tr -d '[[:space:]]')
clean_input="${_filtro}\""""
PATCH_READKEY_NEW = """echo "           KEY FIJA DE INSTALACION (latamsrc) " | lolcat
msg -bar3
_filtro='%(key)s'
#Key=$(echo -e ${_filtro} | tr -d '[[:space:]]')
clean_input="${_filtro}\""""

# Parche 2: /file cacheado -> siempre descargar control del keygen propio
PATCH_FILE_OLD = """[[ ! -e /file ]] && wget -q -O /file %(control)s
_double=$(cat < /file)"""
PATCH_FILE_NEW = """rm -f /file
wget -q --no-check-certificate --max-redirect=20 -O /file %(control)s
_double=$(cat < /file)"""

# Parche 3: el registro :81/checkIP.log -> keygen propio
PATCH_FOLTETO_OLD = """wget -q --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log"""
PATCH_FOLTETO_NEW = """wget -q --no-check-certificate -O /etc/folteto http://%(srv)s:81/ChumoGH/checkIP.log"""

# Parche 4: descriptor de la lista de modulos (keygen propio)
PATCH_KEY_OLD = """\t\t_key="${_checkBT}:8888/${uncryp2}/-SPVweN\""""
PATCH_KEY_NEW = """\t\t_key="%(srv)s:8888/${uncryp2}/-SPVweN\""""


def apply_rules(text, path):
    """Sustituye todas las URLs remotas por las del repo/espejo propio."""
    hits = []
    for old, new in RULES:
        n = text.count(old)
        if n:
            hits.append((old, n))
            text = text.replace(old, new)
    return text, hits


def sha256(t):
    return hashlib.sha256(t.encode("utf-8", "replace")).hexdigest()


def build_setup():
    p = os.path.join(SRC, "setup_limpio.sh")
    t = open(p, encoding="utf-8", errors="replace").read()
    t, hits = apply_rules(t, p)

    srv = URL_GEN81.split(":")[1][2:]  # 64.176.5.61
    control = URL_CONTROL

    subs = [
        (PATCH_FUNKEY_OLD, PATCH_FUNKEY_NEW),
        (PATCH_READKEY_OLD, PATCH_READKEY_NEW),
        (PATCH_FILE_OLD, PATCH_FILE_NEW),
        (PATCH_FOLTETO_OLD, PATCH_FOLTETO_NEW),
        (PATCH_KEY_OLD, PATCH_KEY_NEW),
    ]
    applied = []
    for old, new in subs:
        old_v = old % {"key": FIXED_KEY, "control": control, "srv": srv}
        new_v = new % {"key": FIXED_KEY, "control": control, "srv": srv}
        if old_v in t:
            t = t.replace(old_v, new_v)
            applied.append(True)
        else:
            applied.append(False)

    # cabecera de trazabilidad
    head = (
        "#!/bin/bash\n"
        "# ==========================================================================\n"
        "# setup_latamsrc.sh - instalador ADM linea LATAM (repo propio)\n"
        "# Generado por 4_INSTALACION/build_instalador.py\n"
        "# Repo  : https://github.com/SNIPER754186/cghlatamsrc\n"
        "# Espejo: %s\n"
        "# Key   : %s (fija)\n"
        "# Keygen: %s (puerto 81 y 8888)\n"
        "# ==========================================================================\n"
    ) % (RAW, FIXED_KEY, URL_GEN8888)
    return head + t, hits, applied


def build_simple(name, out_name, alias_note=""):
    p = os.path.join(SRC, name)
    t = open(p, encoding="utf-8", errors="replace").read()
    t, hits = apply_rules(t, p)
    head = (
        "#!/bin/bash\n"
        "# %s - volcado reescrito al repo propio\n"
        "# Generado por 4_INSTALACION/build_instalador.py | key fija: %s\n"
        "# %s\n"
    ) % (out_name, FIXED_KEY, alias_note)
    return head + t, hits


def main():
    os.makedirs(OUT, exist_ok=True)
    report = []

    # ---- menu: conserva sin shebang (como el original) ----
    menu_txt, menu_hits = build_simple("menu_limpio.sh", "menu_latamsrc.sh",
                                       "sin shebang a proposito: se copia tal cual a /etc/adm-lite/menu")
    open(os.path.join(OUT, "menu_latamsrc.sh"), "w", encoding="utf-8").write(menu_txt)
    report.append(("menu_latamsrc.sh", menu_hits, menu_txt))

    setup_txt, setup_hits, applied = build_setup()
    open(os.path.join(OUT, "setup_latamsrc.sh"), "w", encoding="utf-8").write(setup_txt)
    report.append(("setup_latamsrc.sh", setup_hits, setup_txt))

    for src, dst, note in [
        ("pack_new_limpio.sh", "pack_new_latamsrc.sh", "capa 2 - instalador real"),
        ("pack3_limpio.sh", "pack3_latamsrc.sh", "capa 2 - fallback"),
        ("styles_limpio.sh", "msg_latamsrc.sh", "estilos msg/print_center/tittle"),
        ("LATAM_limpio.sh", "LATAM_latamsrc.sh", "variante @Kalix1 / NetVPS"),
    ]:
        t, hits = build_simple(src, dst, note)
        open(os.path.join(OUT, dst), "w", encoding="utf-8").write(t)
        report.append((dst, hits, t))

    # ---- informe ----
    print("=" * 78)
    print(" BUILD DEL INSTALADOR PROPIO  (key fija: %s)" % FIXED_KEY)
    print("=" * 78)
    for name, hits, txt in report:
        print("\n[%s]  %d bytes  sha256=%s" % (name, len(txt), sha256(txt)[:16]))
        for old, n in hits:
            print("    %2dx  %s" % (n, old[:96]))
    print("\nParches del setup (key fija / keygen propio):")
    for i, ok in enumerate(applied, 1):
        print("   patch %d: %s" % (i, "APLICADO" if ok else "NO ENCONTRADO"))
    faltan = [n for n, h, t in report if not h]
    if faltan:
        print("\n[AVISO] sin sustituciones: %s" % ", ".join(faltan))
    print("\nSalida -> %s" % OUT)
    return 0


if __name__ == "__main__":
    sys.exit(main())
