import io
p = r"C:\xampp\htdocs\pkdlatamsrc\CHUMOPLUS\2_CODIGOANALIZADO\deobf_type2b_latam.py"
lines = open(p, encoding="utf-8").read().split("\n")
for i, l in enumerate(lines):
    if l.strip().startswith('""Decodifica'):
        lines[i] = "    # Decodifica un blob base64. Devuelve (texto, offset_cebo, cabecera_cebo)."
        print("linea %d reemplazada" % (i + 1))
open(p, "w", encoding="utf-8", newline="\n").write("\n".join(lines))
import py_compile
py_compile.compile(p, doraise=True)
print("COMPILA OK")
