#!/bin/bash
# ============================================================
# PROTOCOLO HCR SERVER (HTTP Custom Relay / Runner)
# Integrado y Remasterizado para ADMcgh por Karl199x
# ============================================================

if [[ -s /bin/ejecutar/msg ]]; then
    source /bin/ejecutar/msg
elif [[ -s /etc/adm-lite/msg ]]; then
    source /etc/adm-lite/msg
elif [[ -s /etc/adm-lite/styles.cpp ]]; then
    source /etc/adm-lite/styles.cpp
fi

# Fallbacks de emergencia para funciones visuales
if ! declare -f msg >/dev/null 2>&1; then
    msg() {
        case "$1" in
            -bar|-bar2|-bar3|-bar4|-blue|-br) echo -e "\033[1;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" ;;
            -verd|-nverd) echo -e "\033[1;32m${2}\033[0m" ;;
            -verm|-verm2|-verm3) echo -e "\033[1;31m${2}\033[0m" ;;
            -ama|-nama) echo -e "\033[1;33m${2}\033[0m" ;;
            -bra) echo -e "\033[1;37m${2}\033[0m" ;;
            *) echo -e "${2}" ;;
        esac
    }
fi
if ! declare -f selection_fun >/dev/null 2>&1; then
    selection_fun() {
        local selection="null"
        local opc=$1
        local range
        for((i=0; i<=${opc}; i++)); do range[$i]="$i "; done
        while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
            echo -ne "\033[1;37m ► Opcion : \033[0m" >&2
            read selection
            tput cuu1 >&2 && tput dl1 >&2
        done
        echo "$selection"
    }
fi
if ! declare -f print_center >/dev/null 2>&1; then
    print_center() { echo -e "$*"; }
fi
if ! declare -f tittle >/dev/null 2>&1; then
    tittle() { msg -bar3; echo -e "        ADMcgh Plus VPS Manager "; msg -bar3; }
fi

CONF_DIR="/etc/hcr"
CONF_FILE="${CONF_DIR}/config.conf"
BIN_DEST="/etc/ADMcgh/bin/HCR"
BIN_SYS="/bin/HCR"
SERVICE_FILE="/etc/systemd/system/hcr.service"
CERT_FILE="${CONF_DIR}/cert.pem"
KEY_FILE="${CONF_DIR}/key.pem"

mkdir -p "$CONF_DIR" /etc/ADMcgh/bin 2>/dev/null

load_config() {
    if [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
    else
        HCR_PORT="8880"
        HCR_TARGET="127.0.0.1:22"
        HCR_TRANSPORT="plain"
        HCR_TIMEOUT="25s"
        HCR_FRAME="16384"
        HCR_MAX_CONN="2048"
        save_config
    fi
}

save_config() {
    cat <<EOF > "$CONF_FILE"
HCR_PORT="${HCR_PORT}"
HCR_TARGET="${HCR_TARGET}"
HCR_TRANSPORT="${HCR_TRANSPORT}"
HCR_TIMEOUT="${HCR_TIMEOUT}"
HCR_FRAME="${HCR_FRAME}"
HCR_MAX_CONN="${HCR_MAX_CONN}"
EOF
}

check_bin() {
    if [[ ! -f "$BIN_SYS" || ! -x "$BIN_SYS" ]]; then
        echo -ne " ${cor[3]}Verificando binario HCR... "
        if [[ -f "$BIN_DEST" && -x "$BIN_DEST" ]]; then
            cp -f "$BIN_DEST" "$BIN_SYS"
            chmod +x "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/bin/x86_64/HCR" ]]; then
            cp -f "/root/ChumoGH/bin/x86_64/HCR" "$BIN_DEST"
            cp -f "/root/ChumoGH/bin/x86_64/HCR" "$BIN_SYS"
            chmod +x "$BIN_DEST" "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/plugins/HCR" ]]; then
            cp -f "/root/ChumoGH/plugins/HCR" "$BIN_DEST"
            cp -f "/root/ChumoGH/plugins/HCR" "$BIN_SYS"
            chmod +x "$BIN_DEST" "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        else
            wget -q --no-check-certificate -O "$BIN_SYS" "https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/HCR"
            if [[ $? -eq 0 && -s "$BIN_SYS" ]]; then
                chmod +x "$BIN_SYS"
                cp -f "$BIN_SYS" "$BIN_DEST"
                echo -e "${cor[2]}[OK]"
            else
                echo -e "${cor[1]}[FAIL]"
                msg -verm "Error descargando binario HCR."
                read -p "Presione ENTER para continuar..."
                return 1
            fi
        fi
    fi
    return 0
}

check_tls_certs() {
    if [[ ! -f "$CERT_FILE" || ! -f "$KEY_FILE" ]]; then
        mkdir -p "$CONF_DIR"
        openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
            -subj "/C=US/ST=Global/L=Cloud/O=HCR/CN=hcr.server" \
            -keyout "$KEY_FILE" -out "$CERT_FILE" &>/dev/null
        chmod 600 "$KEY_FILE" "$CERT_FILE"
    fi
}

is_active() {
    systemctl is-active --quiet hcr.service 2>/dev/null || pgrep -x HCR >/dev/null 2>&1
}

apply_service() {
    check_bin || return 1
    load_config

    local extra_args=""
    if [[ "$HCR_TRANSPORT" == "tls" ]]; then
        check_tls_certs
        extra_args="-tls-cert ${CERT_FILE} -tls-key ${KEY_FILE}"
    fi

    cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=HCR Tunneling Server by Karl199x
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
ExecStart=${BIN_SYS} -listen :${HCR_PORT} -target ${HCR_TARGET} -transport ${HCR_TRANSPORT} ${extra_args} -max-download-frame ${HCR_FRAME} -download-poll-timeout ${HCR_TIMEOUT} -max-connections ${HCR_MAX_CONN}
Restart=always
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload &>/dev/null
    systemctl enable hcr.service &>/dev/null
    systemctl restart hcr.service &>/dev/null
    sleep 1

    command -v ufw >/dev/null 2>&1 && ufw allow "${HCR_PORT}"/tcp &>/dev/null

    if is_active; then
        msg -verd " [OK] Servidor HCR activado correctamente en puerto :${HCR_PORT} (Modo: ${HCR_TRANSPORT})"
    else
        msg -verm " [ERROR] No se pudo iniciar el servicio HCR. Verifique si el puerto esta ocupado."
    fi
}

modo_plain() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}⚡ MODO 1: HTTP CUSTOM PLAIN (BHP1) ⚡"
    msg -bar3
    echo -e " Modo para inyeccion directa HTTP / Payload HTTP Custom (Sin SSL)"
    echo -e " Puerto sugerido: 80, 8080, 8880"
    echo -e " Puerto actual: ${cor[2]}${HCR_PORT}"
    read -p " Ingrese puerto de escucha [Enter = ${HCR_PORT}]: " p_in
    [[ -n "$p_in" && "$p_in" =~ ^[0-9]+$ ]] && HCR_PORT="$p_in"
    HCR_TRANSPORT="plain"
    save_config
    apply_service
    read -p "Presione ENTER para continuar..."
}

modo_tls() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}🔒 MODO 2: HTTP CUSTOM TLS / SSL 🔒"
    msg -bar3
    echo -e " Modo seguro cifrado con TLS / Certificado SSL"
    echo -e " Puerto sugerido: 443, 8443, 2083"
    echo -e " Puerto actual: ${cor[2]}${HCR_PORT}"
    read -p " Ingrese puerto de escucha [Enter = 443]: " p_in
    if [[ -n "$p_in" && "$p_in" =~ ^[0-9]+$ ]]; then
        HCR_PORT="$p_in"
    else
        [[ "$HCR_PORT" == "8880" || "$HCR_PORT" == "8080" ]] && HCR_PORT="443"
    fi
    HCR_TRANSPORT="tls"
    save_config
    apply_service
    read -p "Presione ENTER para continuar..."
}

start_hcr() {
    msg -bar3
    echo -e " ${cor[2]}Iniciando / Reiniciando servicio HCR..."
    msg -bar3
    apply_service
    read -p "Presione ENTER para continuar..."
}

stop_hcr() {
    msg -bar3
    echo -e " ${cor[1]}Deteniendo servicio HCR..."
    msg -bar3
    systemctl stop hcr.service &>/dev/null
    systemctl disable hcr.service &>/dev/null
    pkill -9 -x HCR &>/dev/null
    sleep 1
    msg -verd " [OK] Servidor HCR detenido."
    read -p "Presione ENTER para continuar..."
}

change_port() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}CAMBIAR PUERTO DE ESCUCHA HCR"
    msg -bar3
    echo -e " Puerto actual: ${cor[2]}${HCR_PORT}"
    read -p " Ingrese el nuevo puerto (ej. 8880, 8080, 443): " new_port
    if [[ -n "$new_port" && "$new_port" =~ ^[0-9]+$ ]]; then
        if lsof -Pi :"$new_port" -sTCP:LISTEN -t >/dev/null 2>&1; then
            msg -verm " El puerto $new_port ya esta en uso por otro servicio."
        else
            HCR_PORT="$new_port"
            save_config
            msg -verd " Puerto actualizado a: $HCR_PORT"
            if is_active; then
                apply_service
                read -p "Presione ENTER para continuar..."
                return
            fi
        fi
    else
        msg -verm " Puerto invalido."
    fi
    read -p "Presione ENTER para continuar..."
}

change_target() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}CAMBIAR DESTINO LOCAL (SSH / DROPBEAR)"
    msg -bar3
    echo -e " Destino actual: ${cor[2]}${HCR_TARGET}"
    echo -e " Ingrese destino local en formato IP:PUERTO (ej. 127.0.0.1:22 o 127.0.0.1:442)"
    read -p " Destino [Enter = 127.0.0.1:22]: " new_target
    [[ -z "$new_target" ]] && new_target="127.0.0.1:22"
    HCR_TARGET="$new_target"
    save_config
    msg -verd " Destino actualizado a: $HCR_TARGET"
    if is_active; then
        apply_service
        read -p "Presione ENTER para continuar..."
        return
    fi
    read -p "Presione ENTER para continuar..."
}

show_status() {
    clear
    msg -bar3
    echo -e "   ${cor[5]}ESTADO Y REGISTROS DEL SERVICIO HCR"
    msg -bar3
    if is_active; then
        echo -e " Estado: ${cor[2]}[ACTIVO / ON]"
        echo -e " Escuchando en: ${cor[3]}:${HCR_PORT}"
        echo -e " Destino local: ${cor[3]}${HCR_TARGET}"
        echo -e " Modo transporte: ${cor[3]}${HCR_TRANSPORT}"
        msg -bar3
        systemctl status hcr.service --no-pager 2>/dev/null | head -n 15
    else
        echo -e " Estado: ${cor[1]}[DETENIDO / OFF]"
    fi
    msg -bar3
    read -p "Presione ENTER para continuar..."
}

uninstall_hcr() {
    clear
    msg -bar3
    echo -e "   ${cor[1]}DESINSTALAR PROTOCOLO HCR"
    msg -bar3
    read -p " ¿Esta seguro de desinstalar HCR? [s/N]: " conf
    if [[ "$conf" = @(s|S|y|Y) ]]; then
        stop_hcr
        rm -f "$SERVICE_FILE" "$BIN_SYS" "$BIN_DEST" 2>/dev/null
        rm -rf "$CONF_DIR" 2>/dev/null
        systemctl daemon-reload &>/dev/null
        msg -verd " Protocolo HCR desinstalado completamente."
    else
        echo " Operacion cancelada."
    fi
    read -p "Presione ENTER para continuar..."
}

# Bucle principal de menú
while true; do
    load_config
    clear
    if is_active; then
        status_txt="\033[1;32m[ON]"
    else
        status_txt="\033[1;31m[OFF]"
    fi

    msg -bar3
    echo -e "     ${cor[5]}⚡ PROTOCOLO HCR SERVER (HTTP Custom Relay) ⚡"
    msg -bar3
    echo -e " Estado: $status_txt   ${cor[1]}Puerto: ${cor[2]}${HCR_PORT}   ${cor[1]}Modo: ${cor[2]}${HCR_TRANSPORT}"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}MODO HTTP CUSTOM PLAIN (BHP1 - Puerto :${HCR_PORT})"
    echo -e " \033[0;35m[\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}MODO HTTP CUSTOM TLS   (SSL / Certificado)"
    echo -e " \033[0;35m[\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}INICIAR / REINICIAR SERVICIO"
    echo -e " \033[0;35m[\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}DETENER SERVICIO"
    echo -e " \033[0;35m[\033[0;36m5\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR PUERTO DE ESCUCHA"
    echo -e " \033[0;35m[\033[0;36m6\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR DESTINO LOCAL (SSH 22)"
    echo -e " \033[0;35m[\033[0;36m7\033[0;35m]\033[0;33m ${flech} ${cor[3]}VER ESTADO / REGISTROS EN VIVO"
    echo -e " \033[0;35m[\033[0;36m8\033[0;35m]\033[0;33m ${flech} \033[0;31mDESINSTALAR PROTOCOLO HCR"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
    msg -bar3

    selection=$(selection_fun 8)
    case "$selection" in
        1) modo_plain;;
        2) modo_tls;;
        3) start_hcr;;
        4) stop_hcr;;
        5) change_port;;
        6) change_target;;
        7) show_status;;
        8) uninstall_hcr;;
        0) break;;
        *) msg -verm "Opcion invalida."; sleep 1;;
    esac
done
