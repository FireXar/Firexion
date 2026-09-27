#!/bin/bash
# ==============================================================================
#  ADMcgh - Script de Instalación Automatizado (Versión Libre / Sin Key)
#  Basado en la suite ChumoGH / ADM / LATAM
#  100% Sin Verificación de Key | Listo para GitHub
# ==============================================================================

export DEBIAN_FRONTEND=noninteractive
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/

# Colores básicos
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Verificar Root
if [ "$(id -u)" != "0" ]; then
    echo -e "\n${RED}====================================================${NC}"
    echo -e "   ${YELLOW}ERROR: Este script debe ejecutarse como root!${NC}"
    echo -e "   Ejecute: ${GREEN}sudo -i${NC} o ${GREEN}sudo su${NC}"
    echo -e "${RED}====================================================${NC}\n"
    exit 1
fi

clear
echo -e "${BLUE}============================================================${NC}"
echo -e "${WHITE}           INSTALADOR ADMcgh - VERSION LIBRE (SIN KEY)      ${NC}"
echo -e "${CYAN}             Desarrollado para despliegue directo           ${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""

# Determinar origen de los archivos (local o remoto)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IS_LOCAL=false
if [[ -d "${SCRIPT_DIR}/core" && -f "${SCRIPT_DIR}/core/menu" ]]; then
    IS_LOCAL=true
    REPO_DIR="${SCRIPT_DIR}"
fi

# Detectar Arquitectura
ARCH="$(uname -m 2>/dev/null)"
case "$ARCH" in
    x86_64) PLATFORM="x86_64" ;;
    aarch64|arm64) PLATFORM="aarch64" ;;
    *) PLATFORM="x86_64" ;;
esac

echo -e " ${GREEN}[+]${NC} Arquitectura detectada: ${CYAN}${PLATFORM}${NC}"

# Detectar IP pública
IP="$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)"
[[ -z "$IP" ]] && IP="$(curl -fsSL --connect-timeout 5 ifconfig.me 2>/dev/null)"
[[ -z "$IP" ]] && IP="$(wget -qO- --timeout=5 icanhazip.com 2>/dev/null)"
echo -e " ${GREEN}[+]${NC} IP del Servidor: ${CYAN}${IP}${NC}"

# Actualizar repositorios e instalar paquetes base
echo -e "\n ${YELLOW}[*]${NC} Actualizando repositorios e instalando dependencias..."
apt-get update -y >/dev/null 2>&1

PAQUETES=(
    bsdmainutils sudo cron screen nginx nload htop
    python3 python3-pip lsof psmisc socat bc netcat
    net-tools jq iptables curl wget figlet boxes lolcat pv
)

for pkg in "${PAQUETES[@]}"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        echo -ne "     Instalando ${pkg}... "
        apt-get install -y "$pkg" >/dev/null 2>&1 && echo -e "${GREEN}[OK]${NC}" || echo -e "${YELLOW}[OMITIDO]${NC}"
    fi
done

# Crear estructura de carpetas en el sistema
echo -e "\n ${YELLOW}[*]${NC} Configurando estructura de directorios del sistema..."
mkdir -p /etc/adm-lite
mkdir -p /etc/adm-lite/slow/dnsi
mkdir -p /etc/ADMcgh/bin
mkdir -p /bin/ejecutar
mkdir -p /var/www/html

# Si no estamos en un clon local, clonar repositorio temporal
if [ "$IS_LOCAL" = false ]; then
    echo -e " ${YELLOW}[*]${NC} Descargando archivos del repositorio..."
    TMP_DIR="$(mktemp -d /tmp/admcgh.XXXXXX)"
    if command -v git >/dev/null 2>&1; then
        git clone --depth 1 https://github.com/SNIPER754186/cghlatamsrc.git "$TMP_DIR" >/dev/null 2>&1 || true
    fi
    if [[ -d "${TMP_DIR}/core" ]]; then
        REPO_DIR="$TMP_DIR"
    else
        REPO_DIR="${SCRIPT_DIR}"
    fi
fi

# 1. Instalar Módulos del Núcleo (core)
echo -e " ${GREEN}[+]${NC} Instalando módulos principales en /etc/adm-lite/..."
if [[ -d "${REPO_DIR}/core" ]]; then
    cp -rf "${REPO_DIR}/core/"* /etc/adm-lite/
