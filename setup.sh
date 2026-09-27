#!/bin/bash
# ==============================================================================
#  ADMcgh - Asistente Interactivo de Instalación (Versión Libre / Sin Key)
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colores
C_NUM='\033[0;35m'
C_OPT='\033[0;33m'
C_OK='\033[1;32m'
C_ERR='\033[1;31m'
C_TIT='\033[1;36m'
C_BAR='\033[0;34m'
NC='\033[0m'

clear
echo -e "${C_BAR}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${C_TIT}       PANEL DE INSTALACION ADMcgh (SIN KEY)      ${NC}"
echo -e "${C_BAR}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${C_OK}✓${NC} Sistema de Verificación de Key: ${C_OK}ELIMINADO${NC}"
echo -e " ${C_OK}✓${NC} Modo de Instalación: ${C_OK}100% LIBRE / LOCAL${NC}"
echo -e "${C_BAR}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${C_NUM}[1]${NC} ${C_OPT}Instalar ADMcgh Completo (Recomendado)${NC}"
echo -e " ${C_NUM}[2]${NC} ${C_OPT}Actualizar Módulos y Menú (/etc/adm-lite)${NC}"
echo -e " ${C_NUM}[3]${NC} ${C_OPT}Instalar Binarios de Usuarios (add_new_user)${NC}"
echo -e " ${C_NUM}[4]${NC} ${C_OPT}Optimizar Sistema y Limpiar Caché (upLIC)${NC}"
echo -e " ${C_NUM}[0]${NC} ${C_OPT}Salir${NC}"
echo -e "${C_BAR}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

read -p " Seleccione una opción [0-4]: " opc

case "$opc" in
    1)
        bash "${SCRIPT_DIR}/install.sh"
        ;;
    2)
        echo -e "\n ${C_OK}[+]${NC} Actualizando /etc/adm-lite/..."
        mkdir -p /etc/adm-lite
        cp -rf "${SCRIPT_DIR}/core/"* /etc/adm-lite/
        cp -rf "${SCRIPT_DIR}/plugins/"* /etc/adm-lite/
        chmod +x /etc/adm-lite/*
        echo -e " ${C_OK}[OK]${NC} Módulos actualizados. Escriba 'menu' para iniciar.\n"
        ;;
    3)
        ARCH="$(uname -m 2>/dev/null)"
        case "$ARCH" in
            x86_64) PLAT="x86_64" ;;
            aarch64|arm64) PLAT="aarch64" ;;
            *) PLAT="x86_64" ;;
        esac
        mkdir -p /etc/ADMcgh/bin
        cp -f "${SCRIPT_DIR}/bin/${PLAT}/add_new_user.bin" /etc/ADMcgh/bin/useradd
        chmod +x /etc/ADMcgh/bin/useradd
        ln -sf /etc/ADMcgh/bin/useradd /bin/add_new_user
        echo -e "\n ${C_OK}[OK]${NC} Binario ${PLAT} instalado en /bin/add_new_user\n"
        ;;
    4)
        if [[ -f "${SCRIPT_DIR}/bin/upLIC" ]]; then
            bash "${SCRIPT_DIR}/bin/upLIC"
            echo -e "\n ${C_OK}[OK]${NC} Optimización ejecutada.\n"
        fi
        ;;
    0)
        echo -e "\n Operación cancelada.\n"
        exit 0
        ;;
    *)
        echo -e "\n ${C_ERR}Opción no válida.${NC}\n"
        exit 1
        ;;
esac
