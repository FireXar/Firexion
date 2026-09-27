#!/bin/bash
# ============================================================
# PROTOCOLO BHTTP SERVER (Binary HTTP / DTProto / Bitvise)
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

CONF_DIR="/etc/bhttp"
CONF_FILE="${CONF_DIR}/config.conf"
BIN_DEST="/etc/ADMcgh/bin/BHTTP"
BIN_SYS="/bin/BHTTP"
SERVICE_FILE="/etc/systemd/system/bhttp.service"
CERT_FILE="${CONF_DIR}/cert.pem"
KEY_FILE="${CONF_DIR}/key.pem"

mkdir -p "$CONF_DIR" /etc/ADMcgh/bin 2>/dev/null

load_config() {
    if [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
    else
        BHTTP_PORTS="0.0.0.0:80,0.0.0.0:53"
        BHTTP_TARGET="127.0.0.1:22"
        BHTTP_TIMEOUT="2m0s"
        BHTTP_LANES="128"
        BHTTP_MODE="dtproto"
        BHTTP_XHTTP_PORT="443"
        save_config
    fi
}

save_config() {
    cat <<EOF > "$CONF_FILE"
BHTTP_PORTS="${BHTTP_PORTS}"
BHTTP_TARGET="${BHTTP_TARGET}"
BHTTP_TIMEOUT="${BHTTP_TIMEOUT}"
BHTTP_LANES="${BHTTP_LANES}"
BHTTP_MODE="${BHTTP_MODE}"
BHTTP_XHTTP_PORT="${BHTTP_XHTTP_PORT}"
EOF
}

check_bin() {
    if [[ ! -f "$BIN_SYS" || ! -x "$BIN_SYS" ]]; then
        echo -ne " ${cor[3]}Verificando binario BHTTP... "
        if [[ -f "$BIN_DEST" && -x "$BIN_DEST" ]]; then
            cp -f "$BIN_DEST" "$BIN_SYS"
            chmod +x "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/bin/x86_64/BHTTP" ]]; then
            cp -f "/root/ChumoGH/bin/x86_64/BHTTP" "$BIN_DEST"
            cp -f "/root/ChumoGH/bin/x86_64/BHTTP" "$BIN_SYS"
            chmod +x "$BIN_DEST" "$BIN_SYS"
            echo -e "${cor[2]}[OK]"
        elif [[ -f "/root/ChumoGH/plugins/BHTTP" ]]; then
            cp -f "/root/ChumoGH/plugins/BHTTP" "$BIN_DEST"
            cp -f "/root/ChumoGH/plugins/BHTTP" "$BIN_SYS"
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

check_tls_certs() {
    if [[ ! -f "$CERT_FILE" || ! -f "$KEY_FILE" ]]; then
        mkdir -p "$CONF_DIR"
        openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
            -subj "/C=US/ST=Global/L=Cloud/O=BHTTP/CN=bhttp.server" \
            -keyout "$KEY_FILE" -out "$CERT_FILE" &>/dev/null
        chmod 600 "$KEY_FILE" "$CERT_FILE"
    fi
}

is_active() {
    systemctl is-active --quiet bhttp.service 2>/dev/null || pgrep -x BHTTP >/dev/null 2>&1
}

apply_service() {
    check_bin || return 1
    load_config

    local extra_args=""
    if [[ "$BHTTP_MODE" == "xhttp" ]]; then
        check_tls_certs
        extra_args="-xhttp-listen 0.0.0.0:${BHTTP_XHTTP_PORT} -tls-cert ${CERT_FILE} -tls-key ${KEY_FILE}"
    fi

    cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=BHTTP Tunneling Server by Karl199x
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
ExecStart=${BIN_SYS} -listen ${BHTTP_PORTS} -target ${BHTTP_TARGET} -session-timeout ${BHTTP_TIMEOUT} -bhttp-v2-max-lanes ${BHTTP_LANES} ${extra_args}
Restart=always
RestartSec=3
LimitNOFILE=65535

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
        [[ -n "$port_num" ]] && command -v ufw >/dev/null 2>&1 && ufw allow "${port_num}"/tcp &>/dev/null
    done
    [[ "$BHTTP_MODE" == "xhttp" ]] && command -v ufw >/dev/null 2>&1 && ufw allow "${BHTTP_XHTTP_PORT}"/tcp &>/dev/null

    if is_active; then
        msg -verd " [OK] Servidor BHTTP activado correctamente en puertos [${BHTTP_PORTS}] (Modo: ${BHTTP_MODE})"
    else
        msg -verm " [ERROR] No se pudo iniciar el servidor BHTTP. Verifique logs o puertos ocupados."
    fi
}

