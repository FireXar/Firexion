# ChumoGH / ADMcgh — Archivos descifrados

Descifrado **estático**: solo descompresión, base64 y sustitución de `eval` por `printf`.
Nada se ejecutó en el host, salvo el incidente documentado al final (limpio y verificado).

**0 archivos siguen cifrados.** Los originales ofuscados y toda la basura fueron eliminados.
Los 10 `.dec` pasan `bash -n` (sintaxis de shell válida) y contienen cero ofuscación residual.

> Nota de rigor: una afirmación previa de que `pack.tar` era un "payload de 2,6 MB" era incorrecta.
> `bash -n` lo desmintió — ver la sección dedicada abajo.

---

## Installer principal

| Archivo | Bytes | Líneas | Origen |
|---|---|---|---|
| `Installer/setup` | 24.267 | 706 | `main/setup` (3,9 MB → 24 KB, tabla `_`) |

## Payloads de segunda etapa

| Archivo | Bytes | Líneas | Técnica de descifrado |
|---|---|---|---|
| `pack_new/pack_new.dec` | 16.468 | 439 | `var` + `eval` → `printf` (estático) |
| `pack3.tar/pack3.dec` | 17.103 | 454 | 3 capas: at-noise → b64/bzip2 → gzip |
| `pack2.tar/pack2.dec` | 27.058 | 643 | tabla `_`, 162 capas |

### `pack.tar` NO es un script

`https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/pack.tar`
(3.798.627 B, md5 `9ed918263e8f919501c45b00b7a8aa24`)

 pese a la extensión `.tar` y a usar el mismo formato de tabla `_` que el setup, sus 108 capas
decodifican a `pack.tar/pack.tar.charmap` (2.631.525 B): un **CHARMAP de gettext para UTF-8**,
equivalente al `.gmo` de glibc. Empieza por `<code_set_name> UTF-8` / `CHARMAP` y termina en
`END WIDTH`. **Cero shell dentro** — verificado con `grep` de `#!/`, `curl`, `rm -rf`, y con
`bash -n` (falla con `syntax error near unexpected token` en la línea 20).

Es un señuelo o un error de empaquetado en el repo. Se conserva el resultado descifrado; el
original se puede volver a bajar de la URL de arriba.


## Repositorio ADMcgh — `SCRIPT.tar.gz/`

| Archivo | Bytes | Líneas | Técnica |
|---|---|---|---|
| `SCRIPT.tar.gz/menu.dec` | 342.549 | 9.466 | 2 capas: base64 → gzip |

Resto de la carpeta en texto plano original: `payloads`, `shadowsocks.sh`, `http-server.py`,
`PDirect.py`, `PGet.py`, `POpen.py`, `PPriv.py`, `PPub.py`, `cabecalho`, `menu_credito`,
`ultrahost`, `v-local.log`.

## Plugins del servidor de licencias — `keyserver/file.tar_extracted/`

Descargados con la key del usuario, que decodifica a `140.99.223.128` (primera IP de la
lista blanca en `control/control`). Endpoint `:8888` = índice, `:81` = archivos.

| Archivo | Bytes | Líneas | Técnica |
|---|---|---|---|
| `SlowDNS.sh.dec` | 25.237 | 720 | at-noise + base64 **line-wrapped** → sub-payload interno |
| `UDP_menu.sh.dec` | 40.424 | 1.042 | 2 capas base64 → gzip |
| `ClashForAndroidGLOBAL.sh.dec` | 82.330 | 2.460 | 1 capa base64 → gzip |
| `budp.sh.dec` | 7.691 | 194 | 1 capa base64 → gzip |
| `v2r.bin.dec` | 56.007 | 1.828 | `var` + `eval` → `printf` |
| `xr.bin.dec` | 57.178 | 1.833 | `var` + `eval` → `printf` |

Planos: `autoconfig.sh`, `m_backup.sh`, `shadowsocks.sh`, `ssrrmu.sh`, `zh.sh`, `styles.cpp`.

## Otros

- `stunnel-5.65.tar.gz/stunnel-5.65/` — 142 archivos, código fuente upstream de stunnel 5.65
- `add_new_user.bin/{x86_64,aarch64}/` — binarios ELF: `useradd` parcheado
- `msg/`, `msg-dropbox/`, `msg-bar/`, `styles.cpp/`, `control/`, `control-main/`
- `Repositorios/` — listas de repos apt; `22.10` y `24.04` no existen en el origen (404)
- `toolmaster.py/`, `plugin.html/`, `root-pass.sh/`, `v-new.log/`
- `cripto(ChumoGH).sh` — descifrador en sandbox aislado (usado en `pack.tar` / `pack2.tar`)

> ⚠️ `token.sh/token.sh` contiene un **token real de Telegram** y un chat ID.
> No publicarlo; considerationar borrarlo o rotarlo.

---

## Incidente: ejecución accidental de `pack3.tar`

El script se ejecutó una vez por error en el host. Artefactos depositados y **ya eliminados**,
verificado por rastreo (`find / -xdev`): `/usr/bin/{autoboot,adm,menu,cgh}`, `/etc/ADMcgh/bin/AutoRestart`,
`/file` y crontab de root. PAM, SSH, `/etc/hosts`, `/etc/resolv.conf` y `/etc/sysctl.d` intactos.

Las copias de esos artefactos (`_plantados/`) se eliminaron al limpiar. El contenido del crontab
**no** se conservó en copia; se reconstruyó desde el código real en `pack3.tar/pack3.dec:404-411`,
que es lo que el script escribía:

```bash
crontab -r >/dev/null 2>&1
(
	crontab -l 2>/dev/null
	echo "@reboot /bin/autoboot"
	echo "* * * * * /bin/autoboot"
) | crontab -
```

Y además, en `pack3.tar/pack3.dec:128-135`, sobre `/etc/crontab`:

```
* * * * * root bash  /bin/autoboot
```

Los ficheros depositados eran stubs que delegaban en `/usr/bin/menu` y `AutoRestart`
(symlink a `/bin/autoboot`). El sandbox usado para `pack.tar` / `pack2.tar` **no escapó**: los
artefactos de `pack.dec.ejecutar/` y `pack.dec.root_extra/` quedaron dentro de la carpeta de trabajo.
