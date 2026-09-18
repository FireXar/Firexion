p = r"C:\xampp\htdocs\pkdlatamsrc\CHUMOPLUS\2_CODIGOANALIZADO\deobf_type3b_param.py"
src = open(p, encoding="utf-8").read()
fixes = [
    ('    ""Quita tokens, busca el bloque base64 mas largo y devuelve (texto, capa)."',
     '    # Quita tokens, busca el bloque base64 mas largo y devuelve (texto, capa).'),
    ('    ""Detecta si la salida es OTRA capa de ${@...} (ofuscado anidado)."',
     '    # Detecta si la salida es OTRA capa de ${@...} (ofuscado anidado).'),
]
for a, b in fixes:
    if a in src:
        src = src.replace(a, b)
        print("fix OK:", a[:50])
    else:
        print("NO ENCONTRADO:", a[:50])
open(p, "w", encoding="utf-8", newline="\n").write(src)
import py_compile
py_compile.compile(p, doraise=True)
print("COMPILA OK")
