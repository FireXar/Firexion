#!/usr/bin/env python3
"""
==============================================================================
Desofuscador Tipo 2: Sustitución de Variables Concatenadas (pack_new)
Modo: Análisis Estático Seguro (0% Ejecución en Shell)
==============================================================================
"""

import re
import os
import sys

def deobfuscate_pack_new(input_path, output_path):
    print(f"[*] Leyendo archivo ofuscado Tipo 2: {input_path}")
    with open(input_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # Separar líneas
    lines = content.splitlines()
    print(f"[*] Total de líneas en archivo original: {len(lines)}")

    # Diccionario de variables
    var_dict = {"z": "\n"}

    # Extraer asignaciones de variables
    # Patrones: VAR='VAL' o VAR="VAL"
    # Ojo: los valores pueden contener comillas escapadas como '\''
    print("[*] Parseando diccionario de variables...")
    
    # Buscar todas las asignaciones VAR=...
    # Un patrón robusto para Bash: ([a-zA-Z0-9_]+)=('(?:''|[^'])*'|"(?:\\.|[^"\\])*")
    var_pattern = re.compile(r'([a-zA-Z0-9_]+)=(?:(?P<sq>\'(?:[^\']|\'\\\'\')*\')|(?P<dq>"(?:[^"\\]|\\.)*"))')
    
    # También podemos buscar de forma secuencial
    matches = var_pattern.finditer(content)
    count = 0
    for m in matches:
        var_name = m.group(1)
        if m.group('sq') is not None:
            raw_val = m.group('sq')[1:-1]
            # En bash 'wk '\'' ' se convierte a wk '' en el interior
            val = raw_val.replace("'\\''", "'")
        elif m.group('dq') is not None:
            raw_val = m.group('dq')[1:-1]
            val = bytes(raw_val, "utf-8").decode("unicode_escape", errors="ignore")
        else:
            continue
            
        var_dict[var_name] = val
        count += 1

    print(f"[+] Se extrajeron {len(var_dict):,} definiciones de variables.")

    # Buscar la línea del eval: eval "$Az$Bz..."
    eval_match = re.search(r'eval\s+"([^"]+)"', content)
    if not eval_match:
        # Si eval usa comillas simples o sin comillas
        eval_match = re.search(r'eval\s+["\']?(\$[a-zA-Z0-9_$]+)', content)
        
    if not eval_match:
        print("[!] No se encontró eval explícito con regex simple, buscando la secuencia de variables...")
        # Tomar la última línea que tenga $...$...
        for line in reversed(lines):
            if line.count('$') > 50:
                eval_str = line
                if eval_str.startswith('eval "') and eval_str.endswith('"'):
                    eval_str = eval_str[6:-1]
                break
    else:
        eval_str = eval_match.group(1)

    print(f"[*] Reconstruyendo script concatenado (cadena de entrada: {len(eval_str):,} caracteres)...")

    # Reemplazar cada $VAR por su valor
    # En la cadena eval_str, los nombres están como $VAR
    def replace_var(match):
        vname = match.group(1)
        return var_dict.get(vname, f"${vname}")

    # Reemplazar variables con regex
    decoded_script = re.sub(r'\$([a-zA-Z0-9_]+)', replace_var, eval_str)

    print(f"[+] Tamaño del script desofuscado: {len(decoded_script):,} caracteres.")

    # Guardar en salida
    with open(output_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("#!/bin/bash\n")
        f.write("# Desofuscado Estáticamente por deobf_type2_vars.py\n")
        f.write(decoded_script)

    print(f"[OK] Archivo limpio guardado en: {output_path}")
    return decoded_script

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    root_dir = os.path.dirname(base_dir)
    in_file = os.path.join(root_dir, "1_CODIGOORIGINAL", "pack_new.txt")
    out_file = os.path.join(root_dir, "3_CODIGOVOLCADOFINAL", "pack_new_limpio.sh")
    
    deobfuscate_pack_new(in_file, out_file)
