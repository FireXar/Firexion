# ADMcgh - VPS Manager Suite (Edición Libre / Sin Key)

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/Language-Python%203-3776AB.svg)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Key%20System-Removed%20%2F%20Free-brightgreen.svg)](#)
[![Architecture](https://img.shields.io/badge/Architecture-x86__64%20%7C%20aarch64-blue.svg)](#)

Suite integral y modular de gestión y administración para servidores VPS (Ubuntu / Debian), basada en la línea **ChumoGH / ADM / LATAM**, completamente desofuscada, auditada, reestructurada y **100% liberada de sistemas de keys, tokens, bloqueos o verificación remota**.

---

## 🌟 Novedades de esta Versión

- **Cero Verificación de Key:** Se ha eliminado permanentemente toda llamada a `chekKEY`, consultas a servidores de licencias en puertos `8888` y `81`, listas blancas de IP (`control`), ficheros de bloqueo (`/etc/cghkey`, `/etc/chekKEY`, `/file`), y auto-destrucción del menú.
- **Instalación Local Directa:** No depende de bots de Telegram, servidores externos, ni servicios keygen intermediarios (`latamsrc-keygen.service`). Todos los módulos, plugins y binarios residen localmente en el repositorio.
- **Soporte Multi-Arquitectura:** Binarios nativos precompilados de gestión de usuarios (`add_new_user.bin`) tanto para **x86_64** (Intel/AMD) como para **aarch64** (ARM64 / Oracle Cloud Free Tier / AWS Graviton).
- **Estructura Limpia y Modular:** Organización profesional pensada para despliegue directo en GitHub.
- **Código Desofuscado y Legible:** Se han conservado las herramientas forenses de desofuscación y auditoría en la carpeta `tools/` y `docs/`.

---

## 📁 Estructura del Repositorio

```text
├── bin/                       # Binarios compilados y utilidades del sistema
│   ├── aarch64/add_new_user.bin   # Gestor de usuarios SSH para ARM64
│   ├── x86_64/add_new_user.bin    # Gestor de usuarios SSH para x86_64
│   ├── root-pass.sh               # Cambio de contraseña root (sin telemetría)
│   ├── stunnel-5.65.tar.gz        # Código fuente comprimido de stunnel 5.65
│   ├── toolmaster.py              # CLI administrativo en Python
│   └── upLIC                      # Optimizador de red y memoria RAM
│
├── core/                      # Módulos núcleo del sistema ADM (instalados en /etc/adm-lite)
│   ├── menu                       # Menú principal interactivo (9.400+ líneas, libre)
│   ├── cabecalho                  # Cabecera de conexión
│   ├── menu_credito               # Créditos y branding
│   ├── payloads                   # Cargas útiles para SSH/Dropbear/SSL
│   ├── http-server.py             # Servidor interno HTTP/Proxy
│   ├── ultrahost                  # Extractor y comprobador de hosts
│   ├── shadowsocks.sh             # Gestor de Shadowsocks base
│   ├── PDirect.py, PGet.py...     # Proxies Python (Direct, Get, Open, Priv, Pub)
│   └── v-local.log                # Registro de versión local (V2.5.0)
│
├── plugins/                   # Protocolos avanzados y complementos
│   ├── SlowDNS.sh                 # Servidor y cliente DNS Tunneled (puerto 53)
│   ├── UDP_menu.sh                # Gestor de BadVPN UDP para gaming/llamadas
│   ├── ClashForAndroidGLOBAL.sh   # Generador y gestor de perfiles Clash
│   ├── budp.sh                    # BadUDP complementario
│   ├── v2r.sh / v2r.bin           # Gestor de protocolos V2Ray (VMess/VLess)
│   ├── xr.sh / xr.bin             # Gestor de protocolos Xray (Trojan/VLESS-XTLS)
│   ├── autoconfig.sh              # Auto-configurador de dependencias
│   ├── m_backup.sh                # Copias de seguridad locales
│   ├── ssrrmu.sh                  # Soporte ShadowsocksR
│   ├── styles.cpp                 # Motor de estilos extendido
│   └── zh.sh                      # Utilidad Zivpn
│
├── styles/                    # Motor gráfico y paletas de colores ANSI
│   ├── msg                        # Funciones gráficas (msg, print_center, tittle, anim)
│   └── styles.cpp                 # Definiciones de colores y marcos
│
├── repos/                     # Listas de repositorios APT oficiales por distro
│   ├── 8.list ... 12.list         # Debian 8, 9, 10, 11, 12
│   └── 16.04.list ... 22.04.list  # Ubuntu 16.04 a 22.04 LTS
│
├── web/                       # Interfaz Web de bienvenida para Nginx
│   └── index.html / plugin.html   # Panel web HTML de bienvenida
│
├── tools/                     # Scripts de ingeniería inversa y desofuscación (Python)
│   ├── deobf_type1_matrix.py      # Desofuscador Bashfuscator octal/hex
│   ├── deobf_type2_vars.py        # Desofuscador variables concatenadas
│   ├── deobf_type2b_latam.py      # Desofuscador base64 + cebo LATAM
│   ├── deobf_type3_pack3.py       # Desofuscador multicapa b64/bzip2/gzip
│   ├── verify_all.py              # Verificador sintáctico de todo el árbol
│   └── cripto(ChumoGH).sh         # Herramienta de cifrado/descifrado en sandbox
│
├── docs/                      # Documentación forense y bitácora técnica
│   ├── DOCUMENTACION_INSTALACION.md
│   ├── ESPEJO_Y_VERSION_EDITADA.md
│   ├── MAPA_REESCRITURA_URLS.md
│   ├── REGISTRO_AUDITORIA.md
│   ├── INDICE.md
│   └── DOC.MD
│
├── src/                       # Volcados desofuscados limpios para referencia
│   ├── setup_limpio.sh
│   ├── pack_new_limpio.sh
│   ├── pack3_limpio.sh
│   └── LATAM_limpio.sh
│
├── install.sh                 # Instalador automatizado desatendido (1-click)
├── setup.sh                   # Instalador interactivo por consola
├── LICENSE                    # Licencia MIT
└── .gitignore                 # Filtro de archivos para GitHub
```

---

## 🚀 Requisitos del Sistema

- **Sistema Operativo:** Ubuntu (18.04, 20.04, 22.04, 24.04) o Debian (9, 10, 11, 12).
- **Permisos:** Acceso como superusuario `root`.
- **Arquitectura:** x86_64 (AMD64) o aarch64 (ARM64).
- **Puertos Libres:** 22 (SSH), 80/81 (Web), 53 (DNS si se usa SlowDNS).

---

## 💻 Instalación Rápida (1-Click)

Ejecuta el siguiente comando como usuario `root` en tu terminal:

```bash
apt update -y; apt upgrade -y; wget -q https://raw.githubusercontent.com/karl1999x/ChumoGH/main/setup; chmod 777 setup; ./setup --ADMcgh
```

Una vez completada la instalación, el sistema estará inmediatamente activo sin requerir ninguna clave ni validación.

---

## 🎮 Comandos de Uso

Tras la instalación, los siguientes comandos globales estarán disponibles en su terminal:

| Comando | Descripción |
| :--- | :--- |
| `menu` | Abre el menú interactivo principal de ADMcgh. |
| `cgh` | Acceso rápido al panel de administración. |
| `adm` | Acceso con soporte para paso de parámetros. |
| `toolmaster` | Abre el administrador CLI de monitoreo y diagnóstico. |
| `add_new_user` | Utilidad nativa de creación de usuarios SSH/VPN con límite de conexiones y días. |
| `upLIC` | Optimiza instantáneamente memoria RAM y tablas de red. |

---

## 🛡️ Protocolos Soportados

1. **SSH / Dropbear / Stunnel (SSL/TLS)**
2. **BadVPN (UDP 7100, 7200, 7300...)** para llamadas de WhatsApp y juegos online.
3. **SlowDNS** sobre UDP 53 para conexiones en entornos restringidos.
4. **V2Ray & Xray** (VMess, VLess, Trojan, XTLS).
5. **Shadowsocks & ShadowsocksR**.
6. **Clash for Android** (generador automático de configs).
7. **Servidor Web integrado (Nginx en puerto 81/80)** con interfaz dashboard.

---

## 📜 Licencia

Distribuido bajo la Licencia **MIT**. Consulte el archivo [LICENSE](LICENSE) para más detalles.
