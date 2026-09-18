import re
p = r"C:\xampp\htdocs\pkdlatamsrc\CHUMOPLUS\1_CODIGOORIGINAL\URLS_DETECTADAS.txt"
raw = open(p, "rb").read()
print("bytes:", len(raw))
print("primeros 200 bytes:", raw[:200])
txt = raw.decode("utf-8", "replace")
lines = txt.splitlines()
print("lineas:", len(lines))
http = [l for l in lines if l.strip().startswith("http")]
print("lineas que empiezan con http:", len(http))
for l in http[:5]:
    print("   %r" % l)
print("...")
# muestra de lineas no vacias
nonempty = [l for l in lines if l.strip()]
print("no vacias:", len(nonempty))
for l in nonempty[20:30]:
    print("   %r" % l[:100])
