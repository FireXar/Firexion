import os
fs = [
    "mirror/github/main/Plugins/system/pack.tar",
    "mirror/github/main/Plugins/system/pack2.tar",
    "mirror/github/main/Plugins/system/pack3.tar",
    "mirror/github/main/Plugins/system/SCRIPT.tar.gz",
    "mirror/github/main/version/v-ant.bin",
    "mirror/github/main/TOKENS/dinamicos/token",
]
for f in fs:
    d = open(f, "rb").read()
    print("%-56s %9d" % (f, len(d)))
    print("     head: %r" % d[:80])
    print("     tail: %r" % d[-40:])
    print()
