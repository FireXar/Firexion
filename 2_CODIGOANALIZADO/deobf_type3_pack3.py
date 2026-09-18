#!/usr/bin/env python3
"""
==============================================================================
Desofuscador Tipo 3: Decodificador Multi-Capa Base64/BZIP2/GZIP (pack3.tar)
Modo: Análisis Estático Seguro (0% Ejecución en Shell)
==============================================================================
"""

import os
import sys
import re
import base64
import bz2
import gzip

def deobfuscate_pack3(input_path, output_path):
    print(f"[*] Leyendo archivo ofuscado Tipo 3: {input_path}")
    with open(input_path, "r", encoding="utf-8", errors="ignore") as f:
        text = f.read()

    print("[*] Capa 1: Extrayendo Base64 de BZIP2...")
    m = re.search(r"'(QlpoOTFBWSZTW[A-Za-z0-9+/=]+)'", text)
    if not m:
        # Búsqueda alternativa por longitud
        m = re.search(r"([A-Za-z0-9+/=]{5000,})", text)
        
    if not m:
        raise ValueError("No se encontró el bloque Base64 BZIP2 en la Capa 1.")

    b64_layer1 = m.group(1)
    print(f"[+] Bloque Base64 Capa 1 encontrado: {len(b64_layer1):,} caracteres.")
    
    print("[*] Capa 1: Descomprimiendo BZIP2...")
    compressed_layer1 = base64.b64decode(b64_layer1)
    layer2_raw = bz2.decompress(compressed_layer1).decode("utf-8", errors="ignore")
    print(f"[+] Capa 2 extraída: {len(layer2_raw):,} caracteres.")

    print("[*] Capa 2: Extrayendo Base64 de GZIP...")
    m2 = re.search(r"([A-Za-z0-9+/=]{1000,})", layer2_raw)
    if not m2:
        raise ValueError("No se encontró el bloque Base64 GZIP en la Capa 2.")

    b64_layer2 = m2.group(1)
    print(f"[+] Bloque Base64 Capa 2 encontrado: {len(b64_layer2):,} caracteres.")

    print("[*] Capa 2: Descomprimiendo GZIP...")
    compressed_layer2 = base64.b64decode(b64_layer2)
    layer3_bytes = gzip.decompress(compressed_layer2)
    print(f"[+] Capa 3 (Código Final) desempacada: {len(layer3_bytes):,} bytes.")

    with open(output_path, "wb") as f:
        f.write(layer3_bytes)

    print(f"[OK] Archivo final limpio guardado en: {output_path}")
    return layer3_bytes

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    root_dir = os.path.dirname(base_dir)
    in_file = os.path.join(root_dir, "1_CODIGOORIGINAL", "pack3_tar.txt")
    out_file = os.path.join(root_dir, "3_CODIGOVOLCADOFINAL", "pack3_limpio.sh")
    
    deobfuscate_pack3(in_file, out_file)
