#!/bin/bash
# ============================================================
#   SETUP CRYPTO TOOL
#   Descifra / Cifra el formato "setup" (ofuscación de variables
#   de guiones bajos + arrays + auto-reensamblado).
#
#   [1] Descifrar : extrae el codigo plano EJECUTANDO el archivo
#                   DENTRO de un sandbox aislado (rootfs overlay
#                   COW, sin red, sin capacidades peligrosas).
#                   Nada toca el sistema real.
#   [2] Cifrar    : genera un archivo del mismo estilo que el
#                   formato setup a partir de un script plano.
#
#   Uso directo:  setup_crypto.sh dec <entrada> <salida>
#                 setup_crypto.sh enc <entrada> <salida>
# ============================================================

CSCRIPT="$0"
R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; V='\033[1;36m'; BN='\033[1;34m'; N='\033[0m'
RST="\033[0m"

banner() {
  clear 2>/dev/null || true
  echo -e "${BN}  ╔════════════════════════════════════════════╗${N}"
  echo -e "${BN}  ║        SETUP  CRYPTO  TOOL                 ║${N}"
  echo -e "${BN}  ║   Descifra / Cifra el formato 'setup'      ║${N}"
  echo -e "${BN}  ╚════════════════════════════════════════════╝${N}"
}

die() { echo -e "${R}[!] $*${N}" >&2; exit 1; }

need_root() { [ "$(id -u)" = 0 ] || die "Requiere privilegios root (usado solo para aislar el sandbox)."; }

check_tools() {
  for t in unshare strace capsh setpriv timeout; do
    command -v "$t" >/dev/null 2>&1 || die "Falta la herramienta '$t'. Instala con: apt install -y strace libcap-ng-utils coreutils"
  done
  # prueba de soporte overlayfs (solo lectura de parametros)
  local t
  t=$(mktemp -d)
  mkdir -p "$t/m" "$t/u" "$t/w"
  if ! mount -t overlay overlay -o "lowerdir=/,upperdir=$t/u,workdir=$t/w" "$t/m" >/dev/null 2>&1; then
    rm -rf "$t"; die "El kernel no soporta overlayfs/mount namespaces (no se puede aislar)."
  fi
  umount "$t/m" >/dev/null 2>&1; rm -rf "$t"
}

# ------------------------------------------------------------
# Motor de cifrado V2 (plain -> archivo estilo setup, CHUNKED)
#   El payload se fracciona en N lineas '___dataN=$(printf %b ...)'
#   y se reensambla con una funcion '___echo(){ printf '%s' a b c ; }'.
#   Evita el limite de una sola linea/ARG_MAX para payloads grandes y
#   garantiza round-trip byte-idéntico para cualquier entrada
#   (texto, binario, sin shebang, con 'exit' en medio).
# ------------------------------------------------------------
encrypt_engine() {
  [ -f "$1" ] || die "No existe '$1'"
  local IN="$1" OUT="$2" OUTC
  OUTC=$(python3 - "$IN" "$OUT" <<'PYEOF'
import sys, random, gzip, base64
src = sys.argv[1]; dst = sys.argv[2]
data = open(src,'rb').read()
gz = gzip.compress(data)
b64 = base64.b64encode(gz).decode('ascii')
octal = ''.join('\\%03o' % b for b in b64.encode('ascii'))

CH = 24000   # chars por fragmento (~24 KB/linea, muy por debajo de limites)
def chunk(s, n):
    return [s[i:i+n] for i in range(0, len(s), n)]

random.seed()
def un(n): return '_'*n
lines = []
lines.append('#!/bin/bash')
# -- bloque de contadores estilo setup (decorativo) --
names = [4,5,10,19,26,15,29,12,16,22,18,8,24,17,21,11,13,9,14,7]
first = "(____=`_(){ :; };:`;"
mid = []
for k,n in enumerate(names):
    nm = un(n+2)
    expr = random.choice(['%s=$((____++))', '%s=$[____++]']) % nm
    if k == 0:
        mid.append(expr)
    else:
        mid.append(random.choice([';','&&']) + expr)
lines.append(first + ''.join(mid) + ";)")
# -- alfabeto decorativo --
lines.append('____________________________=({A..a})')
# -- payload real (fragmentado) --
parts = chunk(octal, CH)
for i, p in enumerate(parts):
    lines.append('___data%d=$(printf \'%%b\' \'%s\')' % (i, p))
args = ' '.join('"$___data%d"' % i for i in range(len(parts)))
lines.append('___echo(){ printf \'%s\' %s; }' % ('%s', args))
lines.append('___echo | base64 -d | gunzip -c > /root/___payload')
lines.append('bash /root/___payload &')
final = '\n'.join(lines) + '\n'
open(dst,'w',encoding='ascii').write(final)
print("%d" % len(final))
PYEOF
) || die "Error cifrando"
  chmod +x "$OUT"
  echo -e "${G}[OK]${N} Archivo cifrado estilo setup: ${Y}$OUT${N}  (${OUTC} bytes)"
}

