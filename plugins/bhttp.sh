#!/usr/bin/env bash
# ==========================================
# Gestor BHTTP / BTUN - Melman / ChumoGH
# ==========================================
set -o pipefail

PATH="/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

DEST="/etc/ADMcgh/bin"
CONF_DIR="/etc/ADMcgh/conf"
mkdir -p "$DEST" "$CONF_DIR"

BTUN_CONF="${CONF_DIR}/btun.conf"
BHTTP_CONF="${CONF_DIR}/bhttp.conf"

# Variables visuales (Fallbacks por si se ejecuta fuera de la matriz)
[[ -z "$flech" ]] && flech=">"
[[ -z "${cor[3]}" ]] && cor[3]="\033[0;33m"

if ! type msg >/dev/null 2>&1; then
    msg() {
        case $1 in
            -bar3) echo -e "\033[0;36m======================================================\033[0m" ;;
            -verd) echo -e "\033[0;32m$2\033[0m" ;;
            -verm) echo -e "\033[0;31m$2\033[0m" ;;
            -ama)  echo -e "\033[0;33m$2\033[0m" ;;
            -bra)  echo -e "\033[1;37m$2\033[0m" ;;
        esac
    }
fi

require_root() {
    if [ "$(id -u)" -eq 0 ]; then return; fi
    msg -verm "Error: Este script debe ejecutarse como root (sudo)."
    exit 1
}

manage_iptables() {
    local action=$1
    local port=$2
    while iptables -D INPUT -p tcp -m tcp --dport "$port" -j ACCEPT 2>/dev/null; do true; done
    while iptables -D INPUT -p udp -m udp --dport "$port" -j ACCEPT 2>/dev/null; do true; done
    if [[ "$action" == "add" ]]; then
        iptables -A INPUT -p tcp -m tcp --dport "$port" -j ACCEPT
        iptables -A INPUT -p udp -m udp --dport "$port" -j ACCEPT
    fi
}

# ==========================================
# Módulo: BTUN
# ==========================================
load_btun_conf() {
    if [[ -f "$BTUN_CONF" ]]; then
        source "$BTUN_CONF"
    else
        BTUN_TCP="7300"
        BTUN_UDP="7300"
    fi
}

save_btun_conf() {
    cat <<EOF > "$BTUN_CONF"
BTUN_TCP="$BTUN_TCP"
BTUN_UDP="$BTUN_UDP"
EOF
}

render_btun_service() {
    cat <<EOF > "/etc/systemd/system/btun.service"
[Unit]
Description=BTUN Service
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=${DEST}
ExecStart=/bin/BTUN -tcp-listen 0.0.0.0:${BTUN_TCP} -udp-listen 0.0.0.0:${BTUN_UDP}
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
}