modo_dtproto() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}🌐 MODO 1: BHTTP OFICIAL / DTPROTO (BHP1) 🌐"
    msg -bar3
    echo -e " Protocolo binario HTTP plano optimizado para DTunnel / BHP1"
    echo -e " Puertos actuales: ${cor[2]}${BHTTP_PORTS}"
    read -p " Ingrese puertos separados por coma [Enter = 0.0.0.0:80,0.0.0.0:53]: " p_in
    [[ -n "$p_in" ]] && BHTTP_PORTS="$p_in" || BHTTP_PORTS="0.0.0.0:80,0.0.0.0:53"
    BHTTP_MODE="dtproto"
    save_config
    apply_service
    read -p "Presione ENTER para continuar..."
}

modo_xhttp() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}🔒 MODO 2: BHTTP XHTTP / TLS (SSL / HTTP2) 🔒"
    msg -bar3
    echo -e " Modo BHTTP seguro con multiplexación TLS / HTTP2"
    echo -e " Puerto XHTTP actual: ${cor[2]}${BHTTP_XHTTP_PORT}"
    read -p " Ingrese puerto TLS/XHTTP [Enter = 443]: " p_in
    [[ -n "$p_in" && "$p_in" =~ ^[0-9]+$ ]] && BHTTP_XHTTP_PORT="$p_in" || BHTTP_XHTTP_PORT="443"
    BHTTP_MODE="xhttp"
    save_config
    apply_service
    read -p "Presione ENTER para continuar..."
}

start_bhttp() {
    msg -bar3
    echo -e " ${cor[2]}Iniciando / Reiniciando servicio BHTTP..."
    msg -bar3
    apply_service
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

probe_bhttp() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}🧪 PRUEBA REAL BHTTP PROBE (BHP1 Handshake)"
    msg -bar3
    local p_test=$(echo "$BHTTP_PORTS" | awk -F ',' '{print $1}' | awk -F ':' '{print $NF}')
    [[ -z "$p_test" ]] && p_test="80"
    echo -e " Probando protocolo BHTTP contra 127.0.0.1:${cor[2]}${p_test}..."
    python3 -c '
import socket, sys
host = "127.0.0.1"
port = int("'$p_test'")
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(3.0)
    s.connect((host, port))
    # Magic BHP1 probe
    s.sendall(b"BHP1\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
    resp = s.recv(16)
    if b"BHP1" in resp or len(resp) > 0:
        print("\033[1;32m[PASS] Protocolo BHTTP respondio correctamente.\033[0m")
    else:
        print("\033[1;33m[INFO] Conectado exitosamente en el socket TCP.\033[0m")
    s.close()
except Exception as e:
    print(f"\033[1;31m[FAIL] Error en la prueba: {e}\033[0m")
' 2>/dev/null
    msg -bar3
    read -p "Presione ENTER para continuar..."
}

