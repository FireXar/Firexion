#!/bin/bash
# ============================================================
# PROTOCOLO BHTTP SERVER (Binary HTTP / Bitvise Tunneling)
# Integrado y Remasterizado para ADMcgh por Karl199x
# ============================================================

if [[ -s /bin/ejecutar/msg ]]; then
    source /bin/ejecutar/msg
elif [[ -s /etc/adm-lite/msg ]]; then
    source /etc/adm-lite/msg
elif [[ -s /etc/adm-lite/styles.cpp ]]; then
    source /etc/adm-lite/styles.cpp
fi

CONF_DIR="/etc/bhttp"
CONF_FILE="${CONF_DIR}/config.conf"
BIN_DEST="/etc/ADMcgh/bin/BHTTP"
BIN_SYS="/bin/BHTTP"
SERVICE_FILE="/etc/systemd/system/bhttp.service"

mkdir -p "$CONF_DIR" /etc/ADMcgh/bin 2>/dev/null

load_config() {
    if [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
    else
        BHTTP_PORTS="0.0.0.0:80,0.0.0.0:53"
        BHTTP_TARGET="127.0.0.1:22"
        BHTTP_TIMEOUT="2m0s"
        BHTTP_LANES="128"
        save_config
    fi
}

save_config() {
    cat <<EOF > "$CONF_FILE"
BHTTP_PORTS="${BHTTP_PORTS}"
BHTTP_TARGET="${BHTTP_TARGET}"
BHTTP_TIMEOUT="${BHTTP_TIMEOUT}"
BHTTP_LANES="${BHTTP_LANES}"
EOF
}

check_bin() {
    if [[ ! -f "$BIN_SYS" ]]; then
        echo -ne " ${cor[3]}Verificando binario BHTTP... "
        if [[ -f "$BIN_DEST" ]]; then
            cp -f "$BIN_DEST" "$BIN_SYS"
            chmod +x "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/bin/x86_64/BHTTP" ]]; then
            cp -f "/root/ChumoGH/bin/x86_64/BHTTP" "$BIN_DEST"
            cp -f "/root/ChumoGH/bin/x86_64/BHTTP" "$BIN_SYS"
            chmod +x "$BIN_DEST" "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        else
            wget -q --no-check-certificate -O "$BIN_SYS" "https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/BHTTP"
            if [[ $? -eq 0 && -s "$BIN_SYS" ]]; then
                chmod +x "$BIN_SYS"
                cp -f "$BIN_SYS" "$BIN_DEST"
                echo -e "${cor[2]}[OK]"
            else
                echo -e "${cor[1]}[FAIL]"
                msg -verm "Error descargando binario BHTTP."
                read -p "Presione ENTER para continuar..."
                return 1
            fi
        fi
    fi
    return 0
}

is_active() {
    systemctl is-active --quiet bhttp.service 2>/dev/null || pgrep -x BHTTP >/dev/null 2>&1
}

start_bhttp() {
    check_bin || return 1
    load_config

    msg -bar3
    echo -e " ${cor[2]}Activando servicio BHTTP en puertos :${cor[3]}${BHTTP_PORTS}..."
    msg -bar3

    cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=BHTTP Tunneling Server by Karl199x
After=network.target

[Service]
Type=simple
User=root
ExecStart=${BIN_SYS} -listen ${BHTTP_PORTS} -target ${BHTTP_TARGET} -session-timeout ${BHTTP_TIMEOUT} -bhttp-v2-max-lanes ${BHTTP_LANES}
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload &>/dev/null
    systemctl enable bhttp.service &>/dev/null
    systemctl restart bhttp.service &>/dev/null
    sleep 1

    IFS=',' read -ra ADDR <<< "$BHTTP_PORTS"
    for p in "${ADDR[@]}"; do
        port_num=$(echo "$p" | awk -F ':' '{print $NF}')
        command -v ufw >/dev/null 2>&1 && ufw allow "${port_num}"/tcp &>/dev/null
    done

    if is_active; then
        msg -verd " [OK] Servidor BHTTP iniciado y activado correctamente."
    else
        msg -verm " [ERROR] No se pudo iniciar el servidor BHTTP. Verifique si los puertos están ocupados."
    fi
    read -p "Presione ENTER para continuar..."
}

