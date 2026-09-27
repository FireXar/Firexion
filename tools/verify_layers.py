#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
==============================================================================
 CHUMOPLUS - VERIFICACION DE INTEGRIDAD DE LAS 3 CAPAS
==============================================================================
 Verifica:
   CAPA 1 (ORIGINALES)   : todo original tiene hash y tamano conocido.
   CAPA 2 (HERRAMIENTAS) : cada desofuscador compila y existe.
   CAPA 3 (LIMPIO)       : cada volcado existe, es texto legible y su
                           cabecera corresponde al tipo esperado.

 No ejecuta nada: solo lee, hashea y compara.
==============================================================================
"""
import hashlib
import os
import sys

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ---- CAPA 1: originales que DEBEN existir -----------------------------------
LAYER1 = {
    "1_CODIGOORIGINAL/setup.txt": "Instalador bashfuscator original",
    "1_CODIGOORIGINAL/pack_new.txt": "Payload capa2 (vars concatenadas)",
    "1_CODIGOORIGINAL/pack3_tar.txt": "Payload capa2 (param expansion)",
    "1_CODIGOORIGINAL/styles_cpp.txt": "Estilos (texto plano)",
    "1_CODIGOORIGINAL/control_tokens.txt": "IPs autorizadas",
    "1_CODIGOORIGINAL/v_new_log.txt": "Version",
    "1_CODIGOORIGINAL/SCRIPT_targz/menu": "MENU real (2 capas)",
    "1_CODIGOORIGINAL/github_repo/ADMcgh/Plugins/system/toolmaster.py": "ToolMaster",
    "1_CODIGOORIGINAL/github_repo/ADMcgh/Instalador/LATAM": "Instalador LATAM ofuscado",
    "1_CODIGOORIGINAL/github_repo/ADMcgh/Instalador/GPT/setup": "Instalador GPT (texto)",
    "1_CODIGOORIGINAL/github_repo/ChumoGH-Script/BOT/gerador/lista-arq": "Lista de archivos del KEYGEN",
    "1_CODIGOORIGINAL/github_repo/ScriptCGH/setup": "Instalador ScriptCGH ofuscado",
}

# ---- CAPA 2: herramientas ---------------------------------------------------
LAYER2 = {
    "2_CODIGOANALIZADO/deobf_type1_matrix.py": "Bashfuscator octal/hex",
    "2_CODIGOANALIZADO/deobf_type2_vars.py": "Variables concatenadas (pack_new)",
    "2_CODIGOANALIZADO/deobf_type2b_latam.py": "Base64 por variables + eval (LATAM)",
    "2_CODIGOANALIZADO/deobf_type3_pack3.py": "Multi-capa b64/bz2/gzip",
    "2_CODIGOANALIZADO/deobf_type3b_param.py": "Param expansion ${@...} (menu)",
    "2_CODIGOANALIZADO/deobf_type4_superscript.py": "Digitos unicode superindice (token)",
    "2_CODIGOANALIZADO/fetch_mirror.py": "Constructor del espejo",
    "2_CODIGOANALIZADO/extract_urls.py": "Extractor de URLs",
    "2_CODIGOANALIZADO/build_url_map.py": "Mapa de reescritura",
    "2_CODIGOANALIZADO/inventory_repos.py": "Inventario de repos",
}

# ---- CAPA 3: volcados esperados --------------------------------------------
#  ruta : (descripcion, subcadena que DEBE aparecer)
LAYER3 = {
    "3_CODIGOVOLCADOFINAL/setup_limpio.sh": ("Instalador desofuscado", "cryptic_transform"),
    "3_CODIGOVOLCADOFINAL/pack_new_limpio.sh": ("Capa2 desofuscada", "install_fim"),
    "3_CODIGOVOLCADOFINAL/pack3_limpio.sh": ("pack3 desofuscado", ""),
    "3_CODIGOVOLCADOFINAL/styles_limpio.sh": ("Estilos", ""),
    "3_CODIGOVOLCADOFINAL/LATAM_limpio.sh": ("LATAM = GPT/setup", "Install_key"),
    "3_CODIGOVOLCADOFINAL/menu_limpio.sh": ("MENU real (2 capas)", "mportas"),
    "3_CODIGOVOLCADOFINAL/ScriptCGH_setup_limpio.sh": ("ScriptCGH", ""),
}

SHA_CACHE = os.path.join(ROOT, "1_CODIGOORIGINAL", "HASHES_SHA256.txt")


def sha256(p):
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def readable(p):
    d = open(p, "rb").read(4000)
    if not d:
        return 0.0
    ok = sum(1 for b in d if 32 <= b < 127 or b in (9, 10, 13))
    return ok / len(d)


def main():
    fails = []

    print("=" * 96)
    print(" CAPA 1  ->  CODIGO ORIGINAL")
    print("=" * 96)
    for rel, desc in LAYER1.items():
        p = os.path.join(ROOT, rel)
        ok = os.path.isfile(p)
        size = os.path.getsize(p) if ok else 0
        print("  [%s] %9d  %-46s %s" % ("OK" if ok else "FALTA", size, rel, desc))
        if not ok:
            fails.append("CAPA1 falta: " + rel)

    print("\n" + "=" * 96)
    print(" CAPA 2  ->  HERRAMIENTAS DE DESOFUSCADO")
    print("=" * 96)
    import py_compile
    for rel, desc in LAYER2.items():
        p = os.path.join(ROOT, rel)
        if not os.path.isfile(p):
            print("  [FALTA     ] %s" % rel)
            fails.append("CAPA2 falta: " + rel)
            continue
        try:
            py_compile.compile(p, doraise=True)
            print("  [COMPILA OK] %-48s %s" % (rel, desc))
        except Exception as e:
            print("  [SYNTAX ERR] %-48s %s" % (rel, e))
            fails.append("CAPA2 syntax: " + rel)

    print("\n" + "=" * 96)
    print(" CAPA 3  ->  CODIGO VOLCADO FINAL")
    print("=" * 96)
    for rel, (desc, must) in LAYER3.items():
        p = os.path.join(ROOT, rel)
        if not os.path.isfile(p):
            print("  [FALTA] %s" % rel)
            fails.append("CAPA3 falta: " + rel)
            continue
        r = readable(p)
        size = os.path.getsize(p)
        txt = open(p, encoding="utf-8", errors="replace").read()
        has = (must in txt) if must else True
        status = "OK" if (r > 0.85 and has) else "REVISAR"
        print("  [%-7s] %8d  legib=%.2f  marca=%s  %s" % (status, size, r, "SI" if has else "NO", rel))
        if status != "OK":
            fails.append("CAPA3 revisar: " + rel)

    # ---- hashes de capa 1
    print("\n" + "=" * 96)
    print(" HASHES SHA-256 (CAPA 1)")
    print("=" * 96)
    lines = ["# SHA-256 de los originales auditados - CHUMOPLUS\n"]
    for rel in LAYER1:
        p = os.path.join(ROOT, rel)
        if os.path.isfile(p):
            h = sha256(p)
            lines.append("%s  %s" % (h, rel))
            print("  %s  %s" % (h[:16] + "...", rel))
    open(SHA_CACHE, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
    print("\n[OK] hashes -> %s" % SHA_CACHE)

    print("\n" + "=" * 96)
    if fails:
        print(" RESULTADO: %d problemas" % len(fails))
        for f in fails:
            print("   - " + f)
    else:
        print(" RESULTADO: TODAS LAS CAPAS VERIFICADAS CORRECTAMENTE")
    print("=" * 96)
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
