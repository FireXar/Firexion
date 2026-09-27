import re

p = "1_CODIGOORIGINAL/github_repo/ScriptCGH/setup"
t = open(p, encoding="utf-8", errors="replace").read()

# Buscar el `set --` o definiciones de posicionales al principio
for pat in [r"set\s+--[^\n]*", r"set\s+-\s*--[^\n]*", r"\$1[^\n]{0,80}"]:
    ms = re.findall(pat, t)
    print("patron %r -> %d coincidencias" % (pat, len(ms)))
    for m in ms[:6]:
        print("    %r" % m[:300])

# Ver las primeras 3 lineas crudas
print("\n--- primeras 1000 chars del archivo ---")
print(repr(t[:1000]))

# Buscar nombres de variable estilo Bin1/Bin2.. que suelen ser los posicionales
cands = re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*[0-9])=['\"]", t)
print("\nvars con digito final:", sorted(set(cands))[:40])
