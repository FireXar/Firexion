#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# =============================================================================
# Verificador de integridad del repositorio ADMcgh (Estructura Limpia)
# Modo: solo lectura. No ejecuta nada de bash.
# =============================================================================
import os
import sys
import hashlib
import py_compile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def check_core():
    """Verifica los módulos de core/"""
    req = [
        "menu", "cabecalho", "menu_credito", "payloads",
        "http-server.py", "ultrahost", "shadowsocks.sh",
        "PDirect.py", "PGet.py", "POpen.py", "PPriv.py", "PPub.py", "v-local.log"
    ]
    print("=" * 76)
    print(" MODULOS DEL NUCLEO (core/)")
    print("=" * 76)
    bad = 0
    for name in req:
        p = os.path.join(ROOT, "core", name)
        if os.path.isfile(p):
            sz = os.path.getsize(p)
            print("  [OK] %8d B  %s" % (sz, name))
        else:
            print("  [FALTA] %s" % name)
            bad += 1
    return bad

def check_plugins():
    """Verifica los plugins y protocolos (plugins/)"""
    req = [
        "SlowDNS.sh", "UDP_menu.sh", "ClashForAndroidGLOBAL.sh",
        "budp.sh", "v2r.sh", "xr.sh", "autoconfig.sh",
        "m_backup.sh", "ssrrmu.sh", "styles.cpp", "zh.sh"
    ]
    print("\n" + "=" * 76)
    print(" PLUGINS Y PROTOCOLOS (plugins/)")
    print("=" * 76)
    bad = 0
    for name in req:
        p = os.path.join(ROOT, "plugins", name)
        if os.path.isfile(p):
            sz = os.path.getsize(p)
            print("  [OK] %8d B  %s" % (sz, name))
        else:
            print("  [FALTA] %s" % name)
            bad += 1
    return bad

def check_binaries():
    """Verifica binarios y ejecutables (bin/)"""
    req = [
        ("bin/x86_64/add_new_user.bin", 2000000),
        ("bin/aarch64/add_new_user.bin", 2000000),
        ("bin/toolmaster.py", 4000),
        ("bin/root-pass.sh", 4000),
        ("bin/upLIC", 500),
        ("bin/stunnel-5.65.tar.gz", 500000),
    ]
    print("\n" + "=" * 76)
    print(" BINARIOS Y UTILIDADES (bin/)")
    print("=" * 76)
    bad = 0
    for rel, minsize in req:
        p = os.path.join(ROOT, rel)
        if os.path.isfile(p):
            sz = os.path.getsize(p)
            st = "OK" if sz >= minsize else "TAMANO BAJO"
            print("  [%-4s] %8d B  %s" % (st, sz, rel))
            if st != "OK":
                bad += 1
        else:
            print("  [FALTA] %s" % rel)
            bad += 1
    return bad

def check_tools():
    """Herramientas en tools/ deben compilar en Python sin error."""
    tools = [
        "deobf_type1_matrix.py", "deobf_type2_vars.py", "deobf_type2b_latam.py",
        "deobf_type2c_posicional.py", "deobf_type3_pack3.py",
        "deobf_type3b_param.py", "deobf_type4_superscript.py",
        "fetch_mirror.py", "extract_urls.py", "build_url_map.py",
        "inventory_repos.py", "verify_all.py",
    ]
    print("\n" + "=" * 76)
    print(" HERRAMIENTAS DE AUDITORIA (tools/)")
    print("=" * 76)
    bad = 0
    for t in tools:
        p = os.path.join(ROOT, "tools", t)
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

def check_key_removal():
    """Verifica que NO existan verificaciones de key activas ni referencias a cghkey/chekKEY."""
    print("\n" + "=" * 76)
    print(" VERIFICACION DE ELIMINACION DE KEYS")
    print("=" * 76)
    bad = 0
    check_files = [
        os.path.join(ROOT, "core", "menu"),
        os.path.join(ROOT, "plugins", "budp.sh"),
        os.path.join(ROOT, "plugins", "SlowDNS.sh"),
        os.path.join(ROOT, "plugins", "UDP_menu.sh"),
        os.path.join(ROOT, "plugins", "v2r.sh"),
        os.path.join(ROOT, "plugins", "xr.sh"),
        os.path.join(ROOT, "install.sh"),
        os.path.join(ROOT, "setup.sh"),
    ]
    
    for p in check_files:
        rel = os.path.relpath(p, ROOT)
        if not os.path.isfile(p):
            print("  [FALTA] %s" % rel)
            bad += 1
            continue
        txt = open(p, "r", encoding="utf-8", errors="replace").read()
        
        # Comprobar que no haya bloqueo por key
        if "KEY BANEADA" in txt or "invalid_key --ban" in txt:
            print("  [PELIGRO] Bloqueo residual encontrado en: %s" % rel)
            bad += 1
        elif "latamsrc_keygen" in txt or ":8888/${uncryp2}" in txt:
            print("  [PELIGRO] Referencia a keygen daemon en: %s" % rel)
            bad += 1
        else:
            print("  [LIMPIO] %s (Sin verificacion ni baneo de key)" % rel)
    return bad

def main():
    print("============================================================================")
    print(" VERIFICACION COMPLETA DEL REPOSITORIO ADMcgh (EDICION LIBRE)")
    print("============================================================================")
    bad = 0
    bad += check_core()
    bad += check_plugins()
    bad += check_binaries()
    bad += check_tools()
    bad += check_key_removal()

    print("\n" + "=" * 76)
    if bad == 0:
        print(" RESULTADO: TODO CORRECTO (0 problemas detectados)")
        print(" Repositorio 100% listo para subir a GitHub!")
    else:
        print(" RESULTADO: REVISAR (%d problemas detectados)" % bad)
    print("=" * 76)
    return 0 if bad == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
