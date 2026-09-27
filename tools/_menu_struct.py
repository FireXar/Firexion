import re

p = "1_CODIGOORIGINAL/SCRIPT_targz/menu"
t = open(p, encoding="utf-8", errors="replace").read()
print("len:", len(t), "lineas:", t.count("\n") + 1)

# como esta estructurado: lineas y longitud
lines = t.split("\n")
lens = sorted(((len(l), i) for i, l in enumerate(lines)), reverse=True)[:8]
print("lineas mas largas (len, idx):", lens[:8])
print("primeras 5 lineas:")
for l in lines[:5]:
    print("   %r" % l[:150])

# buscar marcadores conocidos de la tecnica
for tok in ["dGVKM", "${@/", "${*", "eval", "base64", "\\x", "printf", "B64"]:
    print("contiene %-10r : %s (idx %d)" % (tok, tok in t, t.find(tok)))

# ultimas 3 lineas
print("ultimas 3 lineas:")
for l in lines[-3:]:
    print("   %r" % l[:200])

# distribucion: cuantos bloques de espacios?
sp = re.findall(r"[ \t]{20,}", t)
print("bloques de espacios >=20:", len(sp), "| total chars espacios:", sum(len(s) for s in sp))
# tokens tipo ${@...
pat = re.findall(r"\$\{[@*][^{}]{0,40}\}", t)
print("tokens ${@...}:", len(pat), pat[:10])