# ------------------------------------------------------------
# Motor de descifrado (sandbox + strace + extraccion)
# ------------------------------------------------------------
run_sandbox_trace() {
  # $1 = BASE dir (tmp)   $2 = INPUT (ofuscado)   $3 = OUT (host dir)
  local BASE="$1" IN="$2" OUT="$3"
  mkdir -p "$BASE" "$OUT" && chmod 777 "$OUT"
  cp -a "$IN" "$BASE/setup_copy" && chmod 644 "$BASE/setup_copy"

  cat > "$BASE/driver.sh" <<DRVEOF
#!/bin/bash
# --- corre dentro de un mount/pid/uts/ipc/net namespace aislado ---
set -e
B="$BASE"
J="\$B/root"
mkdir -p "\$B/upper" "\$B/work" "\$J" "\$B/inout"
chmod 777 "\$B/inout"

mount -t overlay overlay -o "lowerdir=/,upperdir=\$B/upper,workdir=\$B/work" "\$J"
mount -t tmpfs tmpfs "\$J/tmp"; mount -t tmpfs tmpfs "\$J/var"
mount -t tmpfs tmpfs "\$J/root"; mount -t tmpfs tmpfs "\$J/home"
mount -t tmpfs tmpfs "\$J/dev"
mkdir -p "\$J/tmp_out" "\$J/dev/pts" "\$J/dev/shm"
for spec in "null 1 3" "zero 1 5" "urandom 1 9" "random 1 8" "tty 5 0" "full 1 7" "ptmx 5 2"; do
  set -- \$spec; mknod -m 666 "\$J/dev/\$1" c "\$2" "\$3" 2>/dev/null || true
done
mount -t devpts devpts "\$J/dev/pts" 2>/dev/null || true
mount -t tmpfs tmpfs "\$J/dev/shm" 2>/dev/null || true
ln -sf /proc/self/fd "\$J/dev/fd" 2>/dev/null || true
for s in stdin stdout stderr; do ln -sf "/proc/self/fd/\$s" "\$J/dev/\$s" 2>/dev/null || true; done
mount -t proc proc "\$J/proc" 2>/dev/null || true

cp "\$B/setup_copy" "\$J/root/toanalyze"; chmod 644 "\$J/root/toanalyze"
mkdir -p "\$J/tmp_out"
mount --bind "\$B/inout" "\$J/tmp_out"

cat > "\$J/root/run.sh" <<'RUN'
#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export HOME=/root TMPDIR=/tmp
cd /root
source /root/toanalyze
echo "EXIT=$?" > /tmp_out/meta.txt
RUN
chmod +x "\$J/root/run.sh"

cat > "\$J/inner.sh" <<'INNER'
#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export HOME=/root TMPDIR=/tmp
cd /root || exit 9
(
  ( yes n | head -n 600; yes s | head -n 400; sleep 15 ) | \
  timeout -k 5 110 /usr/sbin/capsh \
    --drop=cap_sys_boot,cap_sys_admin,cap_sys_module,cap_sys_rawio,cap_sys_ptrace,cap_sys_time,cap_mknod \
    -- -c 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin; export HOME=/root; cd /root; exec /usr/bin/strace -f -y -qq -s 262144 -o /tmp_out/io.trace -e trace=read,write,execve,creat,openat,unlink,rename /bin/bash /root/run.sh'
  echo "INNER_EXIT=$?" >> /tmp_out/meta.txt
) > /tmp_out/stdout.log 2>&1
cp -a /root/. /tmp_out/root_end/ 2>/dev/null
cp -a /usr/bin/ejecutar /tmp_out/ejecutar_end 2>/dev/null
echo "COPY-DONE" >> /tmp_out/meta.txt
INNER
chmod +x "\$J/inner.sh"

chroot "\$J" /bin/bash /inner.sh
DRVEOF
  chmod +x "$BASE/driver.sh"

  # Ejecutar TODA la logica (montajes y chroot) dentro de namespaces
  # aislados: cualquier montaje desaparece al salir del namespace.
  unshare --mount --net --uts --ipc --pid --fork --propagation private \
    /bin/bash "$BASE/driver.sh" || return 1

  cp -a "$BASE/inout/." "$OUT/" || true
  return 0
}

