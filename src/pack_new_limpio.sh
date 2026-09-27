#!/bin/bash
# Desofuscado Estáticamente por deobf_type2_vars.py
[[ -z ${IiP} ]] && IiP=$(cat < /usr/bin/vendor_code)
rm -rf /tmp/* &>/dev/null
BS=$(basename "$0") &>/dev/null
rm -f $(pwd)/${BS} &>/dev/null
[[ -e /file ]] && _double=$(cat < /file) ||  {
_double=$(wget -q -T 5 -O "https://plus.ltmcgh.site/main/control")
echo -e "$(echo -e "$_double" | grep ${IiP})" > /file
}
SCPdir="/etc/adm-lite"
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ -e /bin/ejecutar/IPcgh ]] && _IP=$(cat < /bin/ejecutar/IPcgh) || _IP=$(curl -fsSL ifconfig.me)
_msg() { echo -e "${CYAN}[INFO]${NC} $*"; }
_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
_err() { echo -e "${RED}[ERROR]${NC} $*"; }
_ok() { echo -e "${GREEN}[OK]${NC} $*"; }
front_file_local='/bin/ejecutar/msg'
source ${front_file_local}
command_exists() { command -v "$1" >/dev/null 2>&1; }
fun_add_name_dom(){
rm -f /bin/ejecutar/.admcgh_welcomed
clear&&clear
msg -bar3
read -t 20 -p " Nombre del servidor (máx 10 caracteres, ENTER para omitir): " -e -i "" _nameS
if [[ -n "$_nameS" ]]; then
_nameS="${_nameS:0:10}"
echo "$_nameS" > /etc/adm-lite/name
echo "$_nameS" > /root/name
chmod 644 /etc/adm-lite/name
command -v figlet >/dev/null && figlet "$_nameS"
else
echo " ${aLerT} Sin nombre asignado"
fi
sleep 2s
clear&&clear
msg -bar3
print_center -ama " AGREGA UN DOMINIO A TU SERVIDOR \n( OPCIONAL ) "
msg -bar3
echo -e " ${ceLL} Dominio (ENTER para usar IP) "
echo -ne "\033[1;97m Domain \033[0m" && read -t 20 -p ":" -e -i "${IP}" _domV
echo "${_domV}" > /dominio.txt
chmod 644 /dominio.txt
[[ -n "$_domV" ]] && echo " ${CHeko} Dominio $_domV registrado" || echo " ${CHeko} Usando IP $_IP como dominio"
msg -bar3
echo -e "\033[1;32mConfiguración completada!\033[0m"
msg -bar3
sleep 2s
clear&&clear
}
setup_cron() {
if command_exists systemctl; then
systemctl enable --now cron 2>/dev/null || systemctl enable --now crond 2>/dev/null
elif command_exists service; then
service cron restart 2>/dev/null || service crond restart 2>/dev/null
else
_warn "CRON NO WORKING "
tput cuu1 && tput dl1
fi
_ok " CRON INIT "
tput cuu1 && tput dl1
}
install_fim () {
local fecha=`date +"%d-%m-%Y"`;
unset name
[[ -d /bin/ejecutar ]] && rm -rf /bin/ejecutar
mkdir /bin/ejecutar
[[ -e /bin/ejecutar/menu_credito ]] && echo "" || echo "$(cat /etc/adm-lite/menu_credito|head -1)" > /bin/ejecutar/menu_credito && chmod +x /bin/ejecutar/menu_credito
wget -q --no-cache --no-check-certificate --max-redirect=20 -O /etc/ADMcgh/bin/SBdm https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/toolmaster.py
chmod +x /etc/ADMcgh/bin/SBdm
[[ -e /bin/toolmaster ]] && rm -f /bin/toolmaster
ln -s /etc/ADMcgh/bin/SBdm /bin/toolmaster &>/dev/null
cat <<EOF > /etc/ADMcgh/bin/upLIC
{
ip -s -s neigh flush all &> /dev/null
IFACE=$(ip route | grep default | awk '{print $5}' | head -1)
ip neigh flush dev "$IFACE" &> /dev/null
systemctl restart systemd-resolved.service &> /dev/null
echo 3 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null
swapoff -a && swapon -a 1>/dev/null 2>/dev/null
wget -q --no-check-certificate -t2 -T2 -O /bin/ejecutar/v-new.log \
https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/version/v-new.log &
killall kswapd0 > /dev/null 2>&1
if systemctl list-unit-files | grep -q "NetworkManager"; then
systemctl restart NetworkManager &>/dev/null
elif systemctl list-unit-files | grep -q "systemd-networkd"; then
systemctl restart systemd-networkd &>/dev/null
elif systemctl list-unit-files | grep -q "network-online.target"; then
systemctl restart network-online.target &>/dev/null
elif systemctl list-unit-files | grep -q "networking.service"; then
systemctl restart networking.service &>/dev/null
elif systemctl list-unit-files | grep -q "network.service"; then
systemctl restart network &>/dev/null
fi
} &
EOF
chmod +x /etc/ADMcgh/bin/upLIC
[[ -e /bin/upLIC ]] && rm -f /bin/upLIC
ln -s /etc/ADMcgh/bin/upLIC /bin/upLIC &>/dev/null
crontab -l > /root/cron &> /dev/null
echo "@reboot /bin/autoboot" >> /root/cron.tmp
awk '!a[$0]++' /root/cron.tmp > /root/cron
crontab /root/cron &>/dev/null
rm -f /root/cron
echo "* * * * * root bash  /bin/autoboot" >> /etc/crontab
awk '!a[$0]++' /etc/crontab > /etc/crontab.temp
mv /etc/crontab.temp /etc/crontab
setup_cron
if cat /etc/bash.bashrc | grep ADMcgh; then
sed -i "/ADMcgh/d" /etc/bash.bashrc
echo '
if ! [ $(id -u) = 0 ]; then
figlet -f slant "ChumoGH" | lolcat
echo ""
echo -e " USUARIO NO ROOT"
echo -e " COLOCA \033[1;43msudo -i\033[0m PARA SER ROOT"
echo ""
[[ -e /usr/lib/update-notifier/update-motd-reboot-required ]] && /usr/lib/update-notifier/update-motd-reboot-required
else
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
upLIC &> /dev/null
[[ -z $(locale | grep "LANG=" | cut -d "=" -f2) ]] && export LANG=en_US.UTF-8
DATE=$(date +"%d-%m-%Y")
TIME=$(date +"%T")
figlet -f slant "ChumoGH" | lolcat
echo ""
killall menu &> /dev/null
/bin/autoboot &> /dev/null
if [[ -s /etc/adm-lite/v-local.log ]]; then
v1=$(< /etc/adm-lite/v-local.log)
else
v1="null"
fi
if [[ -s /bin/ejecutar/v-new.log ]]; then
v2=$(< /bin/ejecutar/v-new.log)
else
v2="$v1"
fi
echo -e " SERVIDOR INSTALADO EL : '${fecha}'"
echo -e " FECHA/HORA ACTUAL : $DATE - $TIME"
echo -e " NOMBRE DEL SERVIDOR : $HOSTNAME"
echo -e " TIEMPO EN LINEA : $(uptime -p)"
[[ ${v1} = ${v2} ]] && echo -e " VERSION ACTUAL INSTALADA ES ${v1}" || echo -e " NUEVA VERSION ${v2} DISPONIBLE!"
echo -e " MEMORIA RAM LIBRE : $(free -h | grep Mem | sed "s/\s\+/,/g" | cut -d , -f4)"
echo -e ""
echo -e "\tRESELLER: \e[1;31m$(cat /etc/adm-lite/menu_credito|head -1)"
echo -e "\033[1;39m"
echo -e " BIENVENIDO DE NUEVO!"
echo -e "\033[1;43m Teclee cgh , menu o adm para ver el MENU\033[0m."
echo -e ""
[[ -e /usr/lib/update-notifier/update-motd-reboot-required ]] && /usr/lib/update-notifier/update-motd-reboot-required
fi
' > /etc/ADMcgh/bashrc
echo "STARTUP AGREGADO EXITOSAMENTE"
echo -e 'source /etc/ADMcgh/bashrc' >> /etc/bash.bashrc
else
sed -i "/ADMcgh/d" /etc/bash.bashrc
echo 'if ! [ $(id -u) = 0 ]; then
figlet -f slant "ChumoGH" | lolcat
echo ""
echo -e " USUARIO NO ROOT"
echo -e " COLOCA \033[1;43msudo -i\033[0m PARA SER ROOT"
echo ""
[[ -e /usr/lib/update-notifier/update-motd-reboot-required ]] && /usr/lib/update-notifier/update-motd-reboot-required
else
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
upLIC &>/dev/null
[[ -z $(locale | grep "LANG=" | cut -d "=" -f2) ]] && export LANG=en_US.UTF-8
DATE=$(date +"%d-%m-%Y")
TIME=$(date +"%T")
figlet -f slant "ChumoGH" | lolcat
echo ""
killall menu &> /dev/null
/bin/autoboot &> /dev/null
if [[ -s /etc/adm-lite/v-local.log ]]; then
v1=$(< /etc/adm-lite/v-local.log)
else
v1="null"
fi
if [[ -s /bin/ejecutar/v-new.log ]]; then
v2=$(< /bin/ejecutar/v-new.log)
else
v2="$v1"
fi
echo -e " SERVIDOR INSTALADO EL : '${fecha}'"
echo -e " FECHA/HORA ACTUAL : $DATE - $TIME"
echo -e " NOMBRE DEL SERVIDOR : $HOSTNAME"
echo -e " TIEMPO EN LINEA : $(uptime -p)"
[[ ${v1} = ${v2} ]] && echo -e " VERSION ACTUAL INSTALADA ES ${v1}" || echo -e " NUEVA VERSION ${v2} DISPONIBLE!"
echo -e " MEMORIA RAM LIBRE : $(free -h | grep Mem | sed "s/\s\+/,/g" | cut -d , -f4)"
echo -e ""
echo -e "\tRESELLER: \e[1;31m$(cat /etc/adm-lite/menu_credito|head -1)"
echo -e "\033[1;39m"
echo -e " BIENVENIDO DE NUEVO!"
echo -e "\033[1;43m Teclee cgh , menu o adm para ver el MENU\033[0m."
echo -e ""
[[ -e /usr/lib/update-notifier/update-motd-reboot-required ]] && /usr/lib/update-notifier/update-motd-reboot-required
fi
' > /etc/ADMcgh/bashrc
print_center -verm " STARTUP AGREGADO EXITOSAMENTE"
echo -e 'source /etc/ADMcgh/bashrc' >> /etc/bash.bashrc
fi
[[ -e $HOME/lista ]] && rm $HOME/lista
echo -e "0" > /bin/ejecutar/uskill
[[ -e /bin/ejecutar/menu_credito ]] && echo "" || echo "$(cat /etc/adm-lite/menu_credito|head -1)" > /bin/ejecutar/menu_credito && chmod +x /bin/ejecutar/menu_credito
echo "Verified${TtfIn} $(cat /bin/ejecutar/menu_credito)" > /bin/ejecutar/exito
print_center -verd "CREDITOS AGREGADOS EXITOSAMENTE"
fun_add_name_dom
msg -bar3
echo -e "\033[1;32mCHANGE ZONA TIME ( * \033[1;33mMenu 5 \033[1;32m*\033[1;33m opcion 30, opcion 11 \033[1;32m)"
msg -bar3
print_center -verd " ${cor[3]} ADMcgh Configurado Exitosamente!"
print_center -verd  " RECOMENDABLE ACCEDER COMO ROOT y/o ADMINISTRADOR\033[0m"
msg -bar3
print_center -ama "${cor[3]} |${rAy}| ${cor[2]} YA PUEDES ACCEDER AL PANNEL DEL SCRIPT"
msg -bar3
echo -e "      \033[1;41m Use los Comandos: cgh, menu, adm"
msg -bar3
print_center -verd  "${cor[2]} Para acceder al MENU, DISFRUTA LA ESTANCIA!"
msg -bar3
print_center -verd  "${cor[1]}       YA TIENES ACCESO ROOT A TU VPS?\n ESTO ES ESPECIAL PARA [AWS,GOOGLE,AZURE,ORACLE,ETC]\n SI ENTRASTE CON UN USUARIO DIFERENTE AL ROOT\n PRESIONA S, CASO CONTRARIO, IGNORA EL MENSAJE"
msg -bar3
echo -e "\033[1;42m APLICAR FIX de PASSWD para LIBERAR ACCESO "
echo -e "SI YA ERES ROOT, SE CAMBIARA TU CLAVE \033[0;33m "
echo -ne "\033[0;32m"
read -p " Responde [ s | n ] : " -e -i "n" x
echo ''
[[ "${x}" = @(s|S|y|Y) ]] && source <(wget -qO- --no-cache --no-check-certificate --max-redirect=20 https://www.dropbox.com/s/hl9vyo8mf94z0h5/root-pass.sh) || echo -e "\033[1;32mAplica FIX en ( * \033[1;33m Menu 5\033[1;32m *\033[1;33m opcion 30, opcion 9 \033[1;32m*\033[1;32m)"
[[ -e /root/name ]] && figlet "$(less /root/name)" | lolcat || tittle
return
}
spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
install_iniNEW () {
local ED=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
local EF=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
_error=0
msg -bar3
declare -A cpu_model=$(uname -m)
[[ $cpu_model = "aarch64" ]] && cpu_model=" ARM64 Pro"
echo -e "\033[97m"
print_center -azu  "     -- \033[41mINSTALAREMOS LO NECESARIO PARA EL ADM\033[0m --"
print_center "     \033[44mSU IP REGISTRADA ES : ${_IP}\033[41m"
print_center "   -- \033[41m Arch : \033[1;33m$(lscpu | grep "Vendor ID" | awk '{print $3}'|head -1) SISTEMA  $(lsb_release -si) $(lsb_release -sr)\033[0m --"
print_center "\033[100mATENCION A INSTALACION POR SI DEVUELVE UN ERROR \033[0m"
print_center "\033[97m\n$(msg -bar3)\033[0m"
print_center "\033[100mERRORES GRAFICOS FIXEADOS AL FINALIZAR  \033[0m"
print_center "\033[97m\n$(msg -bar3)\033[0m"locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1 && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] && apt-get purge ufw -y &>/dev/null
paquetes=(bsdmainutils sudo cron userMOD screen nginx nload htop python python3 python3-pip nodejs npm lsof psmisc socat bc netcat net-tools cowsay nmap jq iptables)
install_pack "${paquetes[@]}"
iptables -F &>/dev/null
iptables -t nat -F &>/dev/null
iptables -t mangle -F &>/dev/null
iptables -X &>/dev/null
iptables -P INPUT ACCEPT &>/dev/null
iptables -P FORWARD ACCEPT &>/dev/null
iptables -P OUTPUT ACCEPT &>/dev/null
[[ $(dpkg --get-selections|grep -w "nginx"|head -1) ]] && {
echo '
server {
listen 81 default_server;
listen [::]:81 default_server;
root /var/www/html;
index index.html index.htm index.php;
server_name _;
location / {
try_files $uri $uri/ =404;
}
}
' > /etc/nginx/sites-available/default
rm -rf /usr/share/nginx/html
sudo ln -s /var/www/html /usr/share/nginx/html
service nginx restart &>/dev/null
}
rm -rf $HOME/install
msg -bar3
echo -e " ${FlT} GRACIAS POR SU AMABLE ESPERA !! ${FlT}"
msg -bar3
}
install_pack(){
spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
export DEBIAN_FRONTEND=noninteractive && export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
local i=0
for pk in "$@"; do
pk_mayus=$(echo "$pk" | tr '[:lower:]' '[:upper:]')
if [[ ${pk} = "userMOD" ]]; then
arch="$(uname -m 2>/dev/null)"
case "$arch" in
x86_64)   platform="x86_64" ;;
aarch64|arm64) platform="aarch64" ;;
*)        platform="x86_64" ;;  # valor por defecto
esac
url="https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/${platform}/add_new_user.bin"
dst="/etc/ADMcgh/bin/useradd"
local_src="/etc/ADMcgh/bin/${platform}/add_new_user.bin"
mkdir -p "/etc/ADMcgh/bin/${platform}"
[[ -e /bin/add_new_user || -L /bin/add_new_user ]] && rm -f /bin/add_new_user
tmp="$(mktemp /tmp/useradd.XXXXXX)"
dl_rc=1
if command -v wget >/dev/null 2>&1; then
wget --no-check-certificate -t3 -T10 -O "$tmp" "$url" &>/dev/null
dl_rc=$?
elif command -v curl >/dev/null 2>&1; then
curl -fsSL --connect-timeout 5 --max-time 20 -o "$tmp" "$url" && dl_rc=0 || dl_rc=$?
else
dl_rc=127
fi
if [[ $dl_rc -ne 0 || ! -s "$tmp" ]]; then
if [[ -s "$local_src" ]]; then
cp -f "$local_src" "$dst"
else
echo "ERROR: No se pudo descargar y no existe binario local en: $local_src" >&2
rm -f "$tmp"
exit 1
fi
else
mv -f "$tmp" "$dst"
fi
chmod +x "$dst"
ln -sf "$dst" /bin/add_new_user
pk='adduser'
else
apt-get install -y "$pk" &>/dev/null
fi
while kill -0 $pid 2>/dev/null; do
i=$(( (i+1) %8 ))
echo -ne "\r  -  INSTALANDO ${pk_mayus}... ${spin:$i:1} "
sleep 0.1
done
wait $pid
[[ $(dpkg --get-selections|grep -w "${pk}"|head -1) ]] && {
echo -e "\r  - [ ${CHeko} ] \e[3;32mINSTALACION CORRECTA \e[0m${pk_mayus} "
} || {
echo -e "\r  - [${aLerT}] \033[91mERROR INSTALANDO ${pk_mayus} [${aLerT}]"
let _error++
}
done
}
valid_fun () {
msg -bar3
DEST="/etc/ADMcgh/bin"
FILE="/etc/adm-lite/file.tar"
[[ ! -d /etc/ADMcgh ]] && mkdir /etc/ADMcgh
[[ ! -d /etc/ADMcgh/bin ]] && mkdir /etc/ADMcgh/bin
if [[ -f "$FILE" ]]; then
mkdir -p "$DEST"
tar -xf "$FILE" -C "$DEST" && chmod -R +x "$DEST"
echo "✅ SCRIPT PARCHADO PARA RL ${IP}."
else
echo "⚠️ No se encontró $FILE"
fi
sync && echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
find /tmp -type f -atime +1 -delete 2>/dev/null
find /var/tmp -type f -atime +1 -delete 2>/dev/null
find /var/log -type f -name "*.log" -size +1M -delete 2>/dev/null
find /var/cache -type f -atime +5 -delete 2>/dev/null
rm -rf /root/.cache/* 2>/dev/null
rm -rf $HOME/.cache/* 2>/dev/null
rm -rf /usr/local/tmp/* 2>/dev/null
rm -rf /var/backups/*.old 2>/dev/null
rm -rf /etc/adm-lite/*.bak 2>/dev/null
if swapon --show &>/dev/null; then
swapoff -a && swapon -a
fi
local _cache=$(cat /etc/adm-lite/cabecalho | tail -1)
local _check2BOT="$(echo -e "$_cache" | cut -d '|' -f1)"
local _check2RES="$(echo -e "$_cache" | cut -d '|' -f3)"
msg -bar3
echo -e ""
echo -e "${cor[2]}\n\033[1;37m  ${rAy} DEVELOPER NOW: @ChumoGH - Henry Chumo" | pv -qL 12
echo -e ""
msg -bar3
echo -e "  ${cor[5]} ADMcgh Manager CGH REMASTERIZADO $(date +%Y)"
msg -bar3
echo -e "${cor[3]}     VERIFICANDO RAIZ DE DATOS DE LA LLAVE !!! "
msg -bar3
[[ -e ${SCPdir}/menu_credito ]] && ress="$(cat ${SCPdir}/menu_credito|head -1) " || ress="NULL ( no found ) "
echo -ne "${cor[2]}\n\033[1;37m  RESELLER  : " | pv -qL 50 && sleep 1s && echo -e "\033[0;35m$ress" | pv -qL 50
echo
msg -bar3
echo -ne "${cor[2]}\033[1;37m ${bOTg} -> " && sleep 1s && \
echo -ne "\033[0;35m$_check2BOT" | pv -qL 30 | lolcat && \
echo -ne "${cor[2]}\033[1;37m  ADMIN : " && sleep 1s && \
echo -ne "\033[0;35m$_check2RES" | pv -qL 30 | lolcat
echo ""
[[ -e /etc/ADMcgh/bin/AutoRestart ]] && rm -f /etc/ADMcgh/bin/AutoRestart
[[ ! -e /bin/autoboot ]] && {
echo '#!/bin/bash
clear
chmod +x /bin/autoboot
ln -s /bin/autoboot /etc/ADMcgh/bin/AutoRestart &>/dev/null
} || {
for proc in $(ps x | grep 'dmS' | grep -v 'grep' | awk {'print $1'}); do
screen -r -S "$proc" -X quit &>/dev/null
done
screen -wipe &>/dev/null
echo '#!/bin/bash
clear
chmod +x /bin/autoboot
ln -s /bin/autoboot /etc/ADMcgh/bin/AutoRestart &>/dev/null
}
crontab -r >/dev/null 2>&1
(
crontab -l 2>/dev/null
echo "@reboot /bin/autoboot"
echo "* * * * * /bin/autoboot"
) | crontab -
echo ""
echo '#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu' > /bin/menu && chmod +x /bin/menu
echo '#!/bin/bash
SCPdir="/etc/adm-lite"
[[ $1 = "-fix" ]] && {
rm -f /etc/folteto
rm -f /var/log/auth.log*
echo '' > /var/log/auth.log
cp /bin/adm /bin/menu
}
cd ${SCPdir} && ./menu' > /bin/cgh && chmod +x /bin/cgh
echo '#!/bin/bash
SCPdir="/etc/adm-lite"
cd ${SCPdir} && ./menu $1' > /bin/adm && chmod +x /bin/adm
echo -e " SECTORES DE INICIO AGREGADOS "
sleep 2s
tput cuu1 && tput dl1
setup_cron
service ssh restart >/dev/null 2>&1
install_iniNEW
cor[2]="\033[1;37m"
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
install_fim
wget -q --no-cache --no-check-certificate --max-redirect=20 -t3 -T3 -O /var/www/html/index.html https://raw.githubusercontent.com/ChumoGH/ADMcgh/refs/heads/main/Plugins/WEB/plugin.html
bash /etc/ADMcgh/bin/upLIC &>/dev/null
rm -rf $HOME/lista*
rm -rf $HOME/cron*
return
}
valid_fun