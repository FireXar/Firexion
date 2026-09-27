#!/usr/bin/env python3
"""
==============================================================================
Script de Volcado Seguro y Análisis Estático de Instaladores Bash Ofuscados
Autor: Auditoría de Seguridad Local
Modo: Solo Lectura / Análisis Estático Puro (0% Ejecución de Shell)
==============================================================================
"""

import re
import sys
import os

# Mapeo de variables a dígitos base
DIGIT_MAP = {
    "_____": "0",
    "__________": "1",
    "___________________": "2",
    "__________________________": "3",
    "_______________": "4",
    "_________________________": "5",
    "____________": "6",
    "________________": "7",
    "________________________": "8",
    "__________________": "9"
}

def decode_token(t):
    """Decodifica un token octal o hexadecimal ofuscado a su caracter ASCII/UTF-8."""
    is_hex = False
    if '${_______[$________________________]}' in t:
        is_hex = True
        t = t.replace('${_______[$________________________]}', '')
    
    # Reemplazar variables más largas primero para evitar colisiones
    for var, digit in sorted(DIGIT_MAP.items(), key=lambda x: -len(x[0])):
        t = t.replace('$' + var, digit)
        t = t.replace('${' + var + '}', digit)
    
    digits = re.sub(r'[^0-9a-fA-F]', '', t)
    if not digits:
        return ''
    
    try:
        if is_hex:
            val = int(digits, 16)
        else:
            val = int(digits, 8)
        return chr(val)
    except Exception:
        return ''

def deobfuscate_file(input_path, output_path):
    print(f"[*] Leyendo archivo ofuscado: {input_path}")
    with open(input_path, "r", encoding="utf-8", errors="ignore") as f:
        text = f.read()

    pos = text.find(';${_______[$_____]} "$(')
    if pos == -1:
        # Si no tiene el patrón exacto, buscar el inicio de tokens
        pos = text.find('"\\\\')
    
    subshell = text[pos:] if pos != -1 else text
    print(f"[*] Extrayendo tokens ofuscados...")
    tokens = re.findall(r'"\\\\([^"]+)"', subshell)
    print(f"[+] Se encontraron {len(tokens):,} tokens codificados.")

    print(f"[*] Decodificando tokens a texto plano...")
    decoded_chars = [decode_token(t) for t in tokens]
    decoded_text = "".join(decoded_chars)

    with open(output_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(decoded_text)

    print(f"[OK] Volcado completo guardado exitosamente en: {output_path}")
    print(f"[+] Tamaño del código desofuscado: {len(decoded_text):,} caracteres / {len(decoded_text.splitlines()):,} líneas.")
    return decoded_text

if __name__ == "__main__":
    current_dir = os.path.dirname(os.path.abspath(__file__))
    input_file = os.path.join(current_dir, "setup.txt")
    output_file = os.path.join(current_dir, "setup_volcado.txt")
    
    if not os.path.exists(input_file):
        input_file = os.path.join(current_dir, "setup")
    
    if not os.path.exists(input_file):
        print(f"[ERROR] No se encontró 'setup.txt' ni 'setup' en {current_dir}")
        sys.exit(1)
        
    deobfuscate_file(input_file, output_file)