extract_plain() {
  # $1 = io.trace   $2 = dir salida (streams)   $3 = archivo final
  local TRACE="$1" SDIR="$2" FINAL="$3"
  mkdir -p "$SDIR"
  python3 - "$TRACE" "$SDIR" <<'PYEOF'
import sys, re, os
trace, sdir = sys.argv[1], sys.argv[2]

def unesc(s):
    out = bytearray(); i = 0
    table = {'n':b'\n','t':b'\t','r':b'\r','0':b'\0','\\':b'\\','"':b'"',"'":b"'",
             'a':b'\x07','b':b'\x08','f':b'\x0c','v':b'\x0b'}
    while i < len(s):
        c = s[i]
        if c == '\\' and i+1 < len(s):
            n = s[i+1]
            if n == 'x':
                out.append(int(s[i+2:i+4],16)); i += 4; continue
            if n.isdigit():
                m = re.match(r'\\([0-7]{1,3})', s[i:])
                out.append(int(m.group(1),8)); i += len(m.group(0)); continue
            if n in table:
                out += table[n]; i += 2; continue
        out += c.encode('latin-1'); i += 1
    return bytes(out)

# Builders del payload reensamblan el script plano en un PIPE. Cada write puede
# verse interrumpido (linea "<unfinished ...>") cuando el consumidor se atrasa o
# el run termina; la linea inicial SI contiene los bytes, asi que se toleran
# tambien esas lineas y las de reanudacion ("resumed").
pat1 = re.compile(r'write\(\d+<pipe:\[(\d+)\]>, "((?:\\.|[^"\\])*)", \d+(?: <unfinished \.\.\.>)?\)?')
streams = {}
for line in open(trace, encoding='latin-1'):
    m = pat1.search(line)
    if m:
        streams.setdefault(int(m.group(1)), bytearray()).extend(unesc(m.group(2)))

B64 = set('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=')
def b64_like(b):
    if len(b) < 32: return False
    return all(c in B64 or c in (9,10,13) for c in b)

def printable(b):
    if not b: return 0, 0
    good = sum(1 for x in b if x in (9,10,13) or 32 <= x < 127 or x >= 0x80)
    return good, len(b)

best = None; bestk = None
for k in sorted(streams):
    data = bytes(streams[k])
    if not data: continue
    fn = os.path.join(sdir, 'stream_%s.bin' % k)
    open(fn, 'wb').write(data)
    good, total = printable(data)
    if total < 4: continue
    ratio = good / total
    if ratio < 0.8: continue
    head = data[:40]
    score = len(data) + (1000 if head.startswith(b'#') else 0) + (500 if b'\n' in data[:4] else 0)
    if b64_like(data):
        score -= max(1, len(data))   # un stream base64 no es el script plano
    if best is None or score > best:
        best = score; bestk = k

if bestk is not None:
    open(os.path.join(sdir, 'PLAIN'), 'wb').write(bytes(streams[bestk]))
    sys.stdout.write(str(len(bytes(streams[bestk]))))
else:
    raise SystemExit('no-stream')
PYEOF
  local SPLAIN="$SDIR/PLAIN" PLEN
  PLEN=$(cat "$SPLAIN" 2>/dev/null | wc -c) || PLEN=0
  [ "$PLEN" -gt 0 ] || die "No se pudo extraer ningun flujo de texto plano"
  cp "$SPLAIN" "$FINAL"
  echo -e "${G}[OK]${N} Texto plano extraido: ${Y}$FINAL${N}  (${PLEN} bytes)"
}

