import re

p = "1_CODIGOORIGINAL/github_repo/ScriptCGH/setup"
t = open(p, encoding="utf-8", errors="replace").read()
e = [l for l in t.splitlines() if l.lstrip().startswith("eval")][0]

# El patron del eval usa $Var; las vars que faltan son ${1..9} / $@ / $* => se omiten.
decl = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t)
vals = {}
for n, v in decl:
    vals.setdefault(n, v)

order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", e)
blob = "".join(vals.get(n, "") for n in order)
print("blob len:", len(blob))
print("head 400:", repr(blob[:400]))

# Ritmo: muchas palabras se ven cortadas (expo|EBIAONTEND|expo|ATH=)
# Probamos restaurar las letras que consumen los argumentos posicionales.
# Patron tipico: '$X' donde X es 1..9 -> el fragmento 'D' 'P' etc.
# Heuristica: insertar la letra del nombre de la var posicional.
letters = {}
for ch in "0123456789":
    letters[ch] = ch
print()
print("--- busqueda de marcadores ---")
for m in ["pipefail", "killall", "DEBIAN", "PATH=", "apt-get", "#!/bin"]:
    print("  %-10s en blob: %s" % (m, blob.find(m)))

# Reconstruccion con posicionales: recuperar los digitos del nombre de var
full = []
for n in order:
    if n in vals:
        full.append(vals[n])
    elif n.isdigit():
        full.append(n)
    else:
        # var no base64 (ej. $z vacio o $Bin) -> nada
        full.append("")
rec = "".join(full)
print("\ncon posicionales:", len(rec))
print("head 400:", repr(rec[:400]))