stop_bhttp() {
    msg -bar3
    echo -e " ${cor[1]}Deteniendo servicio BHTTP..."
    msg -bar3
    systemctl stop bhttp.service &>/dev/null
    systemctl disable bhttp.service &>/dev/null
    pkill -9 -x BHTTP &>/dev/null
    sleep 1
    msg -verd " [OK] Servidor BHTTP detenido."
    read -p "Presione ENTER para continuar..."
}

change_ports() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}CAMBIAR PUERTOS DE ESCUCHA BHTTP"
    msg -bar3
    echo -e " Puertos actuales: ${cor[2]}${BHTTP_PORTS}"
    echo -e " Ingrese los puertos separados por coma (ej: 0.0.0.0:80,0.0.0.0:8080 o :80,:8888)"
    read -p " Puertos: " new_ports
    if [[ -n "$new_ports" ]]; then
        BHTTP_PORTS="$new_ports"
        save_config
        msg -verd " Puertos actualizados a: $BHTTP_PORTS"
        if is_active; then
            start_bhttp
            return
        fi
    else
        msg -verm " Entrada vacia."
    fi
    read -p "Presione ENTER para continuar..."
}

change_target() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}CAMBIAR DESTINO LOCAL (SSH / DROPBEAR)"
    msg -bar3
    echo -e " Destino actual: ${cor[2]}${BHTTP_TARGET}"
    echo -e " Ingrese destino local en formato IP:PUERTO (ej. 127.0.0.1:22 o 127.0.0.1:442)"
    read -p " Destino: " new_target
    if [[ -n "$new_target" ]]; then
        BHTTP_TARGET="$new_target"
        save_config
        msg -verd " Destino actualizado a: $BHTTP_TARGET"
        if is_active; then
            start_bhttp
            return
        fi
    fi
    read -p "Presione ENTER para continuar..."
}

show_status() {
    clear
    msg -bar3
    echo -e "   ${cor[5]}ESTADO Y REGISTROS DEL SERVICIO BHTTP"
    msg -bar3
    if is_active; then
        echo -e " Estado: ${cor[2]}[ACTIVO / ON]"
        echo -e " Escuchando en: ${cor[3]}${BHTTP_PORTS}"
        echo -e " Destino local: ${cor[3]}${BHTTP_TARGET}"
        echo -e " Timeout sesion: ${cor[3]}${BHTTP_TIMEOUT}"
        msg -bar3
        systemctl status bhttp.service --no-pager 2>/dev/null | head -n 15
    else
        echo -e " Estado: ${cor[1]}[DETENIDO / OFF]"
    fi
    msg -bar3
    read -p "Presione ENTER para continuar..."
}

uninstall_bhttp() {
    stop_bhttp
    rm -f "$SERVICE_FILE" "$BIN_SYS" 2>/dev/null
    rm -rf "$CONF_DIR" 2>/dev/null
    systemctl daemon-reload &>/dev/null
    msg -verd " Protocolo BHTTP desinstalado completamente."
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
    echo -e "       ${cor[5]}🌐 PROTOCOLO BHTTP SERVER (Binary HTTP) 🌐"
    msg -bar3
    echo -e " Estado: $status_txt   ${cor[1]}Puertos: ${cor[2]}${BHTTP_PORTS}"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}INICIAR / ACTIVAR BHTTP"
    echo -e " \033[0;35m[\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}DETENER / DESACTIVAR BHTTP"
    echo -e " \033[0;35m[\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR PUERTOS DE ESCUCHA"
    echo -e " \033[0;35m[\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR DESTINO LOCAL (SSH / Dropbear)"
    echo -e " \033[0;35m[\033[0;36m5\033[0;35m]\033[0;33m ${flech} ${cor[3]}VER ESTADO / REGISTROS DEL SERVICIO"
    echo -e " \033[0;35m[\033[0;36m6\033[0;35m]\033[0;33m ${flech} \033[0;31mDESINSTALAR PROTOCOLO BHTTP"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
    msg -bar3

    read -p " Seleccione una opcion [0-6]: " opcion
    case "$opcion" in
        1) start_bhttp;;
        2) stop_bhttp;;
        3) change_ports;;
        4) change_target;;
        5) show_status;;
        6) uninstall_bhttp;;
        0) break;;
        *) msg -verm "Opcion invalida."; sleep 1;;
    esac
done
