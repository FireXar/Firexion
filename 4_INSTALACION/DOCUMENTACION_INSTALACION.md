# Desglose Técnico de la Instalación ADM (Línea LATAM)
**Autor:** @SNIPER754186  
**Repositorio Oficial:** [cghlatamsrc (GitHub)](https://github.com/SNIPER754186/cghlatamsrc)  
**Servidor VPS:** `64.176.5.61` (paanelfree)  
**Key Fija y Autenticador:** `latamsrcddev`  
**Fecha:** 19/09/2026  

---

## 1. Resumen Ejecutivo y Estado Final

| Componente | Estado | Detalle |
| :--- | :--- | :--- |
| **Repositorio Remoto** | Auditado y Vinculado | `https://github.com/SNIPER754186/cghlatamsrc` |
| **Key Fija** | Activa y Validada | `latamsrcddev` (sin depender de bots de ChumoGH) |
| **Autenticador / Keygen** | Servicio Systemd Activo | Puerto `8888` (`latamsrc-keygen.service`) |
| **Servidor de Módulos** | Nginx Activo | Puerto `81` (`/var/www/html/`) |
| **Suite ADM** | Instalada en VPS | `/etc/adm-lite/` y `/etc/ADMcgh/` |
| **Comandos de Terminal** | Funcionales (Exit 0) | `menu`, `cgh`, `adm`, `toolmaster`, `add_new_user` |
| **Bash Interactivo** | Banner Personalizado | Integrado en `/etc/ADMcgh/bashrc` y `/root/.bashrc` |

---

## 2. Comparación Forense: `_repo3` vs Ecosistema Original (ChumoGH)

Al revisar `https://github.com/SNIPER754186/cghlatamsrc/tree/main/_repo3` se contrastó con los volcados de Capa 3 y el espejo `CHUMOPLUS/mirror/`:

| Archivo | Origen ChumoGH | Estado en `_repo3` | Hallazgo Crítico / Corrección Aplicada |
| :--- | :--- | :--- | :--- |
| `setup_limpio.sh` | Bashfuscator (matriz hex/octal) | Desofuscado (24.6 KB) | Tenía URLs apuntando a `.../main/mirror/` (retornaba 404 en GitHub). En el repo las rutas reales del espejo están en `.../main/CHUMOPLUS/mirror/`. Corregido y generado `setup_latamsrc.sh`. |
| `pack_new_limpio.sh` | Sustitución vars concatenadas | Desofuscado (16.5 KB) | Desvinculado de `plus.ltmcgh.site` y Dropbox; ahora usa el mirror propio y el keygen local. |
| `pack3_limpio.sh` | Multi-capa b64/bzip2/gzip | Desofuscado (17.1 KB) | Reescrito como alternativa fallback para despliegue sin internet. |
| `menu_limpio.sh` | `${@...}` anidado gzip+bzip2 | Desofuscado (342.5 KB) | Menú completo de 9.466 líneas. Se eliminó la validación contra Dropbox (`Control-Bot.txt`) y se validó directamente con `latamsrcddev` y `/etc/chekKEY`. |
| `styles_limpio.sh` | Texto plano renombrado `.cpp` | 9.0 KB | Funciones `msg`, `print_center`, `tittle`, `anim` preservadas e instaladas en `/bin/ejecutar/msg`. |
| `LATAM_limpio.sh` | Base64 por vars + cebo | 18.1 KB | Compatible con instaladores @Kalix1 / NetVPS con la key fija. |
| `SCRIPT.tar.gz` | Binario/Scripts comprimidos | 158.7 KB | Descomprimido y provisionado en `/etc/adm-lite/` y en el endpoint web de descarga. |

---

## 3. Arquitectura del Autenticador y Keygen Propio

Los scripts originales dependían de un servidor FTP/HTTP en los puertos `:81` y `:8888` de IPs ajenas (`plus.ltmcgh.site` y bots de Telegram). Para independizar el VPS al 100%, se implementó la arquitectura local:

### A. Puerto 8888: Daemon de Autenticación (`latamsrc-keygen.service`)
- **Archivo:** `/root/cghlatamsrc/4_INSTALACION/latamsrc_keygen.py`
- **Servicio:** `/etc/systemd/system/latamsrc-keygen.service` (habilitado con `systemctl enable --now`)
- **Función:**
  - Responde `200 OK` al sondeo de conectividad del instalador.
  - Al recibir una solicitud `GET /<key>/-SPVweN/<IP>/<SYS>/<UUID>`, registra la IP y entrega la lista de arquitectura (`lista-arq`) para descargar los módulos.
  - Acepta de forma automática la key autorizada: `latamsrcddev`.

### B. Puerto 81: Nginx Web Server de Módulos
- **Configuración:** `/etc/nginx/sites-available/default` escuchando en `81`
- **Directorio Raíz:** `/var/www/html/`
- **Endpoints Expuestos:**
  - `http://64.176.5.61:81/ChumoGH/checkIP.log`: Registro de validación de IP y fecha.
  - `http://64.176.5.61:81/ChumoGH/control`: Lista de IPs autorizadas (incluye `64.176.5.61`).
  - `http://64.176.5.61:81/latamsrcddev/<archivo>`: Descarga directa de cada módulo (`menu`, `cabecalho`, `menu_credito`, `v-local.log`, etc.).
  - `http://64.176.5.61:81/index.html`: Panel web HTML original del ADM.

---

## 4. Estructura de Ficheros Instalados en el VPS

```
/etc/
├── adm-lite/                      # Directorio de trabajo del menú
│   ├── menu                       # Script principal del menú (ejecutable)
│   ├── cabecalho                  # Cabecera de conexión
│   ├── menu_credito               # Créditos: @SNIPER754186 | latamsrc
│   ├── name                       # Nombre del nodo: LATAM-SRC
│   ├── v-local.log                # Versión instalada: V2.5.0
│   ├── payloads                   # Payloads SSH/Dropbear/SSL
│   └── http-server.py             # Servidor Python integrado
├── ADMcgh/
│   ├── bashrc                     # Banner y bienvenida interactiva
│   └── bin/
│       ├── SBdm                   # toolmaster.py de gestión
│       ├── useradd                # Binario ELF x86_64 para crear usuarios SSH
│       ├── atoken_setup.bin       # Binario de gestión de tokens
│       ├── upLIC                  # Script de optimización de red y RAM
│       └── AutoRestart            # Symlink a /bin/autoboot
├── cghkey                         # Contiene: latamsrcddev
├── chekKEY                        # Token activo de autorización
├── folteto                        # Log local de IP y key validada
└── PACKAGE                        # Token dinámico de control

/bin/
├── menu -> /etc/adm-lite/menu     # Lanzador principal
├── cgh  -> /etc/adm-lite/menu     # Lanzador con opción -fix
├── adm  -> /etc/adm-lite/menu     # Lanzador con paso de argumentos
├── autoboot                       # Script de reinicio y watchdog
├── toolmaster -> /etc/ADMcgh/bin/SBdm
├── add_new_user -> /etc/ADMcgh/bin/useradd
└── ejecutar/
    ├── msg                        # Motor gráfico de colores y formatos
    ├── IPcgh                      # 64.176.5.61
    ├── v-new.log                  # V2.5.0
    └── menu_credito               # @SNIPER754186 | latamsrc
```

---

## 5. Pruebas de Verificación Realizadas

1. **Prueba de Autenticador (`:8888`):**
   ```bash
   curl -s http://127.0.0.1:8888/latamsrcddev/-SPVweN/64.176.5.61/Ubuntu-22.04/test-uuid
   # Retorna: lista de 13 archivos requeridos
   ```
2. **Prueba de Servidor de Archivos (`:81`):**
   ```bash
   curl -s http://127.0.0.1:81/latamsrcddev/v-local.log
   # Retorna: V2.5.0
   ```
3. **Prueba de Ejecución del Menú (`menu`):**
   ```bash
   echo "0" | menu
   # Salida: Render completo de interfaz ANSI con IP 64.176.5.61, Key Verified @SNIPER754186, puertos SSH:22, Nginx:81, Keygen:8888. Salida limpia exit 0.
   ```
4. **Prueba de Comandos Alternativos:**
   `cgh` y `adm` responden con el menú interactivo idéntico.

5. **Prueba de Inicio de Sesión Bash:**
   Al abrir terminal o ejecutar `source /etc/ADMcgh/bashrc`, se dibuja el banner estilizado:
   ```
       __    ___  _________    __  ___     _____ ____  ______
      / /   /   |/_  __/   |  /  |/  /    / ___// __ \/ ____/
     / /   / /| | / / / /| | / /|_/ /_____\__ \/ /_/ / /     
    / /___/ ___ |/ / / ___ |/ /  / /_____/__/ / _, _/ /___   
   /_____/_/  |_/_/ /_/  |_/_/  /_/     /____/_/ |_|\____/   
                                                             
    SERVIDOR       : paanelfree (64.176.5.61)
    RESELLER       : @SNIPER754186
    KEY FIJA       : latamsrcddev (activa)
   ```

---

## 6. Procedimiento para Futuras Instalaciones / Clientes

Para instalar en otro VPS usando este mismo esquema:
1. Clonar el repositorio en la máquina destino:
   ```bash
   git clone https://github.com/SNIPER754186/cghlatamsrc /root/cghlatamsrc
   ```
2. Ejecutar el instalador propio generado:
   ```bash
   bash /root/cghlatamsrc/4_INSTALACION/build/setup_latamsrc.sh --ADMcgh
   ```
3. La key fija configurada por defecto es:
   ```
   latamsrcddev
   ```
