import os

base = "1_CODIGOORIGINAL/SCRIPT_targz"
for name in sorted(os.listdir(base)):
    p = os.path.join(base, name)
    if not os.path.isfile(p):
        continue
    d = open(p, "rb").read()
    head = d[:120]
    # heuristica de tipo
    if d[:2] == b"\x7f\x45":
        kind = "ELF"
    elif d[:2] == b"#!":
        kind = "SCRIPT(bash)"
    elif head.lstrip().startswith(b"python"):
        kind = "PYTHON"
    else:
        kind = "?"
    print("%-18s %9d  %-12s %r" % (name, len(d), kind, head[:70]))
