# Bitácora Central de Auditoría Forense y Mapeo de Componentes (CHUMOPLUS)

> **Propósito**: Mantener un registro persistente del mapa completo de archivos, hashes SHA-256, técnicas de ofuscación, hallazgos de seguridad y herramientas de volcado.  
> **Uso Multisesión**: Esta bitácora permite que cualquier persona, sesión o modelo de IA retome el trabajo exactamente en el punto donde quedó sin perder el contexto técnico.

---

## 1. Inventario General de Componentes (3 Capas)

| Componente | Origen / URL | Hash SHA-256 (Capa 1) | Técnica de Ofuscación | Desofuscador en Capa 2 | Salida Limpia en Capa 3 | Estado |
| :--- | :--- | :--- | :--- | :--- | :--- | :---: |
| **`setup`** (Capa 1) | `https://plus.ltmcgh.site/setup` | `cfa3c3a...` (3.9 MB) | Matriz Octal/Hex (*Bashfuscator*) | `deobf_type1_matrix.py` | [setup_limpio.sh](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/3_CODIGOVOLCADOFINAL/setup_limpio.sh) | **[VOLCADO Y AUDITADO]** |
| **`pack_new`** (Capa 2) | `https://plus.ltmcgh.site/pack_new` | `9141f7eac4ee13d0...` (39.3 KB) | Sustitución de Variables Concatenadas | `deobf_type2_vars.py` | [pack_new_limpio.sh](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/3_CODIGOVOLCADOFINAL/pack_new_limpio.sh) | **[VOLCADO Y AUDITADO]** |
| **`pack3.tar`** (Capa 2 Fallback) | GitHub `.../Plugins/system/pack3.tar` | `92833f51929bac44...` (42.8 KB) | Multi-capa (Base64 + BZIP2 + GZIP) | `deobf_type3_pack3.py` | [pack3_limpio.sh](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/3_CODIGOVOLCADOFINAL/pack3_limpio.sh) | **[VOLCADO Y AUDITADO]** |
| **`styles.cpp`** | GitHub `.../Plugins/system/styles.cpp` | `be389eb454fcec64...` (9.0 KB) | Texto plano (renombrado a .cpp) | N/A (Copia directa) | [styles_limpio.sh](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/3_CODIGOVOLCADOFINAL/styles_limpio.sh) | **[VOLCADO Y AUDITADO]** |
| **`control`** (Tokens) | GitHub `.../TOKENS/dinamicos/control` | `765692a403641bb5...` (82 B) | Texto plano (IPs autorizadas) | N/A (Auditoría directa) | [control_tokens.txt](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/1_CODIGOORIGINAL/control_tokens.txt) | **[AUDITADO]** |
| **`v-new.log`** | GitHub `.../version/v-new.log` | `bc5d84bed7dee3e1...` (2 B) | Texto plano (Número de versión) | N/A (Auditoría directa) | [v_new_log.txt](file:///c:/xampp/htdocs/pkdlatamsrc/CHUMOPLUS/1_CODIGOORIGINAL/v_new_log.txt) | **[AUDITADO]** |

---

## 2. Mapa Completo de Servidores, URLs y Endpoints Remotos

Durante el volcado y auditoría de `setup_limpio.sh`, `pack_new_limpio.sh` y `pack3_limpio.sh` se han descubierto los siguientes endpoints externos:

### A. Servidores de Validación y C&C Privado
- `https://plus.ltmcgh.site/setup`: Instalador inicial (Capa 1).
- `https://plus.ltmcgh.site/pack_new`: Payload de ejecución al vuelo (Capa 2).
- `https://plus.ltmcgh.site/main/control`: Control de validación de tokens/IP.
- `http://[IP_GENERADOR]:81/ChumoGH/checkIP.log`: Registro de validación y logs de IPs consumidoras.
- `http://[IP_GENERADOR]:8888`: Puerto de servicio de licencias y descarga de módulos (`lista-arq`).
- **IPs Autorizadas detectadas en `control`**:
  - `140.99.223.128` (Servidor activo de generación / bot)
  - `129.151.106.89`
  - `144.22.54.80`

### B. Descargas Ocultas en Almacenamiento Externo
- `https://www.dropbox.com/s/hl9vyo8mf94z0h5/root-pass.sh`:
  > [!CAUTION]
  > Script alojado en Dropbox que se invoca en `pack_new_limpio.sh` para manipular o reiniciar la contraseña de root de la VPS.
- `https://www.dropbox.com/scl/fi/je70qpfmwu6416ail48zq/msg...`: Mensajería alternativa.

### C. Descargas de Binarios ELF Precompilados
- `https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/${platform}/add_new_user.bin`:
  Binario cerrado precompilado que se descarga directamente a `/bin/add_new_user` para gestionar usuarios del sistema.

### D. Repositorios GitHub Oficiales del Proyecto
- `https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/toolmaster.py`
- `https://raw.githubusercontent.com/ChumoGH/ADMcgh/refs/heads/main/Plugins/WEB/plugin.html`
- `https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Repositorios/${vercion}.list`

---

## 3. Matriz de Hallazgos de Seguridad y Comandos Invasivos

| Archivo | Línea | Comando / Acción | Impacto en el Sistema |
| :--- | :---: | :--- | :--- |
| `setup_limpio.sh` | L340 | `bash -c "$(wget ... pack_new)"` | Ejecución en memoria de código remoto sin hash ni firma. |
| `setup_limpio.sh` | L76 | `wget -O /etc/apt/sources.list ${link}` | Sobreescritura total de repositorios oficiales con listas de terceros. |
| `setup_limpio.sh` | L354 | `echo "nameserver 8.8.8.8" >> /etc/resolv.conf` | Inyección forzada de DNS externo en la configuración del host. |
| `pack_new_limpio.sh` | L250 | `apt-get purge ufw -y` | **Desinstalación completa del cortafuegos UFW**. |
| `pack_new_limpio.sh` | L253-259 | `iptables -F`, `-t nat -F`, `-P INPUT ACCEPT` | **Vaciado total de reglas de iptables** (deja todos los puertos abiertos). |
| `pack_new_limpio.sh` | L84 | `killall kswapd0` | Cierre de procesos sospechosos o posibles mineros rivales. |
| `pack_new_limpio.sh` | L106 | `* * * * * root bash /bin/autoboot` en `/etc/crontab` | **Persistencia forzada en cron cada minuto** como root. |
| `pack_new_limpio.sh` | L418 | `rm -f /var/log/auth.log*` | **Borrado del registro de autenticación** para evitar auditoría forense. |

---

## 4. Comparativa Técnica: `pack_new` vs. `pack3.tar`

* `pack_new.txt` y `pack3_tar.txt` representan **la misma Capa 2 del instalador**, pero distribuidas por canales distintos:
  * `pack_new`: Utiliza ofuscación por variables concatenadas y se descarga desde el dominio `plus.ltmcgh.site`.
  * `pack3.tar`: Utiliza compresión GZIP + BZIP2 + expansión de parámetros de Bash y se descarga desde el repositorio de GitHub como alternativa de respaldo.
* En `setup_limpio.sh` (líneas 339-341), el instalador intenta primero ejecutar `pack3.tar` o `pack_new` según la disponibilidad del enlace.

---

## 5. Guía de Uso de los Desofuscadores (Capa 2)

Para auditar futuros archivos o nuevas versiones descargadas:

1. **Bashfuscator (Matriz Octal/Hex)**:
   ```bash
   python 2_CODIGOANALIZADO/deobf_type1_matrix.py
   ```
2. **Sustitución de Variables (Tipo `pack_new`)**:
   ```bash
   python 2_CODIGOANALIZADO/deobf_type2_vars.py
   ```
3. **Multi-Capa Base64/BZIP2/GZIP (Tipo `pack3.tar`)**:
   ```bash
   python 2_CODIGOANALIZADO/deobf_type3_pack3.py
   ```

---

## 6. Estado del Proyecto y Punto de Reanudación

- **Fase Actual**: **Completada con éxito**.
- **Capa 1 (Originales)**: Descargada, clasificada y preservada de forma inactiva.
- **Capa 2 (Herramientas)**: 3 desofuscadores modulares creados y validados.
- **Capa 3 (Limpios)**: 4 scripts clave completamente legibles en texto plano.
- **Siguiente paso disponible (opcional)**: Descarga estática del script remoto de Dropbox (`root-pass.sh`) o inspección del script `toolmaster.py` si se desea auditar la persistencia de usuarios.
# Bitácora 2ª Sesión de Auditoría (CHUMOPLUS)

## 1. Lo realizado en esta sesión

1. **Clon estático de 3 repos** (sin ejecutar nada): `ADMcgh` (115 archivos),
   `ChumoGH-Script` (122), `ScriptCGH` (46).
2. **Espejo local completo** en `CHUMOPLUS/mirror/` (81 archivos, 24.85 MB)
   con la estructura `github/main`, `github-extra`, `plus.ltmcgh.site`, `dropbox`.
3. **6 nuevas técnicas de ofuscación resueltas** y sus herramientas creadas.
4. **Recuperación del MENU real** (341 KB) desde `SCRIPT.tar.gz` → `menu`.
5. **Inventario total de URLs**: 199 únicas, 132 objetivos de espejo.
6. **Verificación de las 3 capas**: 0 problemas (`verify_all.py`).

## 2. Nuevas herramientas (Capa 2)

| Herramienta | Función |
| :--- | :--- |
| `deobf_type2b_latam.py` | Base64 por variables + `eval` + cabecera de cebo |
| `deobf_type2c_posicional.py` | Vars+eval con posicionales `$1..$9` borrados |
| `deobf_type3b_param.py` | `${@...}` con capas anidadas (hasta 8) |
| `deobf_type4_superscript.py` | Dígitos unicode en superíndice |
| `fetch_mirror.py` | Descarga todo el espejo |
| `extract_urls.py` | Extrae todas las URLs de los archivos |
| `build_url_map.py` | Genera la tabla de reescritura |
| `inventory_repos.py` | Clasifica los repos clonados |
| `verify_all.py` | Verifica capas 1, 2, 3 y el espejo |

## 3. Punto de reanudación

- **Estado**: sesión completada sin pendientes críticos.
- **Siguiente paso opcional**: volcar `pack.tar` y `pack2.tar` con
  `deobf_type1_matrix.py`, o comenzar la reescritura de URLs en los `.sh`
  limpios usando `MAPA_REESCRITURA_URLS.md`.
- **Documento principal**: `CHUMOPLUS/ESPEJO_Y_VERSION_EDITADA.md`.
