#!/usr/bin/env bash
# ==========================================
# Gestor HCR Server - Melman / ChumoGH
# ==========================================
set -o pipefail

PATH="/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

SERVICE_NAME="hcr-server"
SYSTEMD_DIR="/etc/systemd/system"
UNIT_PATH="${SYSTEMD_DIR}/${SERVICE_NAME}.service"
BIN_PATH="/bin/HCR"
BIN_URL="https://raw.githubusercontent.com/ChumoGH/ADMcgh/refs/heads/main/Plugins/HCR"
CONFIG_DIR="/etc/hcr"
CONFIG_FILE="${CONFIG_DIR}/hcr.conf"
CERT_PATH="${CONFIG_DIR}/hcr.crt"
KEY_PATH="${CONFIG_DIR}/hcr.key"

# ==========================================
# Funciones Utilitarias
# ==========================================
require_root() {
    if [ "$(id -u)" -eq 0 ]; then return; fi
    echo -e "\033[0;31mError: Este script debe ejecutarse como root (sudo).\033[0m" >&2
    exit 1
}

manage_iptables() {
    local action=$1
    local port=$2
    while iptables -D INPUT -p tcp -m tcp --dport "$port" -j ACCEPT 2>/dev/null; do true; done
    if [[ "$action" == "add" ]]; then
        iptables -A INPUT -p tcp -m tcp --dport "$port" -j ACCEPT
    fi
}

load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        LISTEN_PORT="8880"
        TARGET_PORT="22"
        TRANSPORT_MODE="plain"
        MAX_DL_FRAME="16384"
        DL_POLL_TIMEOUT="5s"
        MAX_SESSIONS="32"
    fi
}

save_config() {
    mkdir -p "$CONFIG_DIR"
    cat <<EOF > "$CONFIG_FILE"
LISTEN_PORT="$LISTEN_PORT"
TARGET_PORT="$TARGET_PORT"
TRANSPORT_MODE="$TRANSPORT_MODE"
MAX_DL_FRAME="$MAX_DL_FRAME"
DL_POLL_TIMEOUT="$DL_POLL_TIMEOUT"
MAX_SESSIONS="$MAX_SESSIONS"
EOF
}

generate_cert() {
    if [[ ! -f "$CERT_PATH" || ! -f "$KEY_PATH" ]]; then
        echo -e "\033[0;33m Generando certificado TLS auto-firmado...\033[0m"
        if ! command -v openssl &> /dev/null; then
            echo -e "\033[0;36m Instalando OpenSSL...\033[0m"
            apt-get update -y > /dev/null 2>&1
            apt-get install openssl -y > /dev/null 2>&1
        fi
        openssl req -x509 -newkey rsa:2048 -nodes -keyout "$KEY_PATH" -out "$CERT_PATH" -days 3650 -subj "/CN=hcr-server" 2>/dev/null
        chmod 600 "$KEY_PATH"
        echo -e "\033[0;32m [OK] Certificados generados en $CONFIG_DIR\033[0m"
    else
        echo -e "\033[0;32m [OK] Certificados TLS ya existen.\033[0m"
    fi
}

render_service() {
    local tls_args=""
    if [[ "$TRANSPORT_MODE" == "tls" || "$TRANSPORT_MODE" == "auto" ]]; then
        tls_args=" --tls-cert ${CERT_PATH} --tls-key ${KEY_PATH}"
    fi

    cat <<EOF > "$UNIT_PATH"
[Unit]
Description=HCR relay
Wants=network-online.target
After=network-online.target ssh.service sshd.service
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
Type=exec
User=root
Group=root
WorkingDirectory=${CONFIG_DIR}
ExecStart=${BIN_PATH} --listen 0.0.0.0:${LISTEN_PORT} --target 127.0.0.1:${TARGET_PORT} --transport ${TRANSPORT_MODE}${tls_args} --max-sessions-per-ip 32 --max-connections 2048  --max-download-frame ${MAX_DL_FRAME} --download-poll-timeout ${DL_POLL_TIMEOUT} 
Restart=on-failure
RestartSec=5s
TimeoutStopSec=15s
KillSignal=SIGTERM
UMask=0077
NoNewPrivileges=true
PrivateTmp=true
PrivateDevices=true
ProtectSystem=strict
ProtectHome=read-only
ProtectControlGroups=true
RestrictAddressFamilies=AF_INET AF_INET6 AF_UNIX
RestrictNamespaces=true
MemoryDenyWriteExecute=false
ReadOnlyPaths=${CONFIG_DIR}
LimitNOFILE=4096
LimitCORE=0
TasksMax=512
MemoryMax=384M
StandardOutput=journal
StandardError=journal
SyslogIdentifier=hcr-server

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
}

