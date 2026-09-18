# cghlatamsrc

Repositorio de trabajo **estático** sobre el instalador ADM (`ChumoGH` / línea `LATAM`).

> **Regla del repositorio: 0 % ejecución.** Aquí solo entran archivos ya
> desofuscados y auditados. El `setup` original (3.9 MB, bashfuscator) y sus
> payloads **no se versionan** en este repo; se conservan fuera (carpeta
> `CHUMOPLUS/` en la máquina de auditoría).

---

## Estructura

```
.
├── 2_CODIGOANALIZADO/        # Capa 2: desofuscadores y verificadores (Python)
│   ├── deobf_type1_matrix.py         bashfuscator octal/hex
│   ├── deobf_type2_vars.py           variables concatenadas
│   ├── deobf_type2b_latam.py         base64 + cebo (LATAM)
│   ├── deobf_type2c_posicional.py    posicionales $1..$9 borrados
│   ├── deobf_type3_pack3.py          multicapa b64/bz2/gzip
│   ├── deobf_type3b_param.py         ${@...} anidado
│   ├── deobf_type4_superscript.py    unicode superíndice
│   ├── fetch_mirror.py               constructor del espejo local
│   ├── extract_urls.py               extractor de URLs
│   ├── build_url_map.py              mapa de reescritura URL→local
│   ├── inventory_repos.py            inventario de repos clonados
│   ├── download_layer1.py            descarga de la capa 1
│   ├── verify_all.py                 verificación capas 1/2/3 + espejo
│   ├── verify_layers.py              verificación por capas
│   └── _*.py                         sondas de análisis (desechables)
│
├── 3_CODIGOVOLCADOFINAL/     # Capa 3: código desofuscado, legible
│   ├── setup_limpio.sh               706 líneas · instalador principal
│   ├── menu_limpio.sh                9 466 líneas · EL MENÚ REAL (341 KB)
│   ├── pack_new_limpio.sh            441 líneas · capa 2 (plus.ltmcgh.site)
│   ├── pack3_limpio.sh               454 líneas · capa 2 (fallback GitHub)
│   ├── styles_limpio.sh              283 líneas · msg-bar / estilos
│   ├── LATAM_limpio.sh               463 líneas · variante @Kalix1 / NetVPS
│   ├── ScriptCGH_setup_limpio.sh     ESQUELETO incompleto (ver abajo)
│   └── pack_new_desde2b.sh           sin desofuscar (blob, no usar)
│
├── DOC.MD                    # Guía de trabajo con Bash (LF/CRLF, seguridad)
├── ESPEJO_Y_VERSION_EDITADA.md  # Arquitectura descifrada + tabla URL→local
├── MAPA_REESCRITURA_URLS.md     # Tabla completa (186 filas) de reescritura
└── REGISTRO_AUDITORIA.md        # Bitácora forense multisesión
```

---

## Estado verificado

```
python3 2_CODIGOANALIZADO/verify_all.py
```

| Capa | Estado |
| :--- | :--- |
| Capa 2 (herramientas) | 28/28 `.py` compilan sin error de sintaxis |
| Capa 3 (volcados) | 7/7 legibles con su marca de origen |
| Espejo `mirror/` | no versionado (ver nota) |

`pack_new_desde2b.sh` **no** entra en la verificación: es un blob sin desofuscar.

---

## Limitaciones conocidas (no son errores de este repo)

1. **`mirror/` no se versiona.** Contiene repos completos de terceros
   (`ADMcgh`, `ChumoGH-Script`, `ScriptCGH`), binarios ELF de 2.5 MB
   (`add_new_user.bin`) y el dump `root-pass.sh`. Mover eso a un repo público
   es redistribuir material ajeno. Vive local; se regenera con
   `2_CODIGOANALIZADO/fetch_mirror.py`.
2. **`ScriptCGH_setup_limpio.sh` es un esqueleto.** Perdió los saltos de línea
   y los posicionales `$1..$9` no existen dentro del archivo original, así que
   hay tramos no recuperables. Requiere reconstrucción manual.
3. **`setup_limpio.sh` conserva los saltos de línea y tabuladores originales.**
   La auditoría citó `nameserver8.8.8.8`; en el volcado real el separador es un
   **tabulador** (`nameserver<TAB>8.8.8.8`), no un espacio. Corregido en esta
   revisión.
4. **`menu_limpio.sh` line 1 no tiene shebang.** Es el `menu` tal cual salió de
   `SCRIPT.tar.gz`; se le quita el shebang al instalarlo en `/etc/adm-lite/menu`.

---

## Flujo de reescritura (siguiente fase)

Cada URL remota se sustituye por su equivalente local, siguiendo
`MAPA_REESCRITURA_URLS.md`:

| Prefijo remoto | Prefijo local |
| :--- | :--- |
| `https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/` | `.../mirror/github/main/` |
| `https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/` | `.../mirror/github-extra/ChumoGH-ChumoGH-Script-master/` |
| `https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/` | `.../mirror/github-extra/ChumoGH-ScriptCGH-main/` |
| `https://plus.ltmcgh.site/` | `.../mirror/plus.ltmcgh.site/` |
| `https://www.dropbox.com/s/...` | `.../mirror/dropbox/<nombre>` |

> Los endpoints `:81` y `:8888` del keygen **no son espejables**: `lista-arq` se
> genera dinámicamente por clave e IP. Hay que sustituir el generador por un
> servicio propio o eliminar la validación.

---

## Aviso legal / alcance

Material de análisis forense defensivo. Ningún script de este repositorio se ha
ejecutado en la máquina de auditoría y ninguno está pensado para ejecutarse como
está: son artefactos de lectura. El instalador original escribe en
`/etc/apt/sources.list`, `/etc/resolv.conf`, borra `/var/log/auth.log*`,
desinstala UFW y vacía `iptables`.