change_ports() {
    load_config
    clear
    msg -bar3
    echo -e "   ${cor[5]}CAMBIAR PUERTOS DE ESCUCHA BHTTP"
    msg -bar3
    echo -e " Puertos actuales: ${cor[2]}${BHTTP_PORTS}"
    echo -e " Ingrese los puertos separados por coma (ej: 0.0.0.0:80,0.0.0.0:8088 o :80,:53)"
    read -p " Puertos: " new_ports
    if [[ -n "$new_ports" ]]; then
        BHTTP_PORTS="$new_ports"
        save_config
        msg -verd " Puertos actualizados a: $BHTTP_PORTS"
        if is_active; then
            apply_service
            read -p "Presione ENTER para continuar..."
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
    read -p " Destino [Enter = 127.0.0.1:22]: " new_target
    [[ -z "$new_target" ]] && new_target="127.0.0.1:22"
    BHTTP_TARGET="$new_target"
    save_config
    msg -verd " Destino actualizado a: $BHTTP_TARGET"
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
    echo -e "   ${cor[5]}ESTADO Y REGISTROS DEL SERVICIO BHTTP"
    msg -bar3
    if is_active; then
        echo -e " Estado: ${cor[2]}[ACTIVO / ON]"
        echo -e " Escuchando en: ${cor[3]}${BHTTP_PORTS}"
        echo -e " Destino local: ${cor[3]}${BHTTP_TARGET}"
        echo -e " Modo: ${cor[3]}${BHTTP_MODE}"
        msg -bar3
        systemctl status bhttp.service --no-pager 2>/dev/null | head -n 15
    else
        echo -e " Estado: ${cor[1]}[DETENIDO / OFF]"
    fi
    msg -bar3
    read -p "Presione ENTER para continuar..."
}

uninstall_bhttp() {
    clear
    msg -bar3
    echo -e "   ${cor[1]}DESINSTALAR PROTOCOLO BHTTP"
    msg -bar3
    read -p " ¿Esta seguro de desinstalar BHTTP? [s/N]: " conf
    if [[ "$conf" = @(s|S|y|Y) ]]; then
        stop_bhttp
        rm -f "$SERVICE_FILE" "$BIN_SYS" "$BIN_DEST" 2>/dev/null
        rm -rf "$CONF_DIR" 2>/dev/null
        systemctl daemon-reload &>/dev/null
        msg -verd " Protocolo BHTTP desinstalado completamente."
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
    echo -e "       ${cor[5]}🌐 PROTOCOLO BHTTP SERVER (DTProto / BHP1) 🌐"
    msg -bar3
    echo -e " Estado: $status_txt   ${cor[1]}Puertos: ${cor[2]}${BHTTP_PORTS}   ${cor[1]}Modo: ${cor[2]}${BHTTP_MODE}"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}MODO BHTTP OFICIAL / DTPROTO (Puertos 80, 53, 8088)"
    echo -e " \033[0;35m[\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}MODO BHTTP XHTTP / TLS       (Puerto :${BHTTP_XHTTP_PORT} / SSL)"
    echo -e " \033[0;35m[\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}INICIAR / REINICIAR SERVICIO"
    echo -e " \033[0;35m[\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}DETENER SERVICIO"
    echo -e " \033[0;35m[\033[0;36m5\033[0;35m]\033[0;33m ${flech} ${cor[3]}PRUEBA REAL BHTTP PROBE (BHP1 Handshake)"
    echo -e " \033[0;35m[\033[0;36m6\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR PUERTOS DE ESCUCHA"
    echo -e " \033[0;35m[\033[0;36m7\033[0;35m]\033[0;33m ${flech} ${cor[3]}CAMBIAR DESTINO LOCAL (SSH 22)"
    echo -e " \033[0;35m[\033[0;36m8\033[0;35m]\033[0;33m ${flech} ${cor[3]}VER ESTADO / REGISTROS EN VIVO"
    echo -e " \033[0;35m[\033[0;36m9\033[0;35m]\033[0;33m ${flech} \033[0;31mDESINSTALAR PROTOCOLO BHTTP"
    msg -bar3
    echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
    msg -bar3

    selection=$(selection_fun 9)
    case "$selection" in
        1) modo_dtproto;;
        2) modo_xhttp;;
        3) start_bhttp;;
        4) stop_bhttp;;
        5) probe_bhttp;;
        6) change_ports;;
        7) change_target;;
        8) show_status;;
        9) uninstall_bhttp;;
        0) break;;
        *) msg -verm "Opcion invalida."; sleep 1;;
    esac
done