apply_changes() {
    save_config
    if [[ "$TRANSPORT_MODE" == "tls" || "$TRANSPORT_MODE" == "auto" ]]; then
        generate_cert
    fi
    render_service
    systemctl restart "${SERVICE_NAME}"
    msg -bar3 2>/dev/null || echo "---------------------------------------"
    echo -e "\033[0;32m [OK] Servicio actualizado y reiniciado.\033[0m"
    sleep 2
}

# ==========================================
# Instalación y Desinstalación
# ==========================================
install_hcr() {
    clear 2>/dev/null || true
    msg -bar3 2>/dev/null || echo "---------------------------------------"
    echo -e "\033[0;36m      INSTALACIÓN DE HCR SERVER\033[0m"
    msg -bar3 2>/dev/null || echo "---------------------------------------"
    
    if [[ -f "$BIN_PATH" ]]; then
        rm -f "$BIN_PATH"
    fi

    echo -e "\033[0;33m Descargando binario de HCR...\033[0m"
    if [[ -f "/root/ChumoGH/bin/x86_64/HCR" ]]; then
        cp -f "/root/ChumoGH/bin/x86_64/HCR" "$BIN_PATH"
        chmod +x "$BIN_PATH"
    elif wget -q -O "$BIN_PATH" "https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/HCR" || wget -q -O "$BIN_PATH" "$BIN_URL"; then
        chmod +x "$BIN_PATH"
    else
        echo -e "\033[0;31m Error al descargar el binario.\033[0m"
        exit 1
    fi
    mkdir -p "$CONFIG_DIR"
    
    MAX_DL_FRAME="16384"
    DL_POLL_TIMEOUT="8s"
    MAX_SESSIONS="32"

    echo ""
    read -p "$(echo -e "\033[0;33m Puerto de inyección [Default 8880]: \033[0m")" input_port
    LISTEN_PORT=${input_port:-8880}

    read -p "$(echo -e "\033[0;33m Puerto de redireccionamiento [Default 22]: \033[0m")" input_target
    TARGET_PORT=${input_target:-22}

    echo -e "\033[0;33m Modo de transporte:\033[0m"
    echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m Plain (Recomendado)"
    echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m TLS (Generará certificados)"
    read -p "$(echo -e "\033[0;33m Seleccione opción [Default 1]: \033[0m")" t_opt
    case $t_opt in
        2) TRANSPORT_MODE="tls" ;;
        1|*) TRANSPORT_MODE="plain" ;;
    esac

    save_config

    if [[ "$TRANSPORT_MODE" == "tls" ]]; then
        echo ""
        generate_cert
    fi

    render_service
    manage_iptables "add" "$LISTEN_PORT"

    systemctl enable --now "${SERVICE_NAME}" >/dev/null 2>&1
    
    echo ""
    echo -e "\033[0;32m Instalación completada exitosamente.\033[0m"
    sleep 3
}

uninstall_hcr() {
    load_config
    systemctl stop "${SERVICE_NAME}" 2>/dev/null || true
    systemctl disable "${SERVICE_NAME}" 2>/dev/null || true
    rm -f "$UNIT_PATH"
    systemctl daemon-reload
    
    rm -f "$BIN_PATH"
    manage_iptables "remove" "${LISTEN_PORT:-8880}"
    rm -rf "$CONFIG_DIR"
    
    msg -bar3 2>/dev/null || echo "---------------------------------------"
    echo -e "\033[0;31m [!] HCR Server desinstalado por completo.\033[0m"
    sleep 2
}

# ==========================================
# Menú Principal
# ==========================================
show_menu() {
    while true; do
        load_config
        local estado="\033[0;31mDetenido\033[0m"
        if systemctl is-active --quiet "${SERVICE_NAME}" 2>/dev/null; then 
            estado="\033[0;32mActivo\033[0m"
        fi

        clear 2>/dev/null || true
        msg -bar3 2>/dev/null || echo "======================================================"
        echo -e "\033[0;35m         MENU HCR SERVER - Estado: $estado"
        msg -bar3 2>/dev/null || echo "======================================================"
        
        # Formato de 2 columnas estilo Matriz
        echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}Puerto Inyección \033[0;32m[${LISTEN_PORT}]\033[0;33m \033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}Puerto Destino \033[0;32m[${TARGET_PORT}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}Max DL Frame \033[0;32m[${MAX_DL_FRAME}]\033[0;33m     \033[0;35m [\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}Poll TimeOut \033[0;32m[${DL_POLL_TIMEOUT}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;33m ${flech} ${cor[3]}Modo: \033[0;32m[${TRANSPORT_MODE}]\033[0;33m          \033[0;35m [\033[0;36m6\033[0;35m]\033[0;33m ${flech} ${cor[3]}Iniciar/Detener \033[0m"
        echo -e "\033[0;35m [\033[0;36m7\033[0;35m]\033[0;33m ${flech} ${cor[3]}Desinstalar HCR          \033[0;35m [\033[0;36m8\033[0;35m]\033[0;33m ${flech} ${cor[3]}Ver Logs (Real-time)\033[0m"
        
        # Opción Salir
        echo -e "\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m" 2>/dev/null || echo "\033[1;41m[ REGRESAR ]\e[0m")"
        msg -bar3 2>/dev/null || echo "======================================================"
        
        read -p "$(echo -e "\033[0;33m Seleccione una opción: \033[0m")" opt

        case $opt in
            1)
                echo ""
                read -p "$(echo -e "\033[0;33m Ingrese nuevo puerto de inyección: \033[0m")" new_port
                if [[ -n "$new_port" ]]; then
                    manage_iptables "remove" "$LISTEN_PORT"
                    LISTEN_PORT="$new_port"
                    manage_iptables "add" "$LISTEN_PORT"
                    apply_changes
                fi
                ;;
            2)
                echo ""
                read -p "$(echo -e "\033[0;33m Ingrese nuevo puerto destino: \033[0m")" new_target
                if [[ -n "$new_target" ]]; then
                    TARGET_PORT="$new_target"
                    apply_changes
                fi
                ;;
            3)
                echo ""
                echo -e "\033[0;33m Ingrese Max DL Frame (ej. 16384, 32768, 65536): \033[0m"
                read -p " Valor: " new_frame
                if [[ -n "$new_frame" ]]; then
                    MAX_DL_FRAME="$new_frame"
                    apply_changes
                fi
                ;;
            4)
                echo ""
                echo -e "\033[0;33m Ingrese Poll TimeOut (ej. 5s, 8s, 10s): \033[0m"
                read -p " Valor: " new_timeout
                if [[ -n "$new_timeout" ]]; then
                    DL_POLL_TIMEOUT="$new_timeout"
                    apply_changes
                fi
                ;;
            5)
                echo ""
                echo -e "\033[0;33m Seleccione el modo de transporte:\033[0m"
                echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m Plain"
                echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m TLS"
                read -p "$(echo -e "\033[0;33m Opción: \033[0m")" m_opt
                case $m_opt in
                    2) TRANSPORT_MODE="tls" ;;
                    1|*) TRANSPORT_MODE="plain" ;;
                esac
                apply_changes
                ;;
            6)
                echo ""
                if systemctl is-active --quiet "${SERVICE_NAME}" 2>/dev/null; then
                    systemctl stop "${SERVICE_NAME}"
                    echo -e "\033[0;31m [!] Servicio detenido.\033[0m"
                else
                    systemctl start "${SERVICE_NAME}"
                    echo -e "\033[0;32m [OK] Servicio iniciado.\033[0m"
                fi
                sleep 2
                ;;
            7)
                echo ""
                read -p "$(echo -e "\033[0;31m ¿Está seguro de desinstalar HCR? (s/n): \033[0m")" confirm
                if [[ "$confirm" == "s" || "$confirm" == "S" ]]; then
                    uninstall_hcr
                    break
                fi
                ;;
            8)
                echo ""
                echo -e "\033[0;32m Visualizando logs del servicio HCR Server.\033[0m"
                echo -e "\033[0;31m Presiona [ Ctrl + C ] para regresar al menú.\033[0m"
                echo ""
                sleep 2
                journalctl -u "${SERVICE_NAME}" -n 20 -f || true
                ;;
            0)
                clear 2>/dev/null || true
                break
                ;;
            *)
                echo -e "\033[0;31m Opción inválida.\033[0m"
                sleep 1
                ;;
        esac
    done
}

# ==========================================
# Ejecución Principal
# ==========================================
require_root

if [[ ! -f "$BIN_PATH" || ! -f "$UNIT_PATH" ]]; then
    install_hcr
fi

show_menu
