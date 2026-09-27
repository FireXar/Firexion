import re
p = "1_CODIGOORIGINAL/github_repo/ScriptCGH/setup"
t = open(p, encoding="utf-8", errors="replace").read()
evs = [l for l in t.splitlines() if l.lstrip().startswith("eval")]
print("lineas eval:", len(evs))
for e in evs:
    print("  len=%d head=%r tail=%r" % (len(e), e[:80], e[-60:]))

decl = re.findall(r"([A-Za-z_][A-Za-z0-9_]*)='([A-Za-z0-9+/=]*)'", t)
vals = {}
for n, v in decl:
    vals.setdefault(n, v)
print("assigns:", len(decl), "unicos:", len(vals))

for e in evs:
    order = re.findall(r"\$([A-Za-z_][A-Za-z0-9_]*)", e)
    miss = [n for n in dict.fromkeys(order) if n not in vals]
    print("eval con %d tokens, %d unicos, faltan %d: %s" % (
        len(order), len(set(order)), len(miss), miss[:12]))
    blob = "".join(vals.get(n, "") for n in order)
    print("   blob %d chars, marcador #! en %d, head=%r" % (
        len(blob), blob.find("IyEv"), blob[:60]))