fi
chmod +x /etc/adm-lite/* >/dev/null 2>&1 || true

# 2. Instalar Plugins y Protocolos
echo -e " ${GREEN}[+]${NC} Instalando plugins y protocolos en /etc/ADMcgh/bin/..."
if [[ -d "${REPO_DIR}/plugins" ]]; then
    cp -rf "${REPO_DIR}/plugins/"* /etc/ADMcgh/bin/
    cp -rf "${REPO_DIR}/plugins/"* /etc/adm-lite/
fi
chmod +x /etc/ADMcgh/bin/* >/dev/null 2>&1 || true

# 3. Instalar Binarios según Arquitectura
echo -e " ${GREEN}[+]${NC} Instalando binarios de arquitectura (${PLATFORM})..."
if [[ -f "${REPO_DIR}/bin/${PLATFORM}/add_new_user.bin" ]]; then
    cp -f "${REPO_DIR}/bin/${PLATFORM}/add_new_user.bin" /etc/ADMcgh/bin/useradd
    chmod +x /etc/ADMcgh/bin/useradd
    ln -sf /etc/ADMcgh/bin/useradd /bin/add_new_user
fi

# 4. Instalar Herramientas Auxiliares
if [[ -f "${REPO_DIR}/bin/toolmaster.py" ]]; then
    cp -f "${REPO_DIR}/bin/toolmaster.py" /etc/ADMcgh/bin/SBdm
    chmod +x /etc/ADMcgh/bin/SBdm
    ln -sf /etc/ADMcgh/bin/SBdm /bin/toolmaster
fi

if [[ -f "${REPO_DIR}/bin/upLIC" ]]; then
    cp -f "${REPO_DIR}/bin/upLIC" /etc/ADMcgh/bin/upLIC
    chmod +x /etc/ADMcgh/bin/upLIC
    ln -sf /etc/ADMcgh/bin/upLIC /bin/upLIC
fi

if [[ -f "${REPO_DIR}/bin/root-pass.sh" ]]; then
    cp -f "${REPO_DIR}/bin/root-pass.sh" /bin/root-pass.sh
    chmod +x /bin/root-pass.sh
fi

# 5. Instalar Motor Gráfico y Estilos
if [[ -f "${REPO_DIR}/styles/msg" ]]; then
    cp -f "${REPO_DIR}/styles/msg" /bin/ejecutar/msg
    chmod +x /bin/ejecutar/msg
fi

# 6. Instalar Panel Web
if [[ -f "${REPO_DIR}/web/index.html" ]]; then
    cp -f "${REPO_DIR}/web/index.html" /var/www/html/index.html
fi

# 7. Configurar Parámetros del Entorno
echo "${IP}" > /bin/ejecutar/IPcgh
echo "V2.5.0" > /bin/ejecutar/v-new.log
echo "V2.5.0" > /etc/adm-lite/v-local.log
echo "0" > /bin/ejecutar/uskill
echo "ACTIVADO (Sin Key)" > /bin/ejecutar/exito
[[ ! -f /etc/adm-lite/menu_credito ]] && echo "ADMcgh Libre" > /etc/adm-lite/menu_credito
cp -f /etc/adm-lite/menu_credito /bin/ejecutar/menu_credito 2>/dev/null || true

# 8. Crear Lanzadores del Sistema
echo -e " ${GREEN}[+]${NC} Creando ejecutables globales (/bin/menu, /bin/cgh, /bin/adm)..."

cat << 'EOF' > /bin/menu
#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/menu

cat << 'EOF' > /bin/cgh
#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/cgh

cat << 'EOF' > /bin/adm
#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/adm

cat << 'EOF' > /bin/autoboot
#!/bin/bash
clear
chmod +x /bin/autoboot
ln -sf /bin/autoboot /etc/ADMcgh/bin/AutoRestart 2>/dev/null
EOF
chmod +x /bin/autoboot

# 9. Configurar Tarea Programada (Watchdog)
(
    crontab -l 2>/dev/null | grep -v "/bin/autoboot"
    echo "@reboot /bin/autoboot"
    echo "* * * * * /bin/autoboot"
) | crontab - 2>/dev/null || true

systemctl enable cron >/dev/null 2>&1 || true
systemctl start cron >/dev/null 2>&1 || true

# 10. Configurar Banner de Inicio (bashrc)
cat << 'EOF' > /etc/ADMcgh/bashrc
if [ "$(id -u)" = "0" ]; then
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
    [[ -z $(locale | grep "LANG=" | cut -d "=" -f2) ]] && export LANG=en_US.UTF-8
    DATE=$(date +"%d-%m-%Y")
    TIME=$(date +"%T")
    echo ""
    command -v figlet >/dev/null 2>&1 && figlet -f slant "ADMcgh" | lolcat 2>/dev/null || echo -e "\033[1;36m=== ADMcgh ===\033[0m"
    echo ""
    echo -e " \033[1;33mSERVIDOR       :\033[0m $HOSTNAME ($(cat /bin/ejecutar/IPcgh 2>/dev/null))"
    echo -e " \033[1;33mSISTEMA        :\033[0m $(lsb_release -d 2>/dev/null | cut -f2 || uname -s)"
    echo -e " \033[1;33mFECHA / HORA   :\033[0m $DATE - $TIME"
    echo -e " \033[1;33mESTADO KEY     :\033[0m \033[1;32mLIBRE / SIN VERIFICACION (ACTIVADO)\033[0m"
    echo -e " \033[1;33mMEMORIA LIBRE  :\033[0m $(free -h | awk '/Mem:/{print $4}')"
    echo ""
    echo -e " \033[1;42m Teclee: menu , cgh o adm para entrar al panel \033[0m"
    echo ""
fi
EOF

if ! grep -q "/etc/ADMcgh/bashrc" /etc/bash.bashrc 2>/dev/null; then
    echo -e "\nsource /etc/ADMcgh/bashrc" >> /etc/bash.bashrc
fi

# Eliminar cualquier residuo de verificación previa
rm -f /etc/cghkey /etc/chekKEY /etc/folteto /file /linux-kernel 2>/dev/null || true

# Optimizar cachés
sync
echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true

# Limpiar temporales
[[ -n "$TMP_DIR" && -d "$TMP_DIR" ]] && rm -rf "$TMP_DIR"

echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}       INSTALACION COMPLETADA EXITOSAMENTE (SIN KEY)        ${NC}"
echo -e "${GREEN}============================================================${NC}"
echo -e " ${WHITE}Puede acceder al menú en cualquier momento tecleando:${NC}"
echo -e "   ${CYAN}menu${NC}  o  ${CYAN}cgh${NC}  o  ${CYAN}adm${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""