install_btun() {
    clear 2>/dev/null || true
    msg -bar3
    echo -e "\033[0;36m      INSTALACIÓN DE BTUN\033[0m"
    msg -bar3
    echo -e "\033[0;33m Verificando binario BTUN...\033[0m"
    
    if [[ -f "/bin/BTUN" && -x "/bin/BTUN" ]]; then
        cp -f /bin/BTUN ${DEST}/BTUN 2>/dev/null || true
        msg -verd "[OK] Binario instalado"
    elif [[ -f "/root/ChumoGH/bin/x86_64/BTUN" ]]; then
        cp -f "/root/ChumoGH/bin/x86_64/BTUN" ${DEST}/BTUN
        cp -f "/root/ChumoGH/bin/x86_64/BTUN" /bin/BTUN
        chmod +x ${DEST}/BTUN /bin/BTUN
        msg -verd "[OK] Binario instalado"
    elif wget --no-check-certificate -t3 -T3 -O ${DEST}/BTUN https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/BTUN 2>/dev/null || wget --no-check-certificate -t3 -T3 -O ${DEST}/BTUN https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/BTUN &>/dev/null ; then
        chmod +x ${DEST}/BTUN
        [[ -e /bin/BTUN ]] && rm -f /bin/BTUN
        ln -s ${DEST}/BTUN /bin/BTUN
        msg -verd "[OK] Binario instalado"
    else    
        msg -verm "[Fail]"    
        msg -bar3    
        msg -ama "No se pudo descargar el binario BTUN"    
        read -p "ENTER PARA CONTINUAR"
        return
    fi
    
    echo ""
    read -p "$(echo -e "\033[0;33m Puerto TCP [Default 7300]: \033[0m")" in_tcp
    BTUN_TCP=${in_tcp:-7300}
    
    read -p "$(echo -e "\033[0;33m Puerto UDP [Default 7300]: \033[0m")" in_udp
    BTUN_UDP=${in_udp:-7300}

    save_btun_conf
    render_btun_service
    manage_iptables "add" "$BTUN_TCP"
    [[ "$BTUN_TCP" != "$BTUN_UDP" ]] && manage_iptables "add" "$BTUN_UDP"

    systemctl enable --now btun >/dev/null 2>&1
    msg -verd " Instalación de BTUN completada."
    sleep 2
}

menu_btun() {
    while true; do
        load_btun_conf
        if [[ ! -f "/bin/BTUN" || ! -f "/etc/systemd/system/btun.service" ]]; then
            install_btun
            break
        fi

        local est_btun="\033[0;31mDetenido\033[0m"
        systemctl is-active --quiet btun 2>/dev/null && est_btun="\033[0;32mActivo\033[0m"

        clear 2>/dev/null || true
        msg -bar3
        echo -e "\033[0;35m       [ CONFIGURACIÓN BTUN ] - Estado: $est_btun"
        msg -bar3
        echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}Cambiar Puerto TCP \033[0;32m[${BTUN_TCP}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}Cambiar Puerto UDP \033[0;32m[${BTUN_UDP}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}Reiniciar Servicio\033[0m"
        echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}Iniciar/Detener\033[0m"
        echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m ${flech} ${cor[3]}Desinstalar BTUN\033[0m"
        echo -e "\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
        msg -bar3
        read -p "$(echo -e "\033[0;33m Opcion: \033[0m")" opt

        case $opt in
            1)
                read -p "$(echo -e "\033[0;33m Nuevo TCP: \033[0m")" n_tcp
                if [[ -n "$n_tcp" ]]; then
                    manage_iptables "remove" "$BTUN_TCP"
                    BTUN_TCP="$n_tcp"
                    manage_iptables "add" "$BTUN_TCP"
                    save_btun_conf && render_btun_service && systemctl restart btun
                fi
                ;;
            2)
                read -p "$(echo -e "\033[0;33m Nuevo UDP: \033[0m")" n_udp
                if [[ -n "$n_udp" ]]; then
                    manage_iptables "remove" "$BTUN_UDP"
                    BTUN_UDP="$n_udp"
                    manage_iptables "add" "$BTUN_UDP"
                    save_btun_conf && render_btun_service && systemctl restart btun
                fi
                ;;
            3)
                systemctl restart btun && msg -verd "[OK] Reiniciado." && sleep 1
                ;;
            4)
                if systemctl is-active --quiet btun 2>/dev/null; then systemctl stop btun; else systemctl start btun; fi
                ;;
            5)
                systemctl stop btun 2>/dev/null || true
                systemctl disable btun 2>/dev/null || true
                rm -f /etc/systemd/system/btun.service /bin/BTUN ${DEST}/BTUN "$BTUN_CONF"
                systemctl daemon-reload
                manage_iptables "remove" "$BTUN_TCP"
                manage_iptables "remove" "$BTUN_UDP"
                msg -verm "BTUN Desinstalado" && sleep 2 && break
                ;;
            0) break ;;
        esac
    done
}

# ==========================================
# Módulo: BHTTP (Bilola)
# ==========================================
load_bhttp_conf() {
    if [[ -f "$BHTTP_CONF" ]]; then
        source "$BHTTP_CONF"
    else
        BHTTP_PORT="80"
        BHTTP_SSH="22"
    fi
}

save_bhttp_conf() {
    cat <<EOF > "$BHTTP_CONF"
BHTTP_PORT="$BHTTP_PORT"
BHTTP_SSH="$BHTTP_SSH"
EOF
}

render_bhttp_service() {
    cat <<EOF > "/etc/systemd/system/bhttp.service"
[Unit]
Description=BHTTP Bilola Service
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=${DEST}
ExecStart=/bin/BHTTP -listen 0.0.0.0:${BHTTP_PORT} -target 127.0.0.1:${BHTTP_SSH}
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
}

install_bhttp() {
    clear 2>/dev/null || true
    msg -bar3
    echo -e "\033[0;36m      INSTALACIÓN DE BHTTP\033[0m"
    msg -bar3
    echo -e "\033[0;33m Verificando binario BHTTP...\033[0m"
    
    if [[ -f "/bin/BHTTP" && -x "/bin/BHTTP" ]]; then
        cp -f /bin/BHTTP ${DEST}/BHTTP 2>/dev/null || true
        msg -verd "[OK] Binario instalado"
    elif [[ -f "/root/ChumoGH/bin/x86_64/BHTTP" ]]; then
        cp -f "/root/ChumoGH/bin/x86_64/BHTTP" ${DEST}/BHTTP
        cp -f "/root/ChumoGH/bin/x86_64/BHTTP" /bin/BHTTP
        chmod +x ${DEST}/BHTTP /bin/BHTTP
        msg -verd "[OK] Binario instalado"
    elif wget --no-check-certificate -t3 -T3 -O ${DEST}/BHTTP https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/BHTTP 2>/dev/null || wget --no-check-certificate -t3 -T3 -O ${DEST}/BHTTP https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/BHTTP &>/dev/null ; then
        chmod +x ${DEST}/BHTTP
        [[ -e /bin/BHTTP ]] && rm -f /bin/BHTTP
        ln -s ${DEST}/BHTTP /bin/BHTTP
        msg -verd "[OK] Binario instalado"
    else    
        msg -verm "[Fail]"    
        msg -bar3    
        msg -ama "No se pudo descargar el binario BHTTP"    
        read -p "ENTER PARA CONTINUAR"
        return
    fi
    
    echo ""
    read -p "$(echo -e "\033[0;33m Puerto de escucha (--port) [Default 80]: \033[0m")" in_port
    BHTTP_PORT=${in_port:-80}
    
    read -p "$(echo -e "\033[0;33m Puerto SSH local (--ssh) [Default 22]: \033[0m")" in_ssh
    BHTTP_SSH=${in_ssh:-22}

    save_bhttp_conf
    render_bhttp_service
    manage_iptables "add" "$BHTTP_PORT"

    systemctl enable --now bhttp >/dev/null 2>&1
    msg -verd " Instalación de BHTTP completada."
    sleep 2
}

menu_bhttp() {
    while true; do
        load_bhttp_conf
        if [[ ! -f "/bin/BHTTP" || ! -f "/etc/systemd/system/bhttp.service" ]]; then
            install_bhttp
            break
        fi

        local est_bhttp="\033[0;31mDetenido\033[0m"
        systemctl is-active --quiet bhttp 2>/dev/null && est_bhttp="\033[0;32mActivo\033[0m"

        clear 2>/dev/null || true
        msg -bar3
        echo -e "\033[0;35m      [ CONFIGURACIÓN BHTTP ] - Estado: $est_bhttp"
        msg -bar3
        echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}Cambiar Puerto Escucha \033[0;32m[${BHTTP_PORT}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}Cambiar Puerto SSH Dest \033[0;32m[${BHTTP_SSH}]\033[0m"
        echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}Reiniciar Servicio\033[0m"
        echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;33m ${flech} ${cor[3]}Iniciar/Detener\033[0m"
        echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m ${flech} ${cor[3]}Desinstalar BHTTP\033[0m"
        echo -e "\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
        msg -bar3
        read -p "$(echo -e "\033[0;33m Opcion: \033[0m")" opt

        case $opt in
            1)
                read -p "$(echo -e "\033[0;33m Nuevo Listen Port: \033[0m")" n_port
                if [[ -n "$n_port" ]]; then
                    manage_iptables "remove" "$BHTTP_PORT"
                    BHTTP_PORT="$n_port"
                    manage_iptables "add" "$BHTTP_PORT"
                    save_bhttp_conf && render_bhttp_service && systemctl restart bhttp
                fi
                ;;
            2)
                read -p "$(echo -e "\033[0;33m Nuevo Target SSH: \033[0m")" n_ssh
                if [[ -n "$n_ssh" ]]; then
                    BHTTP_SSH="$n_ssh"
                    save_bhttp_conf && render_bhttp_service && systemctl restart bhttp
                fi
                ;;
            3)
                systemctl restart bhttp && msg -verd "[OK] Reiniciado." && sleep 1
                ;;
            4)
                if systemctl is-active --quiet bhttp 2>/dev/null; then systemctl stop bhttp; else systemctl start bhttp; fi
                ;;
            5)
                systemctl stop bhttp 2>/dev/null || true
                systemctl disable bhttp 2>/dev/null || true
                rm -f /etc/systemd/system/bhttp.service /bin/BHTTP ${DEST}/BHTTP "$BHTTP_CONF"
                systemctl daemon-reload
                manage_iptables "remove" "$BHTTP_PORT"
                msg -verm "BHTTP Desinstalado" && sleep 2 && break
                ;;
            0) break ;;
        esac
    done
}

# ==========================================
# Menú Principal (Hub de Entrada)
# ==========================================
main_menu() {
    require_root
    while true; do
        local st_btun="\033[0;31m[OFF]\033[0m"
        [[ -f "/bin/BTUN" ]] && systemctl is-active --quiet btun 2>/dev/null && st_btun="\033[0;32m[ON]\033[0m"
        
        local st_bhttp="\033[0;31m[OFF]\033[0m"
        [[ -f "/bin/BHTTP" ]] && systemctl is-active --quiet bhttp 2>/dev/null && st_bhttp="\033[0;32m[ON]\033[0m"

        clear 2>/dev/null || true
        msg -bar3
        echo -e "\033[0;36m      GESTOR DE PROTOCOLOS ADMcgh\033[0m"
        msg -bar3
        echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m ${flech} ${cor[3]}Gestionar BTUN       $st_btun"
        echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m ${flech} ${cor[3]}Gestionar BHTTP      $st_bhttp"
        echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m ${flech} ${cor[3]}Opción 3 (Reservada) \033[0;37m[PRONTO]\033[0m"
        echo -e "\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ SALIR ]\e[0m")"
        msg -bar3
        
        read -p "$(echo -e "\033[0;33m Seleccione una opción: \033[0m")" m_opt

        case $m_opt in
            1) menu_btun ;;
            2) menu_bhttp ;;
            3) msg -ama "Opción 3 reservada para futuras herramientas." ; sleep 2 ;;
            0) clear 2>/dev/null || true; exit 0 ;;
            *) echo -e "\033[0;31m Opción inválida.\033[0m" ; sleep 1 ;;
        esac
    done
}

main_menu
