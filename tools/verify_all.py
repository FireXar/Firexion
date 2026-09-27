#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# =============================================================================
# Verificador de estado del proyecto CHUMOPLUS (Capas 1, 2 y 3)
# Modo: solo lectura. No ejecuta nada de bash.
# =============================================================================
import os
import re
import sys
import hashlib

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def sha256(path, n=2000000):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while True:
            b = f.read(65536)
            if not b:
                break
            h.update(b)
    return h.hexdigest()
def check_layer1():
    """Capa 1: originales requeridos."""
    req = [
        ("1_CODIGOORIGINAL/setup.txt", 3000000),
        ("1_CODIGOORIGINAL/pack_new.txt", 30000),
        ("1_CODIGOORIGINAL/pack3_tar.txt", 40000),
        ("1_CODIGOORIGINAL/styles_cpp.txt", 5000),
        ("1_CODIGOORIGINAL/control_tokens.txt", 50),
        ("1_CODIGOORIGINAL/SCRIPT_targz/menu", 1000000),
        ("1_CODIGOORIGINAL/github_repo/ADMcgh/Instalador/LATAM", 40000),
        ("1_CODIGOORIGINAL/github_repo/ADMcgh/Instalador/GPT/setup", 10000),
        ("1_CODIGOORIGINAL/github_repo/ScriptCGH/setup", 40000),
        ("1_CODIGOORIGINAL/github_repo/ChumoGH-Script/BOT/gerador/lista-arq", 300),
    ]
    print("=" * 76)
    print(" CAPA 1 (ORIGINALES)")
    print("=" * 76)
    bad = 0
    for rel, minsize in req:
        p = os.path.join(ROOT, rel)
        if os.path.isfile(p):
            sz = os.path.getsize(p)
            flag = "OK" if sz >= minsize else "TAMANO BAJO"
            print("  [%-12s] %9d  %s" % (flag, sz, rel))
        else:
            print("  [FALTA       ]           %s" % rel)
            bad += 1
    return bad
def check_layer2():
    """Capa 2: herramientas deben compilar."""
    import py_compile
    tools = [
        "deobf_type1_matrix.py", "deobf_type2_vars.py", "deobf_type2b_latam.py",
        "deobf_type2c_posicional.py", "deobf_type3_pack3.py",
        "deobf_type3b_param.py", "deobf_type4_superscript.py",
        "fetch_mirror.py", "extract_urls.py", "build_url_map.py",
        "inventory_repos.py", "verify_all.py",
    ]
    print("\n" + "=" * 76)
    print(" CAPA 2 (HERRAMIENTAS)")
    print("=" * 76)
    bad = 0
    for t in tools:
        p = os.path.join(ROOT, "2_CODIGOANALIZADO", t)
        if not os.path.isfile(p):
            print("  [FALTA] %s" % t)
            bad += 1
            continue
        try:
            py_compile.compile(p, doraise=True)
            print("  [OK] %s" % t)
        except Exception as e:
            print("  [ERROR] %s -> %s" % (t, e))
            bad += 1
    return bad
def readability(path):
    """% de bytes imprimibles en los primeros 8 KB."""
    with open(path, "rb") as f:
        d = f.read(8192)
    if not d:
        return 0.0
    ok = sum(1 for b in d if 32 <= b < 127 or b in (9, 10, 13))
    return ok / len(d)


def check_layer3():
    """Capa 3: volcados limpios, legibles y con su marca."""
    out = [
        ("setup_limpio.sh", "cryptic_transform"),
        ("pack_new_limpio.sh", "install_fim"),
        ("pack3_limpio.sh", ""),
        ("styles_limpio.sh", ""),
        ("LATAM_limpio.sh", "Install_key"),
        ("menu_limpio.sh", "mportas"),
        ("ScriptCGH_setup_limpio.sh", "cryptic_transform"),
    ]
    print("\n" + "=" * 76)
    print(" CAPA 3 (VOLCADOS LIMPIOS)")
    print("=" * 76)
    bad = 0
    for name, marca in out:
        p = os.path.join(ROOT, "3_CODIGOVOLCADOFINAL", name)
        if not os.path.isfile(p):
            print("  [FALTA] %s" % name)
            bad += 1
            continue
        r = readability(p)
        sz = os.path.getsize(p)
        txt = open(p, encoding="utf-8", errors="replace").read()
        mar = (marca in txt) if marca else True
        st = "OK" if (r > 0.85 and mar) else "REVISAR"
        if st != "OK":
            bad += 1
        print("  [%-7s] %8d  legib=%.2f  marca=%s  %s"
              % (st, sz, r, "SI" if mar else "NO", name))
    return bad
def check_mirror():
    """Verifica que el espejo local tenga los archivos clave."""
    key = [
        "mirror/github/main/Plugins/system/toolmaster.py",
        "mirror/github/main/Plugins/system/pack3.tar",
        "mirror/github/main/Plugins/system/SCRIPT.tar.gz",
        "mirror/github/main/Plugins/system/styles.cpp",
        "mirror/github/main/Plugins/WEB/plugin.html",
        "mirror/github/main/TOKENS/dinamicos/control",
        "mirror/github/main/version/v-new.log",
        "mirror/github/main/Instalador/LATAM",
        "mirror/github/main/Instalador/Control-IP",
        "mirror/github/main/BINARIOS/x86_64/add_new_user.bin",
        "mirror/github/main/BINARIOS/aarch64/add_new_user.bin",
        "mirror/github-extra/ChumoGH-ChumoGH-Script-master/msg-bar/msg",
        "mirror/github-extra/ChumoGH-ChumoGH-Script-master/ssl",
        "mirror/github-extra/ChumoGH-ChumoGH-Script-master/shadowsocks.sh",
        "mirror/github-extra/ChumoGH-ScriptCGH-main/setup",
        "mirror/plus.ltmcgh.site/pack_new",
        "mirror/plus.ltmcgh.site/main/control",
        "mirror/dropbox/root-pass.sh",
    ]
    print("\n" + "=" * 76)
    print(" ESPEJO LOCAL (mirror/)")
    print("=" * 76)
    bad = 0
    for rel in key:
        p = os.path.join(ROOT, rel)
        if os.path.isfile(p) and os.path.getsize(p) > 0:
            print("  [OK] %8d  %s" % (os.path.getsize(p), rel))
        else:
            print("  [FALTA]           %s" % rel)
            bad += 1
    return bad


if __name__ == "__main__":
    total = check_layer1() + check_layer2() + check_layer3() + check_mirror()
    print("\n" + "=" * 76)
    print(" RESULTADO: %s (%d problemas)" %
          ("TODO OK" if total == 0 else "REVISAR", total))
    print("=" * 76)
    sys.exit(1 if total else 0)
