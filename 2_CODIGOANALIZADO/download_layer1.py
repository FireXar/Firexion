#!/usr/bin/env python3
"""
Descargador Estático y Seguro para Capa 1 (1_CODIGOORIGINAL)
Descarga recursos vía HTTPS sin ejecutar código y genera hashes SHA-256.
"""

import urllib.request
import ssl
import hashlib
import os
import sys

URLS = [
    ("pack_new.txt", "https://plus.ltmcgh.site/pack_new"),
    ("pack3_tar.txt", "https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/pack3.tar"),
    ("styles_cpp.txt", "https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/styles.cpp"),
    ("control_tokens.txt", "https://raw.githubusercontent.com/ChumoGH/ADMcgh/refs/heads/main/TOKENS/dinamicos/control"),
    ("v_new_log.txt", "https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/version/v-new.log"),
]

def download_files(dest_dir):
    os.makedirs(dest_dir, exist_ok=True)
    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    
    headers = {"User-Agent": "Wget/1.20.3 (linux-gnu)"}
    
    results = []
    for filename, url in URLS:
        filepath = os.path.join(dest_dir, filename)
        print(f"[*] Descargando: {url} -> {filename}...")
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, context=ctx, timeout=15) as resp:
                data = resp.read()
                
            with open(filepath, "wb") as f:
                f.write(data)
                
            sha256 = hashlib.sha256(data).hexdigest()
            print(f"[OK] {filename}: {len(data):,} bytes | SHA256: {sha256[:16]}...")
            results.append((filename, url, len(data), sha256, "Descarga exitosa"))
        except Exception as e:
            print(f"[ERROR] Falló descarga de {url}: {e}")
            results.append((filename, url, 0, "", f"Error: {e}"))
            
    return results

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    target_dir = os.path.join(os.path.dirname(base_dir), "1_CODIGOORIGINAL")
    download_files(target_dir)
