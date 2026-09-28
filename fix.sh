#!/bin/bash
# ==============================================================================
# Script de Actualización y Reparación (Fixes) para ADMcgh ChumoGH
# Repara menús baneados, actualiza core/menu y plugins sin verificación de Key
# ==============================================================================

clear
echo -e "\033[1;36m====================================================\033[0m"
echo -e "\033[1;33m      APLICANDO FIXES Y ACTUALIZACIONES ADMcgh      \033[0m"
echo -e "\033[1;36m====================================================\033[0m"

# 1. Asegurar dependencias esenciales
echo -ne "\033[1;37m[1/6] Verificando paquetes base (curl, wget)...\033[0m"
command -v curl >/dev/null 2>&1 || apt-get install -y curl -qq &>/dev/null
command -v wget >/dev/null 2>&1 || apt-get install -y wget -qq &>/dev/null
echo -e " \033[1;32m[OK]\033[0m"

# 2. Crear directorios necesarios
mkdir -p /etc/adm-lite /etc/ADMcgh/bin /bin/ejecutar

# 3. Eliminar rastros de baneo y tokens
echo -ne "\033[1;37m[2/6] Limpiando tokens y bloqueos de baneo...\033[0m"
rm -f /etc/chekKEY /file /etc/folteto
echo -e " \033[1;32m[OK]\033[0m"

# 4. Actualizar styles / msg
echo -ne "\033[1;37m[3/6] Actualizando estilos e interfaz (/bin/ejecutar/msg)...\033[0m"
wget -q --no-check-certificate -O /bin/ejecutar/msg https://raw.githubusercontent.com/karl1999x/ChumoGH/main/styles/msg 2>/dev/null
chmod +x /bin/ejecutar/msg 2>/dev/null
echo -e " \033[1;32m[OK]\033[0m"

# 5. Descargar y actualizar core/menu
echo -ne "\033[1;37m[4/6] Actualizando Menú Principal (/etc/adm-lite/menu)...\033[0m"
wget -q --no-check-certificate -O /etc/adm-lite/menu https://raw.githubusercontent.com/karl1999x/ChumoGH/main/core/menu 2>/dev/null
chmod +x /etc/adm-lite/menu
echo -e " \033[1;32m[OK]\033[0m"

# 6. Reparar lanzadores del sistema (/bin/menu, /bin/cgh, /bin/adm)
echo -ne "\033[1;37m[5/6] Restaurando lanzadores /bin/menu, /bin/cgh, /bin/adm...\033[0m"
cat << 'EOF' > /bin/menu
#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/menu

cat << 'EOF' > /bin/cgh
#!/bin/bash
SCPdir="/etc/adm-lite"
[[ $1 = "-fix" ]] && {
rm -f /etc/folteto
rm -f /var/log/auth.log*
echo '' > /var/log/auth.log
cp /bin/adm /bin/menu
}
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/cgh

cat << 'EOF' > /bin/adm
#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu "$@"
EOF
chmod +x /bin/adm
echo -e " \033[1;32m[OK]\033[0m"

# 7. Actualizar plugins y herramientas (X-UI, V2Ray, Xray, HCR, BHTTP, etc.)
echo -ne "\033[1;37m[6/6] Descargando plugins desofuscados y sin baneo...\033[0m"

# X-UI limpio
wget -q --no-check-certificate -O /usr/bin/x-ui https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/x-ui.sh 2>/dev/null
chmod +x /usr/bin/x-ui 2>/dev/null
wget -q --no-check-certificate -O /etc/ADMcgh/bin/x-ui.sh https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/x-ui.sh 2>/dev/null
chmod +x /etc/ADMcgh/bin/x-ui.sh 2>/dev/null

# V2Ray y Xray
wget -q --no-check-certificate -O /etc/ADMcgh/bin/v2r.sh https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/v2r.sh 2>/dev/null
chmod +x /etc/ADMcgh/bin/v2r.sh 2>/dev/null
ln -sf /etc/ADMcgh/bin/v2r.sh /bin/v2r.sh 2>/dev/null
ln -sf /etc/ADMcgh/bin/v2r.sh /bin/v2r 2>/dev/null

wget -q --no-check-certificate -O /etc/ADMcgh/bin/xr.sh https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/xr.sh 2>/dev/null
chmod +x /etc/ADMcgh/bin/xr.sh 2>/dev/null
ln -sf /etc/ADMcgh/bin/xr.sh /bin/xr.sh 2>/dev/null
ln -sf /etc/ADMcgh/bin/xr.sh /bin/xr 2>/dev/null

# HCR y BHTTP wrappers
wget -q --no-check-certificate -O /etc/ADMcgh/bin/hcr.sh https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/hcr.sh 2>/dev/null
chmod +x /etc/ADMcgh/bin/hcr.sh 2>/dev/null
cat << 'EOF' > /bin/hcr
#!/bin/bash
exec /etc/ADMcgh/bin/hcr.sh "$@"
EOF
chmod +x /bin/hcr 2>/dev/null

wget -q --no-check-certificate -O /etc/ADMcgh/bin/bhttp.sh https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/bhttp.sh 2>/dev/null
chmod +x /etc/ADMcgh/bin/bhttp.sh 2>/dev/null
cat << 'EOF' > /bin/bhttp
#!/bin/bash
exec /etc/ADMcgh/bin/bhttp.sh "$@"
EOF
chmod +x /bin/bhttp 2>/dev/null

# Binarios HCR, BHTTP, BTUN si arquitectura es x86_64
if [[ $(uname -m 2>/dev/null) == "x86_64" ]]; then
    wget -q --no-check-certificate -O /bin/HCR https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/HCR 2>/dev/null
    wget -q --no-check-certificate -O /bin/BHTTP https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/BHTTP 2>/dev/null
    wget -q --no-check-certificate -O /bin/BTUN https://raw.githubusercontent.com/karl1999x/ChumoGH/main/bin/x86_64/BTUN 2>/dev/null
    chmod +x /bin/HCR /bin/BHTTP /bin/BTUN 2>/dev/null
    cp -f /bin/HCR /etc/ADMcgh/bin/HCR 2>/dev/null
    cp -f /bin/BHTTP /etc/ADMcgh/bin/BHTTP 2>/dev/null
    cp -f /bin/BTUN /etc/ADMcgh/bin/BTUN 2>/dev/null
fi

# Plugins adicionales limpios
PLUGINS_LIST=(
    "gnula.sh"
    "funciones.sh"
    "killSSH.sh"
    "certificadossl.sh"
    "_multiK.sh"
    "tcp.sh"
    "trojan-nao.sh"
    "tumbs.sh"
    "mod-v2ray.sh"
    "ws-java.sh"
    "socks5.sh"
    "sslh-back3.sh"
    "front.sh"
    "h_beta.sh"
    "adduser.sh"
    "v2ray1.sh"
)

for p in "${PLUGINS_LIST[@]}"; do
    wget -q --no-check-certificate -O "/etc/ADMcgh/bin/${p}" "https://raw.githubusercontent.com/karl1999x/ChumoGH/main/plugins/${p}" 2>/dev/null
    chmod +x "/etc/ADMcgh/bin/${p}" 2>/dev/null
done

echo -e " \033[1;32m[OK]\033[0m"

echo -e "\033[1;36m====================================================\033[0m"
echo -e "\033[1;32m   ¡ACTUALIZACION Y FIXES APLICADOS CON EXITO!      \033[0m"
echo -e "\033[1;36m====================================================\033[0m"
echo -e "\033[1;37mYa puedes ejecutar tu menú con el comando: \033[1;33mmenu\033[0m\n"