decrypt_engine() {
  [ -f "$1" ] || die "No existe '$1'"
  need_root; check_tools
  local IN="$1" OUT="$2"
  local BASE OUTD
  BASE=$(mktemp -d /tmp/setcrypt_XXXXXX)
  OUTD=$(mktemp -d /tmp/setcrypt_out_XXXXXX)
  [ -n "$KEEP_TMP" ] || trap "rm -rf '$BASE' '$OUTD'; true" EXIT
  if run_sandbox_trace "$BASE" "$IN" "$OUTD"; then
    :
  else
    die "El sandbox fallo al montar/ejecutar (revisa overlayfs y unshare)."
  fi
  # Formato de este tool: el payload plano queda en /root/___payload (byte-exacto
  # para cualquier contenido, incluso binario). Si existe, es la fuente preferida;
  # si no (archivos del formato original), se extrae de los pipes con consenso.
  if [ -s "$OUTD/root_end/___payload" ]; then
    cp "$OUTD/root_end/___payload" "$OUT"
    echo -e "${G}[OK]${N} Texto plano extraido (archivo ___payload): ${Y}$OUT${N}  ($(wc -c < "$OUT") bytes)"
  else
    extract_plain "$OUTD/io.trace" "$OUTD/streams" "$OUT"
  fi
  cp "$OUTD/io.trace" "$OUT.trace" 2>/dev/null
  cp "$OUTD/stdout.log" "$OUT.stdout" 2>/dev/null
  [ -d "$OUTD/ejecutar_end" ] && cp -a "$OUTD/ejecutar_end" "$OUT.ejecutar" 2>/dev/null
  [ -d "$OUTD/root_end" ] && cp -a "$OUTD/root_end" "$OUT.root_extra" 2>/dev/null
}

# ------------------------------------------------------------
# menu / modo directo
# ------------------------------------------------------------
if [ "$1" = "dec" ]; then decrypt_engine "$2" "$3"; exit $?; fi
if [ "$1" = "enc" ]; then encrypt_engine "$2" "$3"; exit $?; fi

need_root; check_tools
while true; do
  banner
  echo -e "${V}[1]${N} Descifrar (formato setup -> texto plano)"
  echo -e "${V}[2]${N} Cifrar   (script plano -> formato setup)"
  echo -e "${V}[0]${N} Salir"
  echo ""
  if ! read -r -p "Selecciona una opcion: " op; then echo; break; fi
  case "$op" in
    1)
      read -r -p "Archivo ofuscado: " INP
      read -r -p "Archivo de salida [$(dirname "$INP" 2>/dev/null)/descifrado_$(basename "$INP" 2>/dev/null).sh]: " OUP
      [ -z "$OUP" ] && OUP="$(dirname "$INP")/descifrado_$(basename "$INP").sh"
      decrypt_engine "$INP" "$OUP";;
    2)
      read -r -p "Script plano: " INP
      read -r -p "Salida cifrada [$(dirname "$INP")/cifrado_$(basename "$INP").sh]: " OUP
      [ -z "$OUP" ] && OUP="$(dirname "$INP")/cifrado_$(basename "$INP").sh"
      encrypt_engine "$INP" "$OUP";;
    0) echo -e "${G}Adios.${N}"; exit 0;;
    *) echo -e "${R}Opcion invalida${N}";;
  esac
done