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

CONF_DIR="/etc/hcr"
CONF_FILE="${CONF_DIR}/config.conf"
BIN_DEST="/etc/ADMcgh/bin/HCR"
BIN_SYS="/bin/HCR"
SERVICE_FILE="/etc/systemd/system/hcr.service"

mkdir -p "$CONF_DIR" /etc/ADMcgh/bin 2>/dev/null

load_config() {
    if [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
    else
        HCR_PORT="8880"
        HCR_TARGET="127.0.0.1:22"
        HCR_TRANSPORT="auto"
        HCR_TIMEOUT="25s"
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
HCR_MAX_CONN="${HCR_MAX_CONN}"
EOF
}

check_bin() {
    if [[ ! -f "$BIN_SYS" ]]; then
        echo -ne " ${cor[3]}Verificando binario HCR... "
        if [[ -f "$BIN_DEST" ]]; then
            cp -f "$BIN_DEST" "$BIN_SYS"
            chmod +x "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/bin/x86_64/HCR" ]]; then
            cp -f "/root/ChumoGH/bin/x86_64/HCR" "$BIN_DEST"
            cp -f "/root/ChumoGH/bin/x86_64/HCR" "$BIN_SYS"
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

is_active() {
    systemctl is-active --quiet hcr.service 2>/dev/null || pgrep -x HCR >/dev/null 2>&1
}

start_hcr() {
    check_bin || return 1
    load_config

    msg -bar3
    echo -e " ${cor[2]}Activando servicio HCR en el puerto :${cor[3]}${HCR_PORT} (Modo: ${HCR_TRANSPORT})..."
    msg -bar3

    cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=HCR Tunneling Server by Karl199x
After=network.target

[Service]
Type=simple
User=root
ExecStart=${BIN_SYS} -listen :${HCR_PORT} -target ${HCR_TARGET} -transport ${HCR_TRANSPORT} -download-poll-timeout ${HCR_TIMEOUT} -max-connections ${HCR_MAX_CONN}
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload &>/dev/null
    systemctl enable hcr.service &>/dev/null
    systemctl restart hcr.service &>/dev/null
    sleep 1

    command -v ufw >/dev/null 2>&1 && ufw allow "${HCR_PORT}"/tcp &>/dev/null

    if is_active; then
        msg -verd " [OK] Servidor HCR iniciado y activado correctamente."
    else
        msg -verm " [ERROR] No se pudo iniciar el servidor HCR. Verifique logs."
    fi
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
    read -p " Ingrese el nuevo puerto (ej. 8880, 8080): " new_port
    if [[ -n "$new_port" && "$new_port" =~ ^[0-9]+$ ]]; then
        if lsof -Pi :"$new_port" -sTCP:LISTEN -t >/dev/null 2>&1; then
            msg -verm " El puerto $new_port ya esta en uso por otro servicio."
        else
            HCR_PORT="$new_port"
            save_config
            msg -verd " Puerto actualizado a: $HCR_PORT"
            if is_active; then
                start_hcr
                return
            fi
        fi
    else
        msg -verm " Puerto invalido."
    fi
    read -p "Presione ENTER para continuar..."
}

change_transport() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}SELECCIONAR MODO DE TRANSPORTE HCR"
    msg -bar3
    echo -e " Modo actual: ${cor[2]}${HCR_TRANSPORT}"
    echo -e " [1] auto  (Soporta TLS y Plain simultáneamente - Recomendado)"
    echo -e " [2] plain (Solo tráfico HTTP Plano sin SSL)"
    echo -e " [3] tls   (Requiere certificado TLS)"
    echo -e " [0] Cancelar"
    msg -bar3
    read -p " Seleccione una opcion: " t_opt
    case "$t_opt" in
        1) HCR_TRANSPORT="auto";;
        2) HCR_TRANSPORT="plain";;
        3) HCR_TRANSPORT="tls";;
        0) return;;
        *) msg -verm "Opcion invalida"; sleep 1; return;;
    esac
    save_config
    msg -verd " Modo de transporte cambiado a: $HCR_TRANSPORT"
    if is_active; then
        start_hcr
        return
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
    read -p " Destino: " new_target
    if [[ -n "$new_target" ]]; then
        HCR_TARGET="$new_target"
        save_config
        msg -verd " Destino actualizado a: $HCR_TARGET"
        if is_active; then
            start_hcr
            return
        fi
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
    stop_hcr
    rm -f "$SERVICE_FILE" "$BIN_SYS" 2>/dev/null
    rm -rf "$CONF_DIR" 2>/dev/null
    systemctl daemon-reload &>/dev/null
    msg -verd " Protocolo HCR desinstalado completamente."
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
    echo -e "     ${cor[5]}⚡ PROTOCOLO HCR SERVER (HTTP Custom Runner) ⚡"
    msg -bar3
    echo -e " Estado: $status_txt   ${cor[1]}Puerto: ${cor[2]}${HCR_PORT}   ${cor[1]}Modo: ${cor[2]}${HCR_TRANSPORT}"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}INICIAR / ACTIVAR HCR"
    echo -e " \033[0;35m[\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}DETENER / DESACTIVAR HCR"
    echo -e " \033[0;35m[\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR PUERTO DE ESCUCHA"
    echo -e " \033[0;35m[\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR MODO TRANSPORTE (Auto/Plain/TLS)"
    echo -e " \033[0;35m[\033[0;36m5\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR DESTINO LOCAL (SSH / Dropbear)"
    echo -e " \033[0;35m[\033[0;36m6\033[0;35m]\033[0;33m ${flech} ${cor[3]}VER ESTADO / REGISTROS DEL SERVICIO"
    echo -e " \033[0;35m[\033[0;36m7\033[0;35m]\033[0;33m ${flech} \033[0;31mDESINSTALAR PROTOCOLO HCR"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
    msg -bar3

    read -p " Seleccione una opcion [0-7]: " opcion
    case "$opcion" in
        1) start_hcr;;
        2) stop_hcr;;
        3) change_port;;
        4) change_transport;;
        5) change_target;;
        6) show_status;;
        7) uninstall_hcr;;
        0) break;;
        *) msg -verm "Opcion invalida."; sleep 1;;
    esac
done
