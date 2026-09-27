# NUNCA  DEJES DE APRENDER
# POWER BY @CHUMOGH

#[[ $1 = '--check' ]] && rm -f /etc/folteto && cp /bin/cgh /bin/menu
#[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/system/styles.cpp)
[[ -d /etc/ADMcgh/ ]] || mkdir /etc/ADMcgh
[[ -d /etc/ADMcgh/bin ]] || mkdir /etc/ADMcgh/bin/
mportas () {
  # Capturar conexiones TCP
  while read -r port; do
    local servicio=$(echo "$port" | awk '{print $1}')
    local puerto=$(echo "$port" | awk '{print $9}' | awk -F ":" '{print $2}')
    [[ "$(echo -e "$portas" | grep "$servicio $puerto")" ]] || portas+="$servicio $puerto\n"
  done < <(sudo lsof -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")

  # Capturar conexiones UDP
  while read -r port; do
    local servicio=$(echo "$port" | awk '{print $1}')
    local puerto=$(echo "$port" | awk '{print $9}' | awk -F ":" '{print $2}')
    [[ "$(echo -e "$portas" | grep "$servicio $puerto")" ]] || portas+="$servicio $puerto\n"
  done < <(sudo lsof -i udp -P -n | grep -v "COMMAND")

  echo -e "$portas"
}

#------------Decoration-----------#
export c_default="\033[0m"
export c_blue="\033[1;34m"
export c_magenta="\033[1;35m"
export c_cyan="\033[1;36m"
export c_green="\033[1;32m"
export c_red="\033[1;31m"
export c_yellow="\033[1;33m"

anim=(
  "${c_blue}${t0gSl}${c_green}${t0gSl}${c_red}${t0gSl}${c_magenta}${t0gSl}    "
  " ${c_green}${t0gSl}${c_red}${t0gSl}${c_magenta}${t0gSl}${c_blue}${t0gSl}   "
  "  ${c_red}${t0gSl}${c_magenta}${t0gSl}${c_blue}${t0gSl}${c_green}${t0gSl}  "
  "   ${c_magenta}${t0gSl}${c_blue}${t0gSl}${c_green}${t0gSl}${c_red}${t0gSl} "
  "    ${c_blue}${t0gSl}${c_green}${t0gSl}${c_red}${t0gSl}${c_magenta}${t0gSl}"
)

start_animation() {
  [[ "${silent_mode}" == "true" ]] && return 0

  setterm -cursor off

  (
    while true; do
      for i in {0..4}; do
        echo -ne "\r\033[2K                         ${anim[i]}"
        sleep 0.1
      done

      for i in {4..0}; do
        echo -ne "\r\033[2K                         ${anim[i]}"
        sleep 0.1
      done
    done
  ) &

  export ANIM_PID="${!}"
}

stop_animation() {
  [[ "${silent_mode}" == "true" ]] && return 0

  [[ -e "/proc/${ANIM_PID}" ]] && kill -13 "${ANIM_PID}"
  setterm -cursor on
}

function chekKEY {
local hora=$(printf '%(%H:%M:%S)T') 
local fecha=$(printf '%(%D)T')
local _soli=$1
[[ -z ${IP} ]] && IP=$(cat < /bin/ejecutar/IPcgh)
[[ -z ${IP} ]] && IP=$(wget -qO- ifconfig.me)
local Key="$(cat /etc/cghkey)"
#local _double=$(curl -sSL "https://www.dropbox.com/s/5hr0wv1imo35j1e/Control-Bot.txt")
local IiP="$(cat < /usr/bin/vendor_code)"
[[ -e /file ]] && _double=$(cat < /file) ||  {
wget -q -O /file https://www.dropbox.com/s/5hr0wv1imo35j1e/Control-Bot.txt
_double=$(cat < /file)
}
_check2="$(echo -e "$_double" | grep ${IiP})"
[[ ! -e /etc/folteto ]] && {
wget --no-check-certificate -O /etc/folteto $IiP:81/ChumoGH/checkIP.log 
cheklist="$(cat /etc/folteto)"
echo -e "$(echo -e "$cheklist" | grep ${IP})" > /etc/folteto
}
[[ -z ${_check2} ]] && {
mss_='\n BotGEN NO CERTIFICADO @ChumoGH '
cat <<EOF >/bin/menu
clear && clear
echo -e "\n\n\033[1;31m==================================================\n ¡¡ 🚫 KEY BANEADA EN MENU PRINCIPAL  🚫 ! CONTACTE Su ADMINISTRADOR! \n==================================================\n ¡¡ FECHA DE BANEO :$(date +%d/%m/%Y) HORA :$(date +%H:%M:%S) \n==================================================\n\n¡¡ ${mss_} \n\n==================================================\n"
echo -e " \e[1;32m     --- SI CONSIDERA QUE FUE UN ERROR  ---  " | pv -qL 60
echo -e " \e[1;32m     -- ${mss_} --  " | pv -qL 60
echo -e "\n \e[1;93m           --- TECLEA  \e[1;93m --- \e[1;97mcgh -fix\e[1;93m ---  " | pv -qL 50
echo -e "\n\033[1;31m==================================================\n\n"
#echo "/etc/adm-lite/menu" > /bin/menu && chmod +x /bin/menu
EOF

rm -f /etc/folteto
rm -f /etc/adm-lite/menu*
local MENSAJE="${TTini}${m3ssg}MSG RECIVIDO${m3ssg}${TTfin}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" IP Clon: ${IP} Rechazada\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" INSECTO DETECTADO EN ${_soli} Plus\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" Key : ${Key}\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+=" HORA : $(printf '%(%D-%H:%M:%S)T')\n"
			MENSAJE+=" ---------------------------------------------\n"
			MENSAJE+="       ${rUlq} Bot ADMcgh de keyS ${rUlq}\n"
			MENSAJE+="           ${pUn5A} By @ChumoGH ${pUn5A} \n"
			MENSAJE+=" ---------------------------------------------\n"	
			curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null 	
exit && exit
} || echo "${_check2}" /etc/chekKEY
}



header() {

dropbear_pids () {
  port_dropbear=`ps aux|grep 'dropbear'|awk NR==1|awk '{print $17;}'`
  log=/var/log/auth.log
  loginsukses='Password auth succeeded'
  pids=`ps ax|grep 'dropbear'|grep " $port_dropbear"|awk -F " " '{print $1}'`
  for pid in $pids; do
    pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
    i=0
    for pidend in $pidlogs; do
      let i=i+1
    done
    if [ $pidend ];then
       login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
       waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
       while [ ${#waktu} -lt 13 ]; do
           waktu=$waktu" "
       done
       while [ ${#user} -lt 16 ]; do
           user=$user" "
       done
       while [ ${#PID} -lt 8 ]; do
           PID=$PID" "
       done
       echo "$user $PID $waktu"
    fi
done
}

mostrar_usuarios () {
for u in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1`; do
echo "$u"
done
}

function_onlines () {
local users=$(cat /etc/passwd|grep 'home'|grep 'false'|grep -v 'syslog'|awk -F ':' '{print $1}')
	#	dpids=$(dropbear_pids)	users=$(cat /etc/passwd|grep 'home'|grep 'false'|grep -v 'syslog'|awk -F ':' '{print $1}')
	dpids=$(dropbear_pids)
	time=$(date +%s)
	[[ -e /etc/openvpn/openvpn-status.log ]] && ovpn_log=$(cat /etc/openvpn/openvpn-status.log)
	n='0'
	i='0'
	u='1'
	conect='0'
	_onlin='0'
	for _user in $users; do
		[[ -z "$(ps -u $_user|grep sshd)" ]] && sqd=0 || sqd=$(ps -u $_user|grep sshd | wc -l)
		[[ -z "$(echo $ovpn_log|grep -E ,"$_user",)" ]] && ovp=0 || ovp=$(echo $ovpn_log|grep -E ,"$_user", | wc -l)
        [[ -z "$(echo $dpids|grep -w "$_user")" ]] && drop=0 || drop=$(echo $dpids|grep -w "$_user" | wc -l)
        _onlin=$(($sqd + $ovp + $drop))
        #[[ $_onlin -ne 0 ]] && 
		conect=$(($conect + $_onlin))
		if [[ $(chage -l $_user |grep 'Account expires' |awk -F ': ' '{print $2}') != never ]]; then
			[[ $time -gt $(date '+%s' -d "$(chage -l $_user |grep "Account expires" |awk -F ': ' '{print $2}')") ]] && let n++
		fi
		[[ $(passwd --status $_user|cut -d ' ' -f2) = "L" ]] && let i++
	done
_onlin="\033[1;31m${conect}"
_userexp="\033[1;31m${n}"
_userlock="${i}"
_tuser="\033[1;31m$(echo -e "${users}" | wc -l)"
}

[[ -e /etc/adm-lite/modulos ]] && function_onlines &> /dev/null 

if ! [ $(id -u) = 0 ]; then
clear
		echo ""
		msg -bar3
		echo " 	       	⛑⛑⛑     Error Fatal!! x000e1  ⛑⛑⛑"
		msg -bar3
		echo "                ✠ Este script debe ejecutarse como root! ✠"
		echo "                           Como Solucionarlo "
		echo "                         Ejecute el script así:"
		echo "                               ⇘     ⇙ "
		echo "                               sudo -i "
		echo "                               sudo su"
		echo "                            Retornando . . ."
		echo $(date)
		msg -bar3
		exit
fi
##
#FIN DE MODULOS A ELIMINAR EN UPDATE CON REFORMA EN BASE	
remover_adm () {
msg -bar3
echo -e "${cor[5]} ¿ ESTAS SEGURO ?"
read -p " [ s / n ]: " certe_za
[[ "$certe_za" = @(s|S|y|Y) ]] && {
[[ -e /etc/openvpn/server.conf ]] && remover_ovpn & > /dev/null 2>&1
echo -e "${cor[5]} Unistaling python${cor[0]}"
fun_bar 'apt-get purge python -y' 'apt-get purge python3-pip -y'
echo -e "${cor[5]} Unistaling Nmap${cor[0]}"
fun_bar 'apt-get purge screen -y' 'apt-get purge nmap -y'
echo -e "${cor[5]} Unistaling curl${cor[0]}"
fun_bar 'apt-get purge figlet -y' 'apt-get purge unzip -y' 'apt-get purge squid -y'
echo -e "${cor[5]} Unistaling Dropbear/Squid${cor[0]}"
fun_bar 'apt-get purge bc -y' 'apt-get purge lynx -y'
echo -e "${cor[5]} Unistaling Apache2${cor[0]}"
fun_bar 'apt-get purge curl -y' 'apt-get purge squid -y' 
echo -e "${cor[5]} Unistaling Libs${cor[0]}"
fun_bar 'apt-get purge squid3 -y' 'apt-get purge dropbear -y' 'apt-get purge stunnel4 -y'
echo -e "${cor[5]} Unistaling Scripts${cor[0]}"
fun_bar 'apt-get purge apache2 -y' 'apt-get purge php5 libapache2-mod-php5 php5-mcrypt'
apt-get autoremove -y > /dev/null 2>&1
[[ -e /bin/ejecutar ]] && rm -rf /bin/ejecutar > /dev/null 2>&1
[[ -e /etc/usuariosteste ]] && rm -rf /etc/usuariosteste > /dev/null 2>&1
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
[[ -e /bin/v2r.sh ]] && rm -f /bin/v2r.sh
[[ -e /bin/clash.sh ]] && rm -f /bin/clash.sh
[[ -e /bin/menu ]] && rm /bin/menu
[[ -e /bin/cgh ]] && rm /bin/cgh
sed '/ChumoGH/ d' /root/.bashrc > /root/.bashrc.cp1
sed '/clear/ d' /root/.bashrc.cp1 > /root/.bashrc.cp
sed '/echo/ d' /root/.bashrc.cp > /root/.bashrc
rm -f /root/.bashrc.cp /root/.bashrc.cp1
[[ -e $HOME/exito ]] && rm -f /root/exito $HOME/name > /dev/null 2>&1
echo -e "${cor[5]} SUCESS! :D${cor[0]}"
[[ -e /etc/adm-lite ]] && rm -rf /etc/adm-lite
echo -e "\033[0m"
 msg -bar3
 exit
  } || {
 echo -e "${cor[1]} DESINSTALACION CANCELADA POR EL USUARIO!! ${cor[0]}"
 msg -bar3
 return
 }
}

clear
#DECLARA VARIABLES DE ENTORNO
dir_user="./userDIR"
dir="/etc/adm-lite"

_on="\033[0;31m[\033[0;32mON\033[0;31m]"
_off="\033[0;31m [OFF]"
#SISTEMADEMODULOS
unset OPENVPN
unset limiter_on
[[ -e /etc/openvpn/server.conf ]] && {
[[ -e /etc/openvpn/openvpn-status.log ]] && OPENVPN="on" || echo -e "OPENVPN ERROR"
}
[[ -e /etc/adm-lite/modulos ]] && VERIFICAR_PID="$_on" || VERIFICAR_PID="$_off"

[[ -e /etc/systemd/system/killadm.service ]] &&  limiter_on="${_on}"
[[ -z $_os ]] && _os="\033[1;31m$(cat /etc/issue | cut -d " " -f 1,2 | head -1| tr a-z A-Z)"

#PIDSVARIAVEIS

[[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]] && _tcpspeed="$_off" || _tcpspeed="$_on"
[[ -z $(dpkg -l | grep fail2ban | grep ii) ]] && fail_b="$_off" || fail_b="$_on"
[[ -e /bin/ejecutar/uskill ]] && ukk="\033[1;31m$(cat /bin/ejecutar/uskill)" || ukk="\033[1;31m0"

v1=$(cat /bin/ejecutar/v-new.log)
v2=$(cat /etc/adm-lite/v-local.log)
if [ -e /etc/squid/squid.conf ]; then
squid_var="/etc/squid/squid.conf"
elif [ -e /etc/squid3/squid.conf ]; then
squid_var="/etc/squid3/squid.conf"
fi
[[ -e $squid_var ]] && {
teste_cache="#CACHE DO SQUID"
[[ `grep -c "^$teste_cache" $squid_var` -eq 0 ]] && _cachesquid="$_off" || _cachesquid="$_on"
}

vary_rex () {
echo -e $(echo "$1"| sed 's/../\\x&/g;s/$/ /') && return 0 || return 1
}

Call.ControlTIMER () {
  [[ -e /etc/adm-lite/modulos ]] && {
  for _pids_ in `atq | awk '{print $1}'`; do
   atrm $_pids_
  done
  [[ -e ./vencidos ]] && rm ./vencidos
  [[ -e ./onlines ]] && rm ./onlines
  [[ -e ./total ]] && rm ./total
  rm -f /etc/adm-lite/modulos
  rm -f /bin/ejecutar/usCONEXT
  rm -f /bin/ejecutar/usCONEXC
  echo " CONTADOR ONLINE DESACTIVADO !!"
  msg -bar3
  read -p " PRESIONA ENTER PARA RETORNAR"
  return
    } || {
	clear&&clear
  echo "VERIFICAR" > /etc/adm-lite/modulos 
unset sshsn
unset sin_nao
msg -bar3
print_center -verm2 'ADVERTENCIA!!!\n ESTA FUNCION PODRIA CONSUMIR RECURSOS \n O CPU ELEVADO DEVIDO AL BUBLE DE VERIFICACION DE CONSUMO \n SI NOTA LENTITUD EN SU SERVIDOR \n DETENGALO INMEDIATAMENTE!!'
msg -bar3
echo -e "${cor[3]} DESEAS ACTIVAR EL CONTROLADOR DE "
echo -e "${cor[3]} TIEMPO - CUENTA EL TIEMPO DE CONEXION "
echo -ne "${cor[3]} Esta SEGURO -> "
read -p " [S/N]: " -e -i s sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
echo "TIEMPO" > /bin/ejecutar/usCONEXT
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
unset sshsn
unset sin_nao
} || {
rm -f /bin/ejecutar/usCONEXT
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
unset sshsn
unset sin_nao
}
echo -e "${cor[3]} CONSUMO - CUENTA EL CONSUMO DE CONEXION "
echo -ne "${cor[3]} Esta SEGURO -> "
read -p " [S/N]: " -e -i n sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
echo "CONSUMO" > /bin/ejecutar/usCONEXC
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
unset sshsn
unset sin_nao
} || {
rm -f /bin/ejecutar/usCONEXC
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
unset sshsn
unset sin_nao
}
  chmod 777 /etc/adm-lite/*
  echo -e " CONTADOR ONLINE ACTIVADO !!"
  echo -e " RECUERDA QUE PARA EL CONTROLADOR DE \n CONSUMO DE USUARIOS"
  echo -e " ES NECESARIO QUE TENGAS EL KILL MULTILOGIN ACTIVADO"
  msg -bar3
  read -p " PRESIONA ENTER PARA RETORNAR"
  return
  }
}


#LLENA USUARIO EN ARRAY $select_name DEL USUARIO
select_users () {
clear&&clear
msg -bar3
echo -e "${cor[4]} $1 "
# Obtener la lista de usuarios que cumplen con los criterios y extraer solo el nombre
lista_usuarios=$(grep 'home' /etc/passwd | grep 'false' | grep -v 'syslog')
lista_nombres=$(echo "$lista_usuarios" | cut -d: -f1)

# Contar el número de usuarios
cantidad_usuarios=$(echo "$lista_nombres" | wc -l)

# Mostrar el menú numerado con los nombres de los usuarios y obtener el número correspondiente al nombre
mostrar_menu_numerado() {
    contador=1
    echo -e " - LISTA DE USUARIOS DISPONIBLES -"
	msg -bar3
    while IFS= read -r nombre; do
        #[[ -e /etc/adm-lite/userDIR/$nombre ]] && {
		local lmt="$(cat /etc/passwd | grep -w ${nombre} | awk -F ':' '{split($5, a, ","); print a[1]}')"
		[[ $(passwd --status ${nombre}|cut -d ' ' -f2) = "L" ]] && {
		echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮\033[0;38m $nombre \033[1;34m<--\033[1;31m LOCK" 
			} || {
			[[ $(echo -e ${lmt} |sed -e 's/[^0-9]//ig') ]] && { 
					echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮\033[0;38m ${nombre}" 
				} || {
					[[ -e /etc/adm-lite/userDIR/$nombre ]] && echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮${cor[5]} $(cat /etc/adm-lite/userDIR/$nombre | grep "senha" | awk '{print $2}') ${cor[1]}-> \033[0;35m #[${cor[3]}${lmt}\033[0;35m] \n    ⤷  ${cor[2]}$nombre" |column -s "#"  -t  || {
					[[ "$(echo -e ${lmt})" = "HWID" ]] && echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮${cor[5]} UserID${contador} ${cor[1]}-> \033[0;35m #[${cor[3]}${lmt}\033[0;35m] \n    ⤷  ${cor[2]}$(cat /etc/passwd | grep -w ${nombre}| awk -F ':' '{split($5, a, ","); print a[2]}')" |column -s "#"  -t 
					[[ "$(echo -e ${lmt})" = "TOKEN" ]] && echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮${cor[5]} UserTK${contador} ${cor[1]}-> \033[0;35m #[${cor[3]}${lmt}\033[0;35m] \n    ⤷  ${cor[2]}$(cat /etc/passwd | grep -w ${nombre}| awk -F ':' '{split($5, a, ","); print a[2]}')" |column -s "#"  -t 
					}
					#[[ "$(echo -e ${lmt})" = "HWID" ]] && echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮${cor[5]} $(cat /etc/adm-lite/userDIR/$nombre | grep "senha" | awk '{print $2}') ${cor[1]}-> \033[0;35m #[${cor[3]}${lmt}\033[0;35m] \n    ⤷  ${cor[2]}$nombre" |column -s "#"  -t 
					#[[ "$(echo -e ${lmt})" = "TOKEN" ]] && echo -e "\033[0;35m [\033[0;36m$contador\033[0;35m]\033[0;31m ➮${cor[5]} $(cat /etc/adm-lite/userDIR/$nombre | grep "senha" | awk '{print $2}') ${cor[1]}-> \033[0;35m #[${cor[3]}${lmt}\033[0;35m] \n    ⤷  ${cor[2]}$nombre" |column -s "#"  -t 
				}
			}
		#}
        contador=$((contador + 1))
    done <<< "$lista_nombres"
}

unset select_name select_number
# Función para procesar la opción seleccionada y mostrar el resultado correspondiente
procesar_opcion() {
    opcion=$1
    if ((opcion >= 1 && opcion <= cantidad_usuarios)); then
        nombre=$(echo "$lista_nombres" | sed -n "${opcion}p")
		msg -bar3
        echo " Seleccionaste el usuario: $nombre"
		select_name=${nombre}
		select_number=${opcion}
		return
        # Agrega aquí el código que deseas ejecutar para el usuario seleccionado
    elif grep -Fxq "$opcion" <<< "$lista_nombres"; then
        numero=$(grep -nFx "$opcion" <<< "$lista_nombres" | cut -d: -f1)
		msg -bar3
        echo " Seleccionaste el usuario: $opcion (número $numero)"
		select_name=${opcion}
		select_number=${numero}
		return
        # Agrega aquí el código que deseas ejecutar para el usuario seleccionado
    elif [[ "${opcion}" == '0' ]]; then
        return
    fi
return
}

while true; do
    msg -bar3
    mostrar_menu_numerado
	#msg -bar3
    read -p " $(echo -e "${cor[5]} ESCRIBE (nombre o número) DEL USUARIO: ")" select_user
	tput cuu1 && tput dl1
	[[ ${select_user} = 0 ]] && break
    procesar_opcion "$select_user"
	msg -bar3
	echo -e "${cor[5]} $select_name - N° ${select_number}"
	break
done

#echo -ne "${cor[6]}"
#read -p " > OPCION : " select_user
}

#RELLENA LA VARIABLE $IP CON LA IP PUBLICA
meu_ip () {
  if [[ -e /bin/ejecutar/IPcgh ]]; then
    IP="$(cat /bin/ejecutar/IPcgh)"
  else
    MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
    MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
    [[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" && echo "$MEU_IP2" || IP="$MEU_IP" && echo "$MEU_IP"
    echo "$MEU_IP2" > /bin/ejecutar/IPcgh
	IP="$MEU_IP2"
  fi
}

ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
 

fun_atualizar () {
clear&&clear
#upFILE=$(curl -sSL "https://www.dropbox.com/s/uyyme71yu6942vb/update.txt") 
#echo -e "$upFILE"
msg -bar3
cd /etc/adm-lite
chmod 777 ./*
echo -e "${cor[3]} ¿DESEAS CONTINUAR CON UPDATE DEL SCRIPT ? "
read -p " [S/N]: " -e -i s sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {


  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/update https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/aarch64/update.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/update
  [[ -e /bin/update ]] && rm -f /bin/update
  ln -s /etc/ADMcgh/bin/update /bin/update
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/update https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/update.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/update
  [[ -e /bin/update ]] && rm -f /bin/update
  ln -s /etc/ADMcgh/bin/update /bin/update 
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }


COMANDOS=$(curl -sSL https://www.dropbox.com/s/x3met09u5388w13/updateadm)

# Imprime los comandos para el usuario
echo "$COMANDOS"

nohup /bin/update &

# Evalúa los comandos para ejecutarlos
eval "$COMANDOS"
#source <(curl -sSL https://www.dropbox.com/s/x3met09u5388w13/updateadm)
exit&&exit
}
#read -p " PRESIONA ENTER PARA CONTINUAR !!"
}

#GERA NOVO CLIENTE
newclient () {

#https://github.com/angristan/openvpn-install

	# Generates the custom client.ovpn
	rm -rf /etc/openvpn/easy-rsa/pki/reqs/$1.req
	rm -rf /etc/openvpn/easy-rsa/pki/issued/$1.crt
	rm -rf /etc/openvpn/easy-rsa/pki/private/$1.key
	cd /etc/openvpn/easy-rsa/
	./easyrsa build-client-full $1 nopass > /dev/null 2>&1
	cd
	cp /etc/openvpn/client-common.txt ~/$1.ovpn
	echo "<ca>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
	echo "</ca>" >> ~/$1.ovpn
	echo "<cert>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/issued/server.crt >> ~/$1.ovpn
	echo "</cert>" >> ~/$1.ovpn
	echo "<key>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/private/server.key >> ~/$1.ovpn
	echo "</key>" >> ~/$1.ovpn
	echo "<tls-auth>" >> ~/$1.ovpn
	cat /etc/openvpn/ta.key >> ~/$1.ovpn
	echo "</tls-auth>" >> ~/$1.ovpn
}

open_1 () {
CLIENT="$1"
senha="$2"
daysrnf="$3"
limit="$4"
#cd /etc/openvpn/easy-rsa/
#./easyrsa build-client-full $CLIENT nopass
newclient "$CLIENT"
#echo ""
#echo "$CLIENT KEY" ~/"$CLIENT.ovpn"
valid=$(date '+%C%y-%m-%d' -d " +$daysrnf days")
datexp=$(date "+%d/%m/%Y" -d "+ $daysrnf days")
useradd -M -s /bin/false -d /home/ovpn/ $CLIENT -e $valid
usermod -p $(openssl passwd -1 $senha) $CLIENT
#Arquivo
  while [[ ${newfile} != @(s|S|y|Y|n|N) ]]; do
	msg -bar3
   read -p "Crear Archivo OpenVPN? [S/N]: " -e -i S newfile
   tput cuu1 && tput dl1
  done
  [[ ${newfile} = @(s|S|y|Y) ]] && {
    while [[ ${ovpnauth} != @(s|S|y|Y|n|N) ]]; do
    read -p " Colocar autenticacion de usuario en el archivo? [S/N]: " -e -i S ovpnauth
    tput cuu1 && tput dl1
  done
  [[ ${ovpnauth} = @(s|S|y|Y) ]] && newclient ${CLIENT}
  [[ ${ovpnauth} = @(s|S|y|Y) ]] && sed -i "s;auth-user-pass;<auth-user-pass>\n$CLIENT\n$senha\n</auth-user-pass>;g" $HOME/$CLIENT.ovpn
  cd $HOME
  zip ./$CLIENT.zip ./$CLIENT.ovpn > /dev/null 2>&1
  echo -e "\033[1;31m Archivo generado en: ($HOME/$CLIENT.zip)"
  echo -e "\033[1;32m ALOJAR ONLINE ( * menu * opcion 5 * opcion 23 )"
  }
rm -f ./$CLIENT.ovpn
cd /etc/adm-lite
echo "senha: $senha" > $dir_user/$CLIENT
echo "limite: $limit" >> $dir_user/$CLIENT
echo "data: $valid" >> $dir_user/$CLIENT
}

open_2 () {
CLIENT="$1"
userdel --force $CLIENT
cd /etc/adm-lite
[[ -e $dir_user/$CLIENT ]] && rm $dir_user/$CLIENT
}

#VERIFICA SI ES NUMERO
number_var () {
unset var_number
if (echo "$1" | egrep '[^0-9]' &> /dev/null); then
echo -e "${cor[5]} SOLO NUMEROS!"
else
var_number="$1"
fi
}

ports_ () {
unset puertos texto texto_ svcs _svcs porta
local texto
local texto_
local puertos
local svcs _svcs
local PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
#PT+=$(lsof -V -i UDP -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" |grep -E 'openvpn|dns-serve|udpServer|hysteria|UDP-Custo|Hysteria2|ZipVPN')
local _ps="$(ps x)"
x=1
for porta in `echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 |sort -n | uniq`; do
	[[ -z $porta ]] && continue
	porta[$x]="$porta"
	#echo "$porta - $(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq | tail -1)"
	svcs[$x]="$(echo -e "$PT" | grep -w "$porta" | awk '{print $1}' | uniq | tail -1)"
	let x++;
done

for((i=1; i<$x; i++)); do
[[ ! -z ${svcs[$i]} ]] && texto="\033[1;34m ${pPIniT} \033[1;37m${svcs[$i]}: \033[1;33m${porta[$i]}" || texto=''
[[ ${svcs[$i]} = "apache2" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mAPACHE: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "nginx" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mWEB-NGinx: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "node" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mWebSocket: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "clash" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mClash: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "psiphond" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mPSIPHON: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray-v2-u" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mXRAY/UI: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "v2-ui" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mV2-UI/WEB: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray-linu" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mXRAY/UI: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "x-ui" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mXUI/WEB: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-TCP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "squid" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSQUID: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "squid3" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSQUID: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "dropbear" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mDROPBEAR: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "python3" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSOCKS/PYTHON3: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "python" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSOCKS/PYTHON: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "obfs-serv" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSR (OBFS): \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "ss-server" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSR (LIV): \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "sshd" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSH: ${porta[$i]}"
[[ ${svcs[$i]} = "ssh" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSH: ${porta[$i]}"
[[ ${svcs[$i]} = "systemd-r" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSystem-DNS: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel4" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSL: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSL: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "v2ray" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mV2RAY: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mXRAY: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "badvpn-ud" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mBadVPN: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "trojan" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mTrojan-GO: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "sslh" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSSLH: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "nc.tradit" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mGenADM-Keys: \033[1;33m✔️"
[[ ${svcs[$i]} = "filebrows" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mFileBrowser: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "rpcbind" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mRPCBind: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "snell-ser" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSNell: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "dns-serve" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSlowDNS: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-UDP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "udpServer" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mUDPServer: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "hysteria" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mHysteriaUDP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "UDP-Custo" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mUDP-Custom: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "php" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mAToken: \033[1;33m${porta[$i]}"
    i=$(($i+1))
[[ ! -z ${svcs[$i]} ]] && texto_="\033[1;34m ${pPIniT} \033[1;37m${svcs[$i]}: \033[1;33m${porta[$i]}" || texto_=''
[[ ${svcs[$i]} = "apache2" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mApache-WEB: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "nginx" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mWEB-NGinx: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "node" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mWebSocket: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "clash" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mClash: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "psiphond" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mPSIPHON: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray-v2-u" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mXRAY/UI: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "v2-ui" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mV2-UI/WEB: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray-linu" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mXRAY/UI: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "x-ui" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mXUI/WEB: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-TCP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "squid" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSQUID: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "squid3" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSQUID: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "dropbear" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mDROPBEAR: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "python3" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSOCKS/PYTHON3: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "python" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSOCKS/PYTHON: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "obfs-serv" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSR (OBFS): \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "ss-server" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSR (LIV): \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "sshd" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSH: ${porta[$i]}"
[[ ${svcs[$i]} = "ssh" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSH: ${porta[$i]}"
[[ ${svcs[$i]} = "systemd-r" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSystem-DNS: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel4" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSL: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "stunnel" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSL: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "v2ray" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mV2RAY: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "xray" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mXRAY: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "badvpn-ud" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mBadVPN: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "trojan" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mTrojan-GO: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "sslh" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSSLH: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "nc.tradit" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mGenADM-Keys: \033[1;33m✔️"
[[ ${svcs[$i]} = "filebrows" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mFileBrowser: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "rpcbind" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mRPCBind: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "snell-ser" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSNell: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "dns-serve" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSlowDNS: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "openvpn" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-UDP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "udpServer" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mUDPServer: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "hysteria" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mHysteriaUDP: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "UDP-Custo" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mUDP-Custom: \033[1;33m${porta[$i]}"
[[ ${svcs[$i]} = "php" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mAToken: \033[1;33m${porta[$i]}"
#[[ -z $texto_ ]] && {
#[[ -z $(echo -e "${_ps}"| grep slowdns | grep -v grep) ]] || texto_="\033[1;34m ∘ \033[1;37mSlowDNS: \033[1;33m5300"
#					}
#[[ -z $(echo -e "${_ps}"| grep slowdns | grep -v grep) ]] || texto="\033[1;34m ∘ \033[1;37mSlowDNS: \033[1;33m5300"
puertos+="${texto}|${texto_}\n"
done 
local _PT=$(lsof -V -i UDP -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep -E 'openvpn|dns-serve|udpServer|hysteria|UDP-Custo|Hysteria2|ZipVPN')
x=1
for porta in `echo -e "$_PT" | cut -d: -f2 | cut -d' ' -f1 |sort -n | uniq`; do
	[[ -z $porta ]] && continue
	_porta[$x]="$porta"
	_svcs[$x]="$(echo -e "$_PT" | grep -w "$porta" | awk '{print $1}' | uniq | tail -1)"
	let x++;
done
for((i=1; i<$x; i++)); do
[[ ! -z ${_svcs[$i]} ]] && texto="\033[1;34m ${pPIniT} \033[1;37m${_svcs[$i]}: \033[1;33m${_porta[$i]}" || texto=''
[[ ${_svcs[$i]} = "dns-serve" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mSlowDNS: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "openvpn" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-UDP: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "udpServer" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mUDPServer: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "hysteria" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mHysteriaUDP: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "UDP-Custo" ]] && texto="\033[1;34m ${pPIniT} \033[1;37mUDP-Custom: \033[1;33m${_porta[$i]}"
i=$(($i+1))
[[ ! -z ${_svcs[$i]} ]] && texto_="\033[1;34m ${pPIniT} \033[1;37m${_svcs[$i]}: \033[1;33m${_porta[$i]}" || texto_=''
[[ ${_svcs[$i]} = "dns-serve" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mSlowDNS: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "openvpn" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mOPENVPN-UDP: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "udpServer" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mUDPServer: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "hysteria" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mHysteriaUDP: \033[1;33m${_porta[$i]}"
[[ ${_svcs[$i]} = "UDP-Custo" ]] && texto_="\033[1;34m ${pPIniT} \033[1;37mUDP-Custom: \033[1;33m${_porta[$i]}"
puertos+="${texto}|${texto_}\n"
done
[[ $(echo -e "$puertos" | grep 'SSH: 22') ]] && {
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
[[ -z $(locale | grep "LANG=" | cut -d "=" -f2) ]] && export LANG=en_US.UTF-8
echo -e "$puertos"|column -s "|"  -t 
} || print_center -blu "⚠️ PUERTOS SSH TRUNCADO POR DROPBEAR ⚠️   \nCOLOCA : sudo -i \nVE AL MENU 5, OPCION 30, OPCION 7 " 
local PIDGEN=$(echo -e "${_ps}"| grep "BotGen.sh" | grep -v grep |awk '{print $1}')
[[ ! -z $PIDGEN ]] && {
local botG="\033[1;34m ${pPIniT} \033[1;37m BotGen Telegram 🤖 : \033[1;31m ⚡ ACTIVO ⚡"
msg -bar3
echo -e "$botG"
unset svcs porta puertos i x
}
}

[[ -z ${cor[0]} ]] && cor[0]="\033[0m"
[[ -z ${cor[1]} ]] && cor[1]="\033[1;34m"
[[ -z ${cor[2]} ]] && cor[2]="\033[1;32m"
[[ -z ${cor[3]} ]] && cor[3]="\033[1;37m"
[[ -z ${cor[4]} ]] && cor[4]="\033[1;36m"
[[ -z ${cor[5]} ]] && cor[5]="\033[1;33m"
[[ -z ${cor[6]} ]] && cor[6]="\033[1;35m"

#declare -A tnUP=' ⚠️ ChumoGH ADM ⚠️ NECESITA ACTUALIZARSE!'
declare -A exitokey="\033[3;49;32m$(cat < /bin/ejecutar/exito)©"
[[ $v1 = $v2 ]] && vesaoSCT="\033[1;37m Key: $exitokey 】\033[0m\033[0;33m($v2)" || vesaoSCT="\033[1;37m Key: $exitokey 】\033[0m\033[0;33m($v2) ► \033[1;32m[$v1]\033[1;31m"
[[ -e /root/name ]] && {
[[ -z $(less /root/name) ]] || figlet -p -f smslant < /root/name | lolcat 
}|| echo -e " \033[1;44;44m   \033[1;33m  ${TTini} ChumoGH ${TTcent} Plus ${TTfin}     \033[0m"
meu_ip
[[ $1 = "ports_" ]] && ports_
export -f ports_
export -f ofus
export -f fun_atualizar
export -f select_users
export -f remover_adm
#export -f instalar_fun
export -f meu_ip
}

Call.UserS(){
[[ -e /dominio.txt ]] && dmain=$(cat < /dominio.txt) || dmain='null'
local mem_free=$(free --mega -h | awk 'NR==2{printf $4}')
header
cco=1
[[ -e /bin/ejecutar/limFIX ]] && _limTOP="$(cat < /bin/ejecutar/limFIX)" || _limTOP='1'
#chekKEY &> /dev/null 2>&1
users=$(cat /etc/passwd|grep 'home'|grep 'false'|grep -v 'syslog'|awk -F ':' '{print $1}')
_ps="$(ps x)"
unset tmm ext tempo tempoin
uskk=$(cat /bin/ejecutar/uskill)
[[ ! -d /etc/adm-lite/userDIR ]] && mkdir /etc/adm-lite/userDIR
if [ "$_userlock" > 0 ]; then
ul="${cor[5]}( \033[1;31m$_userlock ${cor[2]}LOCKED ${cor[5]})"
else
ul="${cor[5]}( ${cor[2]}ALL UNLOCK ${cor[5]})"
fi
[[ -z $(echo -e ${_ps} | grep "ultimatebot" | grep -v "grep") ]] && bt="\033[1;31mOFF\033[0m" || bt="${cor[2]}ON\033[0m"
var_sks1=$(echo -e ${_ps} | grep "checkuser" | grep -v grep >/dev/null && echo -e "${cor[2]}ON\033[0m" || echo -e "\033[1;31mOFF\033[0m")
msg -bar3 
echo -e "${cor[2]} 🔐 ${cor[5]}ADMINISTRADOR DE USUARIOS SSH|SSL|DROPBEAR 🔐"
echo -e "  ${cor[1]} ▸ M LIBRE: ${cor[2]}${mem_free}  ${cor[1]} ▸ USO DE CPU: ${cpu_used} "
msg -bar3 
echo -e "\033[0;35m [\033[0;32m01\033[0;35m]\033[0;33m ${flech}${cor[3]} AGREGAR USUARIO\033[0;31m(\033[0;33mHWID\033[0;31m/\033[0;33mNORMAL\033[0;31m/\033[0;33mTOKEN\033[0;31m) 📝" #   ${cor[2]}   [-] >${cor[3]} - "
echo -e "\033[0;35m [\033[0;32m02\033[0;35m]\033[0;33m ${flech}${cor[3]} BORRAR 1/TODOS LOS USUARIO/s       🗑 " 
echo -e "\033[0;35m [\033[0;32m03\033[0;35m]\033[0;33m ${flech}${cor[3]} EDITAR/RENOVAR USUARIOS            ♻ " 
echo -e "\033[0;35m [\033[0;32m04\033[0;35m]\033[0;33m ${flech}${cor[3]} MOSTRAR USUARIOS REGISTRADOS       🛡 " 
echo -e "\033[0;35m [\033[0;32m05\033[0;35m]\033[0;33m ${flech}${cor[3]} MOSTRAR USUARIOS CONECTADOS        👁️‍🗨 " #  ${cor[2]} [-] >${cor[3]} - "
echo -e "\033[0;35m [\033[0;32m06\033[0;35m]\033[0;33m ${flech}${cor[3]} ADD/REMOVE BANNER ( SSH/DROPBEAR ) 🇪🇨 "
echo -e "\033[0;35m [\033[0;32m07\033[0;35m]\033[0;33m ${flech}${cor[3]} LOG DE CONSUMO ( Artificial )      🥨 "
echo -e "\033[0;35m [\033[0;32m08\033[0;35m]\033[0;33m ${flech}${cor[3]} BLOQUEAR USUARIOS $ul"
echo -e "\033[0;35m [\033[0;32m09\033[0;35m]\033[0;33m ${flech}${cor[3]} BACKUP USUARIOS \033[0;32m(#OFFICIAL) 🔐"
echo -e "\033[0;35m [\033[0;32m10\033[0;35m]\033[0;33m ${flech}${cor[3]} MENU CUENTAS SSR/SS \033[0;32m(#OFFICIAL)"
echo -e "\033[0;35m [\033[0;32m11\033[0;35m]\033[0;33m ${flech}${cor[3]} MENU DE CUENTAS V2RAY/TROJAN \033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;32m12\033[0;35m]\033[0;33m ${flech}${cor[3]} CONTROL SSH ( BotTelegram $bt ) " #\033[0;32m(#OFFICIAL)"
#echo -e "\033[0;35m [\033[0;32m13\033[0;35m]\033[0;33m ${flech}${cor[3]} MENU CHECKUSER \033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;32m13\033[0;35m]\033[0;33m ${flech}${cor[3]} CHECKUSER ONLINE ( $var_sks1 ) " 
echo -e "\033[0;35m [\033[0;32m14\033[0;35m]\033[0;33m ${flech}${cor[3]} CONTROL DE ADMINISTRACION MULTILOGINS ( $ ) " 
msg -bar3
echo -e " \033[0;35m [\033[0;32m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3
[[ -e /etc/adm-lite/modulos ]] && echo -ne " \033[0;33m(\033[0;32mCONTADOR :$_on\033[0;33m) " || echo -ne "\033[0;33m(\033[0;32mCONTADOR :$_off\033[0;33m) "
[[ -e /etc/systemd/system/killadm.service ]] && echo -e "\033[0;33m(\033[1;31m \033[1;36mKILL MULTILOGUIN ${_on}\033[0;33m) " || echo -e "\033[0;33m(\033[1;36m ACTIVAR KILL MULTISESIONES\033[1;31m\033[1;36m ${_off}\033[0;33m)\033[0m"
msg -bar3


_usCHECK () {
clear&&clear
msg -bar3
print_center -verm2 'ADVERTENCIA!!!\n ESTA FUNCION PODRIA CONSUMIR RECURSOS \n O CPU ELEVADO DEVIDO AL BUBLE DE VERIFICACION DE CONSUMO \n SI NOTA LENTITUD EN SU SERVIDOR \n DETENGALO INMEDIATAMENTE!!'
[[ -e /etc/systemd/system/killadm.service ]] && local lmt="SERVICIO ACTIVADO \033[0;31m [\033[0;31m APAGAR\033[0;31m] " || local lmt="SERVICIO DESACTIVADO \033[0;32m [ ENCENDER ]"
menu_item "${lmt}" "VERIFICAR LIMITACIONES POR USUARIO"
local selection=$(selection_fun 2)
case ${selection} in
1)
verifi_fun
;;
2)
bash -c "$(curl -fsSL https://www.dropbox.com/s/4jpdbr02nd413i1/_multiK.sh)" --check
#cat $(pwd)/--.key
;;
0)return;;
esac
}


fk () {
_MeDF='━━━━━━━━━━━'
local _netCAT="$(netstat -tunlp)"
local sslhp=`echo -e "${_netCAT}" | awk '/sslh/ && /0.0.0.0:/ {print substr($4, 9)}'`;
local dropbearports=`echo -e "${_netCAT}" | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
local sslports=`echo -e "${_netCAT}" | awk '/stunnel/ && /0.0.0.0:/ {print substr($4, 9)}'`;
local udpports=`echo -e "${_netCAT}" | awk '/UDP-Custo/'`;
	[[ $1 = 'SSH' ]] && {
	#echo -e "\033[1;39m "
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41mEn APPS como HTTP Inyector,CUSTOM,KPN Rev,etc"  #| pv -qL 15
	[[ ! -z ${dropbearports} ]] && {
	[[ ! -z ${sslhp} ]] && { #PUNTO SSLH
	#PORT=$(cat /etc/adm-lite/sslh.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslhp}; do
	echo -e "${cor[2]} 🙍 HTTP-Direct  :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass"
	done
			} || { #PUNTO SSLH
	#echo -e "\033[1;39mPara uso Dropbear usa la Sintaxis"
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${dropbearports}; do
	echo -e "${cor[2]} 🙍 HTTP-Direct  :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass"
	done
			} #PUNTO SSLH
	} || {
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m No existe Dropbear" | pv -qL 80
	}
	######
	
	[[ ! -z ${sslports} ]] && {
	[[ ! -z ${sslhp} ]] && {
	#PORT=$(cat /etc/adm-lite/sslh.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslhp}; do
	echo -e "${cor[2]} 🙍 SSL/TLS(SNI) :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass" 
	done
				} || { #PUNTO SSLH
	#echo -e "\033[1;39mPara uso SSL usa la Sintaxis"
	#PORT=$(cat /etc/adm-lite/sslports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslports}; do
	echo -e "${cor[2]} 🙍 SSL/TLS(SNI) :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass" 
	done
		} #PUNTO SSLH
	} || {
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m No existe SSL" | pv -qL 80
	#echo -e "\033[1;39m"
	}
	[[ $(echo -e "${_netCAT}" |awk '{print $4}' | grep -w 80 ) ]] && {
	[[ ${dmain} = null ]] && echo -e "${cor[2]} 🙍 Proxy(WS) :${cor[4]} $IP${cor[2]}:${cor[5]}80${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass" || echo -e "${cor[2]} 🙍 Proxy(WS) :${cor[4]} ${dmain}${cor[2]}:${cor[5]}80${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass"
	}
	[[ ! -z ${udpports} ]] && echo -e " ${cor[2]}🙍 SSH UDP  :${cor[4]} $IP${cor[2]}:${cor[5]}1-65535${cor[2]}@${cor[4]}$name${cor[2]}:${cor[4]}$pass"
	[[ -e /etc/adm-lite/slow/dnsi/server.pub && -e /etc/adm-lite/slow/dnsi/domain_ns ]] && {
	echo -e "${_MeDF}  SLOWDNS CONFIGS PORT $(cat /etc/adm-lite/slow/dnsi/puerto) ${_MeDF}"
	echo -e " ${cor[2]} Pub KEY :${cor[4]} $(cat /etc/adm-lite/slow/dnsi/server.pub)"
	echo -e " ${cor[2]} NameServer (NS) :${cor[4]} $(cat /etc/adm-lite/slow/dnsi/domain_ns)"
	}
	msg -bar3
 }
	[[ $1 = @(HWID|TOKEN) ]] && {
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m En APPS como HTTP Inyector, CUSTOM, etc"  #| pv -qL 15
	#echo -ne " " && msg -bra "  \033[1;41m En APPS como HTTP Inyector, CUSTOM, etc"
	[[ ! -z ${dropbearports} ]] && {
	[[ ! -z ${sslhp} ]] && { #PUNTO SSLH
	#PORT=$(cat /etc/adm-lite/sslh.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslhp}; do
	echo -e "${cor[2]} 🙍 HTTP-Direct  :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}"
	done
			} || { #PUNTO SSLH
	#echo -e "\033[1;39mPara uso Dropbear usa la Sintaxis"
	#PORT=$(cat /etc/adm-lite/dropbearports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${dropbearports}; do
	echo -e "${cor[2]} 🙍 HTTP-Direct  :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}"
	done
			} #PUNTO SSLH
	} || {
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m No existe Dropbear" | pv -qL 80
	}
	######
	
	[[ ! -z ${sslports} ]] && {
	[[ ! -z ${sslhp} ]] && {
	#PORT=$(cat /etc/adm-lite/sslh.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslhp}; do
	echo -e " ${cor[2]}🙍 SSL/TLS(SNI) :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}"
	done
				} || { #PUNTO SSLH
	#echo -e "\033[1;39mPara uso SSL usa la Sintaxis"
	#PORT=$(cat /etc/adm-lite/sslports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	for PORT in ${sslports}; do
	echo -e " ${cor[2]}🙍 SSL/TLS(SNI) :${cor[4]} $IP${cor[2]}:${cor[5]}$PORT${cor[2]}"
	done
			} #PUNTO SSLH
	} || {
	echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m No existe SSL" | pv -qL 80
	#echo -e "\033[1;39m"
	}
	[[ $(echo -e "${_netCAT}" |awk '{print $4}' | grep -w 80 ) ]] && {
	[[ ${dmain} = null ]] && echo -e " ${cor[2]}🙍 Proxy(WS) :${cor[4]} $IP${cor[2]}:${cor[5]}80${cor[2]}" || echo -e " ${cor[2]}🙍 Proxy(WS) :${cor[4]} ${dmain}${cor[2]}:${cor[5]}80${cor[2]}"
	}
	[[ ! -z ${udpports} ]] && echo -e " 🙍 SSH UDP  :${cor[4]} $IP${cor[2]}:${cor[5]}1-65535${cor[2]}"
	[[ -e /etc/adm-lite/slow/dnsi/server.pub && -e /etc/adm-lite/slow/dnsi/domain_ns ]] && {
	echo -e "${_MeDF}  SLOWDNS CONFIGS PORT $(cat /etc/adm-lite/slow/dnsi/puerto) ${_MeDF}"
	echo -e " ${cor[2]} Pub KEY :${cor[4]} $(cat /etc/adm-lite/slow/dnsi/server.pub)"
	echo -e " ${cor[2]} NameServer (NS) :${cor[4]} $(cat /etc/adm-lite/slow/dnsi/domain_ns)"
	}
	msg -bar3
	}
}

fun_ovpn_onl () {
for userovpn in `cat /etc/passwd | grep ovpn | awk -F: '{print $1}'`; do
us=$(cat /etc/openvpn/openvpn-status.log | grep $userovpn | wc -l)
if [ "$us" != "0" ]; then
echo "$userovpn"
fi
done
}

time-us () {
if [[ -z "${tempoin}" ]];then
    tempoin="30"
    tempoin=$(( $tempoin * 60 ))
    tempoin=$tempoin"s"
    echo "Default 30 minutos"
fi
tempo=$(echo "$tempoin" |sed 's/ //g')
tmm=$(echo $tempo |sed 's/[0-9]//g')
if [ "$tmm" = "s" ]; then
ext=$(echo $tempo |sed 's/[a-z]//g')
let tempo=$ext*1
tempo=$tempo"s"
#echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m"
ext=1
fi
if [ "$tmm" = "m" ]; then
ext=$(echo $tempo |sed 's/[a-z]//g')
let tempo=$ext*60
tempo=$tempo"s"
#echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m"
ext=1
fi
if [ "$tmm" = "h" ]; then   
ext=$(echo $tempo |sed 's/[a-z]//g')
    if [ "$ext" > "23" ]; then   
    ext=$(echo $tempo |sed 's/[a-z]//g')
    let tempo=$ext*3600
    tempo=$tempo"s"
    else
    let tempo=$ext*3600
    tempo=$tempo"s"
    ext=1
    fi
#echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m"
fi
if [ "$tmm" = "d" ]; then
ext=$(echo $tempo |sed 's/[a-z]//g')
let tempo=$ext*3600
tempo=$tempo"s"
#echo -ne "$(msg -verd "") $(msg -verm2 "") "&& msg -bra "\033[1;41m"
fi
}

recuva1 () {
source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/Extras/flouds.sh)
}

function criarusuarioteste(){

tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
meu_ip
[[ -d /etc/usuariosteste ]] || mkdir /etc/usuariosteste 
msg -bar3
print_center -ama " NOTA IMPORTANTE !!"
msg -bar3
print_center -verm2 " LOS USUARIOS TEMPORALES \n SOLO TENDRAN 1 DIA MAXIMO DE ACTIVIDAD"
msg -bar3
echo -e "   USUARIOS TEMPORALES CREADOS"
for testus in $(ls /etc/usuariosteste |sort |sed 's/.sh//g')
do
echo "$testus"
done
printf "\n"
echo -e "${cor[5]} Ingrese Nombre del Usuario:"; read -p "Digita : " -e -i demo-$(($RANDOM*10)) 
nome="demo-$(date | md5sum | head -c10)"
if [ -z $nome ]; then
echo -e "${cor[5]} ⚠️  ⚠️${cor[0]}"
return
fi
if cat /etc/passwd |grep $nome: |grep -vi [a-z]$nome |grep -v [0-9]$nome > /dev/null
then
echo -e "${cor[5]} ⚠️ USUARIO YA EXISTE, REGISTRE OTRO ⚠️${cor[0]}"
return
fi
msg -bar3
echo -e "${cor[5]} Contraseña para el usuario $nome"
name=$nome
pass="$(date | md5sum | head -c10)"
msg -bar3
echo -e "${cor[5]} Duración para el Usuario $nome"
echo -e "  Use s = segundos, m = minutos, h = horas e d = dias EX: 14s ."
read -p " VALIDEZ: " tempoin
echo -e "${cor[5]} LIMITE DE CONEXIONES PARA $name"
read -p " LIMITE: " limit
if [[ -z "${limit}" ]];then
    limit="5"
    echo "Default 5 Logins"
fi
msg -bar3
time-us
if [[ ${distro} = @(UBUNTU|DEBIAN) ]]; then
    if [[ ${vercion} = "16" ]]; then
      passCIFRED=$(openssl passwd -1 $pass)
    else
      passCIFRED=$(openssl passwd -6 $pass)
    fi
fi
valides=$(date '+%C%y-%m-%d' -d " +$ext days")

add_new_user "${name}" "${pass}" "2" "${limit}" "n" "n" "${pass}" &>/dev/null
#useradd -M -N -s /bin/false $nome -e $valides
#(echo $pass;echo $pass) |passwd $nome 1>/dev/null 2>/dev/null
#chage -I 1 $nome 2> /dev/null 
if [ "$OPENVPN" = "on" ]; then
open_1 $nome $pass $daysrnf $limit s
[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
echo -e "${cor[5]} PASSWD  : ${cor[4]}$pass"
echo -e "${cor[5]} LIMITE  : ${cor[4]}$limit"
echo -e "${cor[5]} VALIDEZ : ${cor[4]}$datexp"
msg -bar3
rm -f ./$CLIENT.ovpn > /dev/null
return
fi
if [ $(cat /etc/passwd | grep -w ${hwid}) ]; then
cat <<EOF > /etc/usuariosteste/${nome}.sh
#!/bin/bash
sleep ${tempo}
echo -e "$(($(cat /bin/ejecutar/uskill) + 1))" > /bin/ejecutar/uskill
rm -f $dir_user/${nome}
userdel --force ${nome}
rm -f /etc/usuariosteste/${nome}.sh
kill -9 $(ps -u $nome |awk '{print $1}')
EOF
screen -dmS ${nome} bash /etc/usuariosteste/$nome.sh
#figlet  $nome | lolcat
echo -e "${cor[5]}   * Registrar Usuario Temporal *"
echo -e "${cor[5]} * Puertas Activas en su Servidor *"
msg -bar3
ports_
msg -bar3
[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
echo -e "${cor[5]} PASSWD  : ${cor[4]}$pass"
echo -e "${cor[5]} LIMITE  : ${cor[4]}$limit"
echo -e "${cor[5]} VALIDEZ : ${cor[4]}$tempo"
msg -bar3
echo "senha: $pass" > $dir_user/$nome
echo "limite: $limit" >> $dir_user/$nome
echo "data: $valid" >> $dir_user/$nome
echo -ne "${cor[2]}"
fk 'SSH'
echo -e "               Despues de expirar !!!!"
echo -e "  Este usuario sera desconectados y eliminados."
echo -ne "${cor[2]}"
return
else
        print_center -verm2 "Error, Usuario no creado"
		msg -bar3
		sleep 3
fi
}
#USUARIO TEST DE PRUEBA
net_meter () {
net_dir="/etc/adm-lite/userDIR/usr_cnx"
if [ ! -e "$net_dir" ]; then
echo -e "${cor[5]} Verificación no está activada, o no existe información"
msg -bar3
return
fi
net_cent="/tmp/porcentagem"
sed -i '/^$/d' $net_dir
 [[ ! -e "$net_cent" ]] && touch $net_cent
 while read cent; do
  echo "$cent" | awk '{print $2}' >> $net_cent
 done < $net_dir
 por_cent=$(paste -sd+ $net_cent | bc)
 rm $net_cent
bb=$(printf '%-18s' "USO APROXIMADO")
aa=$(printf '%-19s' "USUARIOS")
cc=$(printf '%-18s' "CONSUMO TOTAL")
msg -bar3
echo -e "\033[1;33m $aa $bb $cc"
msg -bar3
while read u; do
b=$(printf '%-18s' "$(($(echo $u | awk '{print $2}')/970)) - MB")
a=$(printf '%-20s' "$(echo $u | awk '{print $1}')")
[[ "$por_cent" = "0" || "$por_cent" = "" ]] && por_cent="1"
pip=$(echo $u | awk '{print $2}')
[[ "$pip" = "" || "$pip" = "0" ]] && pip="1"
percent_user=$(($pip*100/$por_cent)) > /dev/null 2>&1
[[ $percent_user = "0" ]] && percent_user="1"
c=$(printf '%-18s' "$percent_user %%")
if [ "$(($(echo $u | awk '{print $2}')/970))" -gt "1" ]; then
echo -e "\033[1;32m $a \033[1;31m$b \033[1;32m$c"
fi
done < $net_dir
[[ "$(cat $net_dir)" = "" ]] && echo -e "${cor[5]} Verificación no está activada, o no existe información"
msg -bar3
echo -e "${cor[1]}  Controlar Consumo de Cada Usuario Por Separado ${cor[0]}"
unset net_dir
#monit_user
}

drop_kill () {
user="$1"
echo "$user $for_kill"
    for pid in `$(dropbear_pids | grep "$user" | awk '{print $2}')`; do
    kill $pid
    done
}

botusers () {
unset bot_ini
PIDGEN=$(echo -e ${_ps}|grep -v grep|grep "ultimatebot")
killall $PIDGEN > /dev/null 2>&1
if [[ ! $PIDGEN ]]; then
	msg -bar3
	echo -ne "\033[1;97m Deseas Activar el Bot Telegram [s/n]: "
	read bot_ini
	msg -bar3
[[ $bot_ini = @(s|S|y|Y) ]] && source <(curl -sSL https://www.dropbox.com/s/zvn8naajedzldno/telebot.sh.sh)
else
kill -9 $(echo -e ${_ps} | grep "ultimatebot" | grep -v grep | awk '{print $1}') > /dev/null 2>&1 && echo "BOT DETENIDO EXITOSAMENTE"
kill $(ps x | grep "telebotusr" | grep -v "grep" | awk '{print $1}')
[[ -e /etc/adm-lite/ShellBot.sh ]] && rm /etc/adm-lite/ShellBot.sh 
[[ -e /etc/adm-lite/ultimatebot ]] && rm /etc/adm-lite/ultimatebot 
[[ -e /etc/adm-lite/bot_codes ]] && rm /etc/adm-lite/bot_codes
fi
}

consul_cli () {
unset select_name namer nameFX
botusers
dir_user="/etc/adm-lite/userDIR"
msg -bar3  
select_users 'CONSULTA DATOS DE CLIENTE INDIVIDUAL'
if [ "$select_name" = "" ]; then
return
fi
namer="$select_name"
[[ $(cat /etc/adm-lite/userDIR/$namer | grep "limite" | awk '{print $2}') = "HWID" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
[[ $(cat /etc/adm-lite/userDIR/$namer | grep "limite" | awk '{print $2}') = "TOKEN" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
echo -e "${cor[5]} Que opción va a editar de: $namer"
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m >${cor[3]} Consultar estado de Usuario: $nameFX"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m >${cor[3]} Reiniciar Usuario: $nameFX"
msg -bar3
read -p " ESCOJE: " _opt
if [ "$_opt" = "1" ]; then
unset limite
#data=$(cat /etc/adm-lite/userDIR/${namer} | grep "data" | awk '{print $2}')
data_sec=$(date +%s)
data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
data_user_sec=$(date +%s --date="$data_user")
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400))
if [ -z "$limite" ]; then
limite="null"
fi
if [ "$dias_use" -le 0 ]; then 
echo -e " ✭ Eiii, Malas Noticias ☹!!\n Usuario : $nameFX. Esta Caducado ☹ \n!! Contacta Cliente, Para Renobar su Membresia\n"  | pv -qL 80
echo -e "${cor[5]} Usuario $nameFX: VENCIDO EL: $data_user"
pkill -u $namer
else
limite=$(cat /etc/adm-lite/userDIR/${namer} | grep "limite" | awk '{print $2}')
date="$dias_use"
datexp=$(date "+%d/%m/%Y" -d " + $date days")
valid=$(date '+%C%y-%m-%d' -d " + $date days")
echo -e " ✭ SU CLIENTE : $namer, ES VALIDO HASTA -> $data_user ☺"
echo -e " ✭ CON 【 $limite 】 CONEXIONES SIMULTANEAS!!. "
echo -e "${cor[5]}  RENUEVA EN $dias_use DIAS, DISFRUTE SU ESTANCIA!. "
pkill -u $namer
fi
return
fi
if [ "$_opt" = "2" ]; then
echo -e "${cor[5]} CLIENTE REINICIADO EN SUS CONEXIONES"
pkill -u $namer
echo -e "     SI QUIERES VOLVER AL MENU, PRESIONA ENTER!."
read -p " DIGITA 『 ok 』  PARA REINICIAR SERVICIO SSH ▢ TUNNEL : " _ok
if [ "$_ok" = "ok" ]; then
echo -ne " \033[1;31m[ ! ] Services dropbear restart"
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] Services SSH & STUNNEL4 restart"
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
service stunnel4 restart > /dev/null 2>&1
echo "SERVICIOS REINICIADOS EXITOSAMENTE "  | pv -qL 50
fi
return
fi


}

fun_time_user () {
declare -A data
usr_pids_var="./userDIR"
user_x="$1"
if [ -e $usr_pids_var/$user_x.pid2 ]; then
source $usr_pids_var/$user_x.pid2
[[ ${data[$user_x]} != +([0-9]) ]] && data[$user_x]="0"
_data_now=$(date +%s)
time[$user_x]=$((${_data_now} - ${data[$user_x]}))
else
time[$user_x]="0"
fi
}

fun_us() {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e " \033[0;50m       ⚜️   CREADOR DE CUENTAS TIPO  ⚜️ "
msg -bar3
echo -e " \033[0;35m[\033[0;32m01\033[0;35m] \033[0;33m >\033[0;33m SSH|DROPBEAR (DEMO) "
echo -e " \033[0;35m[\033[0;32m02\033[0;35m] \033[0;33m >\033[0;33m SSH|DROPBEAR "
echo -e " \033[0;35m[\033[0;32m03\033[0;35m] \033[0;33m >\033[0;33m HWID         "
echo -e " \033[0;35m[\033[0;32m04\033[0;35m] \033[0;33m >\033[0;31m TOKEN "
msg -bar3
echo -e " \033[0;35m[\033[0;32m05\033[0;35m] \033[0;33m >\033[0;31m MODIFICAR CONTRASEÑA TOKEN "
msg -bar3
echo -e " \033[0;35m[\033[1;32m00\033[0;35m] \033[0;33m ⇦ $(msg -bra "\e[3;33m[ VOLVER ]\e[0m")"
msg -bar3
selection=$(selection_fun 6)
case ${selection} in
0|00)
return 
;;
1|01)
cd /etc/adm-lite/ && criarusuarioteste
;;
2|02)
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
function_1
;;
3|03)
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
fun_us_hwid
;;
4|04)
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
fun_us_tk
;;
5)
[[ ! -e /bin/ejecutar/token ]] && touch /bin/ejecutar/token
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -e "${cor[5]} ⚠️ CLAVE ACTUAL : $(cat < /bin/ejecutar/token) ⚠️${cor[0]}"
msg -bar3
echo -e "${cor[5]} ⚠️ ATENCION ANTES DE CONTINUAR ⚠️${cor[0]}"
echo -e ""
echo -e "   SE DEFINIRA SU CONTRASEÑA TOKEN UNICA"
echo -e " UNA VEZ COLOCADA SE RECOMIENDA NO CAMBIARLA"
echo ""
msg -bar3
echo -ne "${cor[5]} ⎚ CONTRASEÑA "; read -p "TOKEN : " passtok
echo ${passtok} > /bin/ejecutar/token
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
;;
esac
}

fun_us_hwid(){
[[ ! -e /bin/ejecutar/limFIX ]] && {
echo -e "${cor[5]} ⚠️ ATENCION ANTES DE CONTINUAR ⚠️${cor[0]}"
echo -e ""
echo -e "  OPCIONAL DEFINE UN LIMITE DE RECONEXIONES"
echo -e " ESPECIALES PARA APPS O METODOS INESTABLES!!"
echo -e " SINO ENTIENDES LA FUNCION, PRESIONA ENTER!!"
echo ""
msg -bar3
echo -ne "${cor[5]} ⎚ DEFINE TU "
read -p " LIMITE : "  -e -i "1" _limTP
[[ -z ${_limTP} ]] && _limTP='2'
echo ${_limTP} > /bin/ejecutar/limFIX
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
}
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -ne "${cor[5]} ⎚ NOMBRE DE"; read -p " USUARIO : " name
tput cuu1 && tput dl1
[[ -z $name ]] && echo -e "${cor[5]} ⚠️ NO REGISTRO NOMBRE, RETORNANDO ⚠️${cor[0]}" && return 
msg -bar3
echo -e "${cor[5]} INGRESA HWID PARA $name"
read -p " HWID: " hwid
if cat /etc/passwd |grep $hwid: |grep -vi [a-z]$hwid |grep -v [0-9]$hwid > /dev/null
then
echo -e "${cor[5]} ⚠️ HWID YA EXISTE, REGISTRE OTRO ⚠️${cor[0]}"
return
fi
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ -z "${hwid}" ]] && echo " ⚠️ No se Ingreso HWID , RETORNANDO! ⚠️" && return
msg -bar3
echo -e "${cor[5]} TIEMPO DE DURACION EN DIAS PARA $name"
read -p " VALIDEZ : " daysrnf
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ -z "${daysrnf}" ]] && daysrnf="2"
msg -bar3
meu_ip
[[ $(dpkg --get-selections|grep -w "openvpn"|head -1) ]] && [[ -e /etc/openvpn/openvpn-status.log ]] && {

    while [[ ${newfile} != @(s|S|y|Y|n|N) ]]; do
      msg -ne "Crear Archivo OpenVPN? [S/N]: "
      read -e -i S newfile
    done

    if [[ ${newfile} = @(s|S) ]]; then
      while [[ ${ovpnauth} != @(s|S|y|Y|n|N) ]]; do
        msg -ne "Autenticacion de usuario en el archivo? [S/N]: "
        read -e -i S ovpnauth
      done
    fi
}
valid=$(date '+%C%y-%m-%d' -d " +$daysrnf days")
datexp=$(date "+%d/%m/%Y" -d " +$daysrnf days")
#useradd -M -s /bin/false $hwid -e $valid
#(echo $hwid; echo $hwid)|passwd $hwid 2>/dev/null
[[ -z ${newfile} ]] && newfile='n'
[[ -z ${ovpnauth} ]] && ovpnauth='n'
local d_reg=$(( daysrnf + 1 ))
add_new_user "${hwid}" "${hwid}" "${d_reg}" "HWID" "${newfile}" "${ovpnauth}" "$name" &>/dev/null
if [ $(cat /etc/passwd | grep -w ${hwid}) ]; then
		start_animation; sleep 1; stop_animation; echo
		tput cuu1 >&2 && tput dl1 >&2
		echo -e "${cor[5]} * Puertas Activas en su Servidor *"
		msg -bar3
		ports_
		msg -bar3
		[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
		echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
		echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
		echo -e "${cor[5]} HWID    : ${cor[4]}$hwid"
		echo -e "${cor[5]} VALIDEZ : ${cor[4]}$datexp"
	    if [[ $newfile = @(s|S) ]]; then
			newclient ${hwid}
			[[ $ovpnauth = @(s|S) ]] && sed -i "s;auth-user-pass;<auth-user-pass>\n${hwid}\n${hwid}\n</auth-user-pass>;g" ~/${name}.ovpn
			cd $HOME
			zip ./$name.zip ./$name.ovpn > /dev/null 2>&1
			rm ./$name.ovpn > /dev/null 2>&1
			zip_ovpn="$HOME/$name.zip"
			echo -e "\033[1;31m Archivo generado en: (${zip_ovpn})"
			echo -e "\033[1;32m ALOJAR ONLINE ( * menu * opcion 5 * opcion 25 )"
		fi
		msg -bar3
		echo "senha: $name" > /etc/adm-lite/userDIR/${hwid}
		echo "limite: HWID" >> /etc/adm-lite/userDIR/${hwid}
		echo "data: $valid" >> /etc/adm-lite/userDIR/${hwid}
		fk 'HWID'
		msg -bar3
else
        print_center -verm2 "Error, Usuario no creado"
		msg -bar3
		sleep 3
fi
#figlet  $name | lolcat
}

fun_us_tk(){
[[ ! -e /bin/ejecutar/token ]] && {
echo -e "${cor[5]} ⚠️ ATENCION ANTES DE CONTINUAR ⚠️${cor[0]}"
echo -e ""
echo -e "  SE DEFINIRA SU CONTRASEÑA TOKEN UNICA"
echo -e " UNA VEZ COLOCADA NO PODRA SER MANIPULADA"
echo ""
msg -bar3
echo -ne "${cor[5]} ⎚ CONTRASEÑA "; read -p "TOKEN : " passtok
echo ${passtok} > /bin/ejecutar/token
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
}

[[ ! -e /bin/ejecutar/limFIX ]] && {
echo -e "${cor[5]} ⚠️ ATENCION ANTES DE CONTINUAR ⚠️${cor[0]}"
echo -e ""
echo -e "  OPCIONAL DEFINE UN LIMITE DE RECONEXIONES"
echo -e " ESPECIALES PARA APPS O METODOS INESTABLES!!"
echo -e " SINO ENTIENDES LA FUNCION, PRESIONA ENTER!!"
echo ""
msg -bar3
echo -ne "${cor[5]} ⎚ DEFINE TU "
read -p " LIMITE : "  -e -i "1" _limTP
echo ${_limTP} > /bin/ejecutar/limFIX
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
}

tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -ne "${cor[5]} ⎚ NOMBRE DE"; read -p " USUARIO : " name
tput cuu1 && tput dl1
[[ -z $name ]] && echo -e "${cor[5]} ⚠️ NO REGISTRO NOMBRE, RETORNANDO ⚠️${cor[0]}" && return 
msg -bar3
echo -e "${cor[5]} INGRESA TOKEN PARA $name"
read -p " TOKEN: " hwid
if cat /etc/passwd |grep $hwid: |grep -vi [a-z]$hwid |grep -v [0-9]$hwid > /dev/null
then
echo -e "${cor[5]} ⚠️ TOKEN YA EXISTE, REGISTRE OTRO ⚠️${cor[0]}"
return
fi
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ -z "${hwid}" ]] && echo " ⚠️ No se Ingreso TOKEN , RETORNANDO! ⚠️" && return
msg -bar3
echo -e "${cor[5]} TIEMPO DE DURACION EN DIAS PARA $name"
read -p " VALIDEZ : " daysrnf
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ -z "${daysrnf}" ]] && daysrnf="2"
msg -bar3
meu_ip
valid=$(date '+%C%y-%m-%d' -d " +$daysrnf days")
datexp=$(date "+%d/%m/%Y" -d " +$daysrnf days")
[[ -e /bin/ejecutar/token ]] && passTOKEN=$(less /bin/ejecutar/token) || passTOKEN="ChumoGHPlus"
#if useradd -M -s /bin/false $hwid -e $valid ; then
#(echo $passTOKEN; echo $passTOKEN)|passwd $hwid 2>/dev/null
[[ -z ${newfile} ]] && newfile='n'
[[ -z ${ovpnauth} ]] && ovpnauth='n'
local d_reg=$(( daysrnf + 1 ))
add_new_user "${hwid}" "${passTOKEN}" "${d_reg}" "TOKEN" "${newfile}" "${ovpnauth}" "$name" &>/dev/null
if [ $(cat /etc/passwd | grep -w ${hwid}) ]; then
		start_animation; sleep 2; stop_animation; echo
		tput cuu1 >&2 && tput dl1 >&2
		echo -e "${cor[5]} * Puertas Activas en su Servidor *"
		msg -bar3
		ports_
		msg -bar3
		[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
		echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
		echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
		echo -e "${cor[5]} TOKEN    : ${cor[4]}$hwid"
		echo -e "${cor[5]} VALIDEZ : ${cor[4]}$datexp"
	    if [[ $newfile = @(s|S) ]]; then
			newclient ${hwid}
			[[ $ovpnauth = @(s|S) ]] && sed -i "s;auth-user-pass;<auth-user-pass>\n${hwid}\n${passTOKEN}\n</auth-user-pass>;g" ~/${name}.ovpn
			cd $HOME
			zip ./$name.zip ./$name.ovpn > /dev/null 2>&1
			rm ./$name.ovpn > /dev/null 2>&1
			zip_ovpn="$HOME/$name.zip"
			echo -e "\033[1;31m Archivo generado en: (${zip_ovpn})"
			echo -e "\033[1;32m ALOJAR ONLINE ( * menu * opcion 5 * opcion 25 )"
		fi
		msg -bar3
		echo "senha: $name" > /etc/adm-lite/userDIR/${hwid}
		echo "limite: TOKEN" >> /etc/adm-lite/userDIR/${hwid}
		echo "data: $valid" >> /etc/adm-lite/userDIR/${hwid}
		fk 'TOKEN'
		msg -bar3
else
        echo -e "${cor[5]} ⚠️ ERROR AL REGISTRAR SU TOKEN | REINTENTE ⚠️${cor[0]}"
		msg -bar3
		sleep 3
fi
}

function_1 () {
echo -e "${cor[4]} ❑ MENU DE CREACION DE USUARIOS ❒ "
msg -bar3
echo -ne "${cor[5]} > NOMBRE DE"; read -p " USUARIO : " name
tput cuu1 && tput dl1
tput cuu1 && tput dl1
if [ -z $name ]; then
echo -e "${cor[5]} ⚠️ NO REGISTRO NOMBRE, RETORNANDO ⚠️${cor[0]}" 
return
fi
if cat /etc/passwd |grep $name: |grep -vi [a-z]$name |grep -v [0-9]$name > /dev/null
then
echo -e "${cor[5]} ⚠️ USUARIO YA EXISTE, USE OTRO NOMBRE ⚠️${cor[0]}"
return
fi
msg -bar3
echo -e "${cor[5]} CONTRASEÑA PARA $name"
read -p " CONTRASEÑA : " pass
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
if [[ -f "${pass}" ]];then
	pass="$(date | md5sum | head -c10)"
fi
msg -bar3
echo -e "${cor[5]} TIEMPO DE DURACION EN DIAS PARA $name"
read -p " VALIDEZ : " daysrnf
daysrnf=$(echo -e "$daysrnf" |sed -e 's/[^0-9]//ig')
number_var $daysrnf
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
if [[ -f "${daysrnf}" ]];then
	daysrnf="2"
fi
msg -bar3
echo -e "${cor[5]} LIMITE DE CONEXIONES PARA $name"
read -p " LIMITE : " limit
limit=$(echo -e "$limit" |sed -e 's/[^0-9]//ig')
number_var $limit
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
if [[ -f "${limit}" ]];then
	limit="1"
fi
msg -bar3
meu_ip
#if [ "$OPENVPN" = "on" ]; then
#open_1 $name $pass $daysrnf $limit s
#msg -bar3
#ports_
#msg -bar3
#[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
#echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
#echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
#echo -e "${cor[5]} PASSWD  : ${cor[4]}$pass"
#echo -e "${cor[5]} LIMITE  : ${cor[4]}$limit"
#echo -e "${cor[5]} VALIDEZ : ${cor[4]}$datexp"
#msg -bar3
#fk
#rm -rf ./$CLIENT.ovpn > /dev/null 2>&1
#rm -f ./$CLIENT.ovpn > /dev/null 2>&1
#msg -bar3
#return
#fi

[[ $(dpkg --get-selections|grep -w "openvpn"|head -1) ]] && [[ -e /etc/openvpn/openvpn-status.log ]] && {

    while [[ ${newfile} != @(s|S|y|Y|n|N) ]]; do
      msg -ne "Crear Archivo OpenVPN? [S/N]: "
      read -e -i S newfile
    done

    if [[ ${newfile} = @(s|S) ]]; then
      while [[ ${ovpnauth} != @(s|S|y|Y|n|N) ]]; do
        msg -ne "Autenticacion de usuario en el archivo? [S/N]: "
        read -e -i S ovpnauth
      done
    fi
}
valid=$(date '+%C%y-%m-%d' -d " +$daysrnf days")
datexp=$(date "+%d/%m/%Y" -d " +$daysrnf days")
[[ -z ${newfile} ]] && newfile='n'
[[ -z ${ovpnauth} ]] && ovpnauth='n'
local d_reg=$(( daysrnf + 1 ))
add_new_user "${name}" "${pass}" "${d_reg}" "${limit}" "${newfile}" "${ovpnauth}" "${pass}" &>/dev/null
#if [ $? = 1 ]; then
if [ $(cat /etc/passwd | grep -w ${name}) ]; then
        start_animation; sleep 1; stop_animation; echo
		tput cuu1 >&2 && tput dl1 >&2
		figlet  $name | lolcat
		echo -e "${cor[5]} * Puertas Activas en su Servidor *"
		msg -bar3
		ports_
		msg -bar3
		[[ -z ${dmain} ]] || echo -e "${cor[5]} DOMAIN  : ${cor[4]}${dmain}"
		echo -e "${cor[5]} Host/IP-Address : ${cor[4]}$IP"
		echo -e "${cor[5]} USUARIO : ${cor[4]}$name"
		echo -e "${cor[5]} PASSWD  : ${cor[4]}$pass"
		echo -e "${cor[5]} LIMITE  : ${cor[4]}$limit"
		echo -e "${cor[5]} VALIDEZ : ${cor[4]}$datexp"
		if [[ $newfile = @(s|S) ]]; then
			newclient ${name}
			[[ $ovpnauth = @(s|S) ]] && sed -i "s;auth-user-pass;<auth-user-pass>\n${name}\n${pass}\n</auth-user-pass>;g" ~/${name}.ovpn
			cd $HOME
			zip ./$name.zip ./$name.ovpn > /dev/null 2>&1
			rm ./$name.ovpn > /dev/null 2>&1
			zip_ovpn="$HOME/$name.zip"
			echo -e "\033[1;31m Archivo generado en: (${zip_ovpn})"
			echo -e "\033[1;32m ALOJAR ONLINE ( * menu * opcion 5 * opcion 25 )"
		fi
		msg -bar3
		echo "senha: $pass" > /etc/adm-lite/userDIR/${name}
		echo "limite: $limit" >> /etc/adm-lite/userDIR/${name}
		echo "data: $valid" >> /etc/adm-lite/userDIR/${name}
		fk 'SSH'
else
        print_center -verm2 "Error, Usuario no creado"
		msg -bar3
		sleep 3
fi
[[ -e /etc/v2ray/config.json ]] && {
echo -e "\033[1;41m DESEAS AÑADIR EL USUARIO EN VMESS ?\033[0;33m :v"
echo -ne "\033[0;32m "
read -p " Responde [ s | n ] : " -e -i "n" x
tput cuu1 >&2 && tput dl1 >&2
tput cuu1 >&2 && tput dl1 >&2
[[ $x = @(s|S|y|Y) ]] && source <(curl -sSL https://www.dropbox.com/s/z6txyjygpri7ede/adduser.sh) $name $daysrnf
msg -bar3
}
echo -ne "${cor[2]}"
return
}

function_2 () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e "${cor[4]} ELIMINAR USUARIOS"
msg -bar3
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m >${cor[3]} 1 USER"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m >${cor[3]} TODOS \033[0;33m(ITERATIVO 1x1) \033[0;32m[RECOMENDADO]  "
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m >${cor[3]} SOLO CADUCADOS"
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;33m >${cor[3]} TODOS \033[0;33m(SIN PREGUNTAR) \033[0;31m[NO RECOMENDADO] "
msg -bar3
local selection=$(selection_fun 4)
case ${selection} in
0)
return
;;
1)
unset select_name namer nameFX
select_users 'USUARIOS REGISTRADOS'
name="$select_name"
[[ -z $name ]] && return
local _limit="$(cat /etc/passwd | grep -w ${name} | awk -F ':' '{split($5, a, ","); print a[1]}')"
[[ ${_limit} = @(HWID|TOKEN) ]] && nameFX="$(cat /etc/adm-lite/userDIR/$name | grep "senha" | awk '{print $2}')" || nameFX=$name
[[ "$OPENVPN" = "on" ]] && open_2 $name && msg -bar3 && return 
userdel --force $name > /dev/null 2>/dev/null
kill -9 `ps aux |grep -vi '[a-z]$name' |grep -vi '$name[a-z]' |grep -v '[1-9]$name' |grep -v '$name[1-9]' |grep $name |awk {'print $2'}` 2> /dev/null
pid_kill=$(dropbear_pids | grep "$name" | awk '{print $2}')
uskk=$(cat /bin/ejecutar/uskill)
let uskk=$uskk+$cco
echo $uskk > /bin/ejecutar/uskill
[[ ! -z $pid_kill ]] && drop_kill $name
[[ -e /etc/usuariosteste/$name ]] && rm /etc/usuariosteste/$name && msg -bar3
echo -e " $nameFX ${cor[2]} ELIMINADO "
msg -bar3
return
;;
2)
for name in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1 |sort`; do
msg -bar3  
echo -e "${cor[5]} ELIMINAR A $name ?"
read -p " [S/N]: " _remover_
if [[ "$_remover_" = "s" || "$_remover_" = "S" ]]; then
 if [ "$OPENVPN" = "on" ]; then
open_2 $name
 else
userdel --force $name > /dev/null 2>&1
kill -9 `ps aux |grep -vi '[a-z]$name' |grep -vi '$name[a-z]' |grep -v '[1-9]$name' |grep -v '$name[1-9]' |grep $name |awk {'print $2'}`  > /dev/null 2>&1
pid_kill=$(dropbear_pids | grep "$name" | awk '{print $2}')
uskk=$(cat /bin/ejecutar/uskill)
let uskk=$uskk+$cco
echo $uskk > /bin/ejecutar/uskill
[[ ! -z $pid_kill ]] && drop_kill $name
[[ -e /etc/adm-lite/userDIR/${name} ]] && rm /etc/adm-lite/userDIR/${name}
echo -e "\033[1;37m $name ${cor[5]} ELIMINADO"
fi
fi
done
msg -bar3
;;
3)
function_6
msg -bar3
return
;;
4)
for name in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1 |sort`; do
msg -bar3  
if [ "$OPENVPN" = "on" ]; then
open_2 $name
 else
userdel --force $name > /dev/null 2>&1
kill -9 `ps aux |grep -vi '[a-z]$name' |grep -vi '$name[a-z]' |grep -v '[1-9]$name' |grep -v '$name[1-9]' |grep $name |awk {'print $2'}`  > /dev/null 2>&1
pid_kill=$(dropbear_pids | grep "$name" | awk '{print $2}')
uskk=$(cat /bin/ejecutar/uskill)
let uskk=$uskk+$cco
echo $uskk > /bin/ejecutar/uskill
[[ ! -z $pid_kill ]] && drop_kill $name
[[ -e /etc/adm-lite/userDIR/${name} ]] && rm /etc/adm-lite/userDIR/${name}
echo -e "\033[1;37m $name ${cor[5]} ELIMINADO"
fi
done
msg -bar3
;;
esac
}

renew_USER (){
local _user=$1
local tiempo=$2
local limite=$(cat $dir_user/${_user} | grep "limite" | awk '{print $2}')
if [ -z "$limite" ]; then
limite="null"
fi
clear&&clear
msg -bar3
#datexp=$(date "+%d/%m/%Y" -d " + $date days")
  if [[ $(passwd --status ${_user}|cut -d ' ' -f2) = "L" ]]; then
  	usermod -U ${_user}
  	start_animation; sleep 2; stop_animation; echo
	tput cuu1 >&2 && tput dl1 >&2
  	msg -verd " ⚠️ UNLOCK ⚠️ "
  fi
#datexp=$(date "+%F" -d " + ${tiempo} days") && valid=$(date '+%C%y-%m-%d' -d " + ${tiempo} days")
local datexp=$(date "+%d/%m/%Y" -d " + $date days")
local valid=$(date '+%C%y-%m-%d' -d " + ${tiempo} days")
  if chage -E ${valid} ${_user} ; then
  	echo -e "\033[0;32m       ACTUALIZACION EXITOSA ! ! !"
	local usr_var=$(cat $dir_user/${_user} | grep -v "data")
	echo -e "${usr_var}" > $dir_user/${_user}
	echo -e "data: $valid" >> $dir_user/${_user}
	msg -bar3
	echo -e " ✭ PERFECTO, ACTUALIZAMOS TU MEMBRESIA!! ✭ "
	msg -bar3
	echo -e " ${cor[5]}RENOVADO EL  : ${cor[4]}$(date "+%d/%m/%Y") "
	echo -e " ${cor[5]}Host / IP    : ${cor[4]}$IP"
	echo -e " ${cor[5]}ID/CLIENTE   : ${cor[4]}${select_user} / $nameFX " 
	echo -e " ${cor[5]}📱 PERMITIDOS : ${cor[4]}$limite "
	echo -e " ${cor[5]}VALIDO HASTA : ${cor[4]}$datexp"
	echo -e "${cor[1]} RENUEVA EN $(($date + 1 )) DIAS, DISFRUTE SU ESTANCIA!. "
	pkill -u ${_user}
	msg -bar3
  else
	msg -verm " ⚠️ FAIL, Usuario no Renovado ⚠️ "
	msg -bar3
  fi

}

function_3 () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e "${cor[4]} "
msg -bar3
unset select_name namer nameFX
select_users 'MODIFICAR DATOS DE USUARIOS'
if [ "$select_name" = "" ]; then
return
fi
namer="$select_name"
local _limit="$(cat /etc/passwd | grep -w ${namer} | awk -F ':' '{split($5, a, ","); print a[1]}')"
[[ ${_limit} = @(HWID|TOKEN) ]] && nameFX="$(cat /etc/adm-lite/userDIR/$namer | grep "senha" | awk '{print $2}')" || nameFX=$namer
#[[ $(cat /etc/adm-lite/userDIR/$namer | grep "limite" | awk '{print $2}') = "TOKEN" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
meu_ip
echo -e "${cor[5]} ESCOJE LA OPCION A CAMBIAR DE $namer"
msg -bar3
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m >${cor[3]} LIMITADOR DEL CLIENTE \033[0;36m$nameFX"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m >${cor[3]} RENOVAR CLIENTE \033[0;36m$nameFX"
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m >${cor[3]} CLAVE DEL CLIENTE \033[0;36m$nameFX"
msg -bar3
read -p " SELECCIONA UNA OPC : " _opt
# RENUEVA LIMITE DE CONEXIONES #
[[ "$_opt" = "1" ]] && {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
read -p " NUEVO LIMITE DE CONEXIONES : " new_limit
number_var $new_limit
tput cuu1 && tput dl1
 if [ "$new_limit" = "" ]; then
echo -e "${cor[5]} \033[1;31m NO SE REGISTRO LIMITE! REGRESANDO. . ."
return
 fi
if usermod -c $new_limit $namer ; then
usr_var=$(cat /etc/adm-lite/userDIR/${name}r | grep -v "limite:")
echo "$usr_var" > /etc/adm-lite/userDIR/${name}r
echo "limite: $new_limit" >> /etc/adm-lite/userDIR/${name}r
msg -bar3
echo -e "${cor[5]} $select_user - $select_name"
echo -e " ✭ Perfecto, HEMOS CAMBIADO SU LIMITE DE CONEXIONES!! ✭ "
echo -e " RENOVADO EL  : $(date "+%d/%m/%Y") "
echo -e " Host / IP    : ${cor[4]}$IP"
echo -e " SU CLIENTE   : $nameFX " 
echo -e " NUEVO LIMITE : $new_limit " 
pkill -u $nameFX
msg -bar3
unset new_limit
unset usr_var
fi
return
}
# RENUEVA TIEMPO DE CADUCIDAD #
[[ "$_opt" = "2" ]] && {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
add_dias() {
echo -ne "${cor[5]} NUMEROS DE DIAS A AGREGAR"
read -p " : " date
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
 if [ "$date" = "" ]; then
echo -e "\033[1;31m ⚠️ NO SE REGISTRO DIAS! REGRESANDO ⚠️"
return
 fi
data_sec=$(date +%s) 
data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
data_user_sec=$(date +%s --date="$data_user")
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400)) 
#echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
[[ $dias_use -ge 0 ]] && {
date=$(($dias_use + $date))
echo -e "\033[1;32m $dias_use DIAS RECUPERADOS &&"
tput cuu1 && tput dl1
} || {
#[[ $dias_use < 0 ]] && dias_use=0
echo -e "\033[1;31m $dias_use DIAS RECUPERADOS &&"
tput cuu1 && tput dl1
}
renew_USER ${namer} ${date}
return
}

del_dias() {
echo -ne "${cor[5]} NUMEROS DE DIAS A QUITAR"
read -p " : " date
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
 if [ "$date" = "" ]; then
echo -e "\033[1;31m ⚠️ NO SE REGISTRO DIAS! REGRESANDO ⚠️"
return
 fi
data=$(cat /etc/adm-lite/userDIR/${name}r | grep "data" | awk '{print $2}')
data_sec=$(date +%s) 
data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
data_user_sec=$(date +%s --date="$data_user")
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400)) 
[[ $dias_use -ge 0 ]] && {
date=$(($dias_use - $date))
echo -e "\033[1;32m $dias_use DIAS RECUPERADOS &&"
tput cuu1 && tput dl1
} || {
echo -e "\033[1;31m $dias_use DIAS RECUPERADOS &&"
tput cuu1 && tput dl1
}
renew_USER ${namer} ${date}
return
}

ren_dias() {
echo -ne "${cor[5]} NUMEROS DE DIAS "
read -p " : " date
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
 if [ "$date" = "" ]; then
echo -e "\033[1;31m ⚠️ NO SE REGISTRO DIAS! REGRESANDO ⚠️"
return
 fi
renew_USER ${namer} ${date}
return
}

echo -e "${cor[5]} ESCOJE LA OPCION A CAMBIAR DE $nameFX"
msg -bar
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m >${cor[3]} AÑADIR DIAS A \033[0;36m$nameFX"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m >${cor[3]} QUITAR DIAS A \033[0;36m$nameFX"
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m >${cor[3]} REINICIAR DIAS A \033[0;36m$nameFX"
msg -bar
read -p " OPCION " _ropt
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ $_ropt = "1" ]] && add_dias
[[ $_ropt = "2" ]] && del_dias
[[ $_ropt = "3" ]] && ren_dias
return 
}

[[ "$_opt" = "3" ]] && {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
echo -e "${cor[5]} NUEVA CONTRASEÑA PARA $nameFX"
read -p " : " nova_senha
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ "$nova_senha" = "" ]] && echo -e "${cor[5]}❌ CONTRASEÑA NO MODIFICADA ❌" && return
limiteuser=$(cat /etc/passwd | grep -w ${namer} | awk -F ':' '{split($5, a, ","); print a[1]}')
[[ -z $limiteuser ]] && limiteuser='2'
#limiteuser=$(cat /etc/adm-lite/userDIR/${name}r | grep "limite" | awk '{print $2}')
local data_sec=$(date +%s)
local data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
local data_user_sec=$(date +%s --date="$data_user")
local variavel_soma=$(($data_user_sec - $data_sec))
local dias_use=$(($variavel_soma / 86400))
local dias_user=$(($dias_use + 1 ))
local datexp=$(date "+%d/%m/%Y" -d " + $date days")
local valid=$(date '+%C%y-%m-%d' -d " + ${tiempo} days")
datexp=$(date "+%F" -d " + $dias_user days") && valid=$(date '+%C%y-%m-%d' -d " + $dias_user days")
if usermod -p $(openssl passwd -6 $nova_senha) -e $valid -c $limiteuser,$nova_senha $namer ; then
echo -e "$usr_var1" > /etc/adm-lite/userDIR/${name}r
echo -e "senha: $nova_senha" >> /etc/adm-lite/userDIR/${name}r
[[ -e /etc/adm-lite/userDIR/$namer.exp ]] && rm -f /etc/adm-lite/userDIR/$namer.exp
msg -bar3
echo -e "${cor[5]} $select_user - $select_name"
echo -e " ✭ Perfecto, HEMOS CAMBIADO SU CONTRASEÑA!! ✭ "
echo -e " RENOVADO EL  : $(date "+%d/%m/%Y") "
echo -e " Host / IP    : ${cor[4]}$IP"
echo -e " SU CLIENTE   : $nameFX " 
echo -e " NUEVA CLAVE  : $nova_senha " 
pkill -u $namer
msg -bar3
unset nova_senha
unset usr_var1
else
  	echo -e "${cor[5]}❌ CONTRASEÑA NO MODIFICADA ❌"
  	return
fi
return
}
[[ -z $_opt ]] && echo "⚠️ SIN SELECCION ⚠️"
}

block_user () {

tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
#msg -bar3  
echo -e "${cor[4]} LOCK / UNLOCK USUARIO PRIVADO "
msg -bar3  
unset select_name namer nameFX
select_users 'LOCK / UNLOCK USUARIO PRIVADO'
[[ -z $select_name ]] && return
namer="$select_name"
local lmt="$(cat /etc/passwd | grep -w ${namer} | awk -F ':' '{split($5, a, ","); print a[1]}')"
[[ $(echo $lmt) = "HWID" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
[[ $(echo $lmt) = "TOKEN" ]] && nameFX="$(cat /etc/adm-lite/userDIR/$u | grep "senha" | awk '{print $2}')" || nameFX=$namer
echo -e "${cor[5]} VERIFICANDO ESTADO DE $nameFX "
msg -bar3
########
  if [[ $(passwd --status $namer|cut -d ' ' -f2) = "P" ]]; then
    echo -e "${cor[5]}Bloqueando USER "
    pkill -u $namer &>/dev/null
    droplim=`dropbear_pids|grep -w "$namer"|awk '{print $2}'` 
    kill -9 $droplim &>/dev/null
    usermod -L $namer &>/dev/null
    start_animation; sleep 2; stop_animation; echo
	tput cuu1 >&2 && tput dl1 >&2
    msg -verm2 "  ⚠️ LOCK ⚠️"
  else
  	usermod -U $namer
  	start_animation; sleep 2; stop_animation; echo
	tput cuu1 >&2 && tput dl1 >&2
  	msg -verd " ⚠️ UNLOCK ⚠️ "
  fi
pkill -u $namer
kill -9 `ps aux |grep -vi '[a-z]$namer' |grep -vi '$namer[a-z]' |grep -v '[1-9]$namer' |grep -v '$namer[1-9]' |grep $namer |awk {'print $2'}` 2> /dev/null
return
}

function_4 () {

tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e "${cor[4]}  >  USUARIO     CONTRASEÑA     LIMITE     CADUCA        DIAS"
msg -bar3
_cont="0"
for namer in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1`; do
if [ "$namer" = "" ]; then
break
fi
#if [ -e /etc/adm-lite/userDIR/${name}r ]; then
local linea=$(cat /etc/passwd | grep -w ${namer})
if [[ "${linea}" =~ ,([^:]+): ]]; then
        _sen="${BASH_REMATCH[1]}"
fi
_limit="$(cat /etc/passwd | grep -w ${namer} | awk -F ':' '{split($5, a, ","); print a[1]}')"
#else
#_limit="∞"
#_sen="∞"
#fi
#[[ -z "$_limit" ]] && _limit="⚠️ ?? ⚠️"
#[[ -z "$_sen" ]] && _sen="⚠️ ?? ⚠️"
data_sec=$(date +%s)
data_user=$(chage -l "$namer" |grep -i co |awk -F ":" '{print $2}')
[[ ${data_user} = " nunca" ]] && {
dias_user="\033[1;37mINDEFINIDO"
 }||{
data_user_sec=$(date +%s --date="$data_user")
[[ ${data_sec} -gt ${data_user_sec} ]] && {
dias_user="\033[1;31mEXP"
} || {
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400))
dias_user="\033[1;32m$dias_use"
 }
}
unset SEC
unset MIN
unset HOR
#SEC=$(cat $namer.time | grep "$namer" | awk '{print $2}')
#[[ -e /etc/adm-lite/userDIR/$namer.time ]] && SEC=$(cat /etc/adm-lite/userDIR/$namer.time) || SEC="0"
#number_var $SEC
#if [ "$var_number" = "" ]; then
#SEC="0"
# else
#SEC="$var_number"
#fi
#hour_var=$(echo "HORAS" | cut -b 1)
#min_var=$(echo "ACTA" | cut -b 1)
#MIN=$(($SEC / 60))
#SEC=$(($SEC - $MIN * 60))
#HOR=$(($MIN / 60))
#MIN=$(($MIN - $HOR * 60))
txto[1]=$(printf '%-10s' "$namer")
[[ ${_limit} = @(HWID|TOKEN) ]] && {
[[ -e /etc/adm-lite/userDIR/$namer ]] && _sen=$(cat /etc/adm-lite/userDIR/$namer | grep -w senha |awk '{print $2}')
txto[2]=$(printf '%-12s' "$_sen")
} || txto[2]=$(printf '%-12s' "$_sen")
txto[3]=$(printf '%-10s' "$_limit")
[[ -e /etc/adm-lite/userDIR/$namer ]] && txto[4]=$(cat /etc/adm-lite/userDIR/$namer | grep -w 'data'| awk '{print $2}' ) || txto[4]="$(date -d "$data_user" "+%Y-%m-%d")"
#txto[4]=$(printf '%-10s' "${HOR}h:${MIN}m:${SEC}s")
[[ $(passwd --status $namer|cut -d ' ' -f2) = "L" ]] && txto[5]="\033[1;31mLOCK" || txto[5]=$(printf '%-2s' "$dias_user")
#/etc/adm-lite/userDIR/${name}r.block
_cont=$(($_cont + 1))
[[ $(echo -e ${_limit} |sed -e 's/[^0-9]//ig') ]] && { 
	echo -e "\033[0;35m [\033[0;36m$_cont\033[0;35m]\033[0;31m>${cor[3]} ${txto[1]} ${txto[2]} \033[0;35m${txto[3]} ${cor[3]}${txto[4]} ${txto[5]}"
} || {
	[[ ${_limit} = 'HWID' ]] && _cl='ID' || _cl='TK'
	echo -e "\033[0;35m [\033[0;36m$_cont\033[0;35m]\033[0;31m>${cor[3]} ${txto[2]}            \033[0;35m$(printf '%-10s' "${_cl}${_cont}") ${cor[3]}${txto[4]} ${cor[1]}${txto[5]}" && echo -e "     \033[1;32m ⤷ ${_limit} ${cor[2]}- \033[1;31m${txto[1]} "
	}
done
msg -bar3
echo -e " \033[1;32m 🔰 # TIENES \033[1;33m [ \033[1;36m${_cont}\033[1;33m ]\033[1;32m CLIENTES EN TU SERVIDOR 🔰 #"
msg -bar3
unset txt_
}


function_5 () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
cab=$(printf '%-15s%-15s%-9s' 'USUARIO' 'CONEXIONES' 'TIEMPO HH:MM:SS')
msg -bar3 
echo -e "\E[41;1;37m $cab\E[0m"
unset conex1
msg -bar3
_data_now=$(date +%s)
[[ -z $(locale | grep "LANG=" | cut -d "=" -f2) ]] && export LANG=en_US.UTF-8
nU=1
for user in `cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1 |sort -f`; do 
i=${user}
sqd="$(ps -u $user | grep sshd | wc -l)"
[[ "$sqd" = "" ]] && sqd=0
[[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
if netstat -nltp|grep 'dropbear'> /dev/null;then
     drop="$(dropbear_pids | grep "$user" | wc -l)"
 else
     drop=0
fi
cnx=$(($sqd + $drop))
conex=$(($cnx + $ovp))
local _time="$(ps -o etime $(ps -u $user |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')"
if [[ $cnx -gt 0 ]]; then
          tst="${_time}"
          tst1=$(echo "$tst" | wc -c)
if [[ "$tst1" == "9" ]]; then 
          timerr="${_time}"
else
          timerr="$(echo "00:$tst")"
fi
elif [[ $ovp -gt 0 ]]; then
          tmp2=$(printf '%(%H:%M:%S)T\n')
          tmp1="$(grep -w "$i" /etc/openvpn/openvpn-status.log |awk '{print $4}'| head -1)"
          [[ "$tmp1" = "" ]] && tmp1="00:00:00" && tmp2="00:00:00"
          var1=`echo $tmp1 | cut -c 1-2`
          var2=`echo $tmp1 | cut -c 4-5`
          var3=`echo $tmp1 | cut -c 7-8`
          var4=`echo $tmp2 | cut -c 1-2`
          var5=`echo $tmp2 | cut -c 4-5`
          var6=`echo $tmp2 | cut -c 7-8`
          calc1=`echo $var1*3600 + $var2*60 + $var3 | bc`
          calc2=`echo $var4*3600 + $var5*60 + $var6 | bc`
          seg=$(($calc2 - $calc1))
          min=$(($seg/60))
          seg=$(($seg-$min*60))
          hor=$(($min/60))
          min=$(($min-$hor*60))
          timerusr=`printf "%02d:%02d:%02d \n" $hor $min $seg;`
          timerr=$(echo "$timerusr" | sed -e 's/[^0-9:]//ig' )
else
          timerr="00:00:00"
fi
[[ -e $dir_user/${user} ]] && {

[[ $(cat $dir_user/${user} | grep "limite" | awk '{print $2}') = "HWID" ]] && { 
user="$(cat $dir_user/${user} | grep "senha" | awk '{print $2}') \033[1;33m[\033[1;34mHWID\033[1;33m]\033[1;32m"
_limiter="/${_limTOP}\033[1;33m]\033[1;32m"
} || {
[[ $(cat $dir_user/${user} | grep "limite" | awk '{print $2}') = "TOKEN" ]] && { 
user="$(cat $dir_user/${user} | grep "senha" | awk '{print $2}') \033[1;33m[\033[1;35mTOKEN\033[1;33m]\033[1;32m"
_limiter="/${_limTOP}\033[1;33m]\033[1;32m"												
																				} 
	} || {
	_limiter="\033[1;32m/\033[1;31m$(cat $dir_user/${user} | grep "limit" | awk '{print $2}')\033[1;33m]\033[1;32m"
	}
} || _limiter='/⚠️\033[1;33m]\033[1;32m'
if [ "$conex" -gt "0" ]; then
conex1+="${conex}+"
#lim="\033[1;33m[\033[1;35m$(printf '%-7s' ${conex}${_limiter})"
#local users=" ${user},	$lim,	${timerr},	${cor[0]}"
#echo -e "$users" | column -e -t -s ","
lim="\033[1;33m[\033[1;35m${conex}${_limiter}"
users=$(printf '%-15s%-15s%-15s' "${user} "	" ${lim}	"	"${timerr}"	)
echo -e "\033[0;35m [\033[0;36m$nU\033[0;35m]\033[0;31m-${cor[3]}$users ${cor[0]}"
let nU++
fi
done
conex1+="0"
conex1=$(echo $conex1|bc)
[[ "$conex1" = "" ]] &&  echo -e "\033[1;31m  ⚠️  NO TIENES USUARIOS CONECTADOS ! ⚠️ " 
msg -bar3
echo -e " \033[1;32m 🔰 # TIENES \033[1;33m [ \033[1;36m${conex1}\033[1;33m ]\033[1;32m USUARIOS CONECTADOS 🔰 #"
msg -bar3
}

function_6 () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1

local _removidos
msg -bar3
datenow=$(date +%s)
for user in $(cat /etc/passwd | grep -v ovpn | cat "/etc/passwd"|grep 'home'|grep 'false'|grep -v 'syslog' | cut -d: -f1); do
expdate=$(chage -l $user|awk -F: '/Account expires/{print $2}')
echo $expdate|grep -q nunca && continue
datanormal=$(date -d"$expdate" '+%d/%m/%Y')
expsec=$(date +%s --date="$expdate")
diff=$(echo $datenow - $expsec|bc -l)
echo $diff|grep -q ^\- && continue
userdel --force $user > /dev/null 2>/dev/null
kill -9 `ps aux |grep -vi '[a-z]$user' |grep -vi '$user[a-z]' |grep -v '[1-9]$user' |grep -v '$user[1-9]' |grep $user |awk {'print $2'}` 2> /dev/null
pid_kill=$(dropbear_pids | grep "$user" | awk '{print $2}')
uskk=$(cat /bin/ejecutar/uskill)
let uskk=$uskk+$cco
echo $uskk > /bin/ejecutar/uskill
[[ "$pid_kill" != "" ]] && drop_kill $user
[[ "$OPENVPN" = "on" ]] && open_2 $name
[[ -e $dir_user/$user ]] && rm $dir_user/$user
_removidos="on"
echo -e "\033[1;37m $user ${cor[2]} ELIMINADO "
done
if [ "$_removidos" = "" ]; then
echo -e "${cor[5]} ⚠️  No hay Usuarios Vencidos! ⚠️ "
unset _removidos
fi
msg -bar3
}

ban_per () {
clear
local="/etc/bannerssh"
msg -bar3
echo -e "\033[1;37m - BANNER CUSTOM EDITABLE -  \033[0m"
msg -bar3
echo -e "\033[1;37mSeleccione su Sistema:    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
echo -e " \033[1;31m[ !!! ]\033[1;33m PEGA AQUI TU BANNER   \033[1;31m\033[1;33m"
msg -bar3
echo -e " \033[1;31mLuego de Pegar tu banner Presiona Ctrl + O y Enter \033[1;33m \033[1;31m\033[1;33m"
echo -e " \033[1;31m          Por Ultimo Ctrl + X  \033[1;33m \033[1;31m\033[1;33m"
echo -ne "\033[1;37m"
read -p " Presiona Enter para Continuar "
apt install nano -y > /dev/null 2>&1
nano /bin/ejecutar/bannerssh
cat /bin/ejecutar/bannerssh > /etc/bannerssh
rm /bin/ejecutar/bannerssh
fun_bar
#[[ ! -e /root/name ]] && credi="@ChumoGH" || credi=$(cat < /root/name)
#echo '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'$(cat /bin/ejecutar/menu_credito)'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'$credi'</strong></span></p>' >> /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || men="NO EXISTE DROPBEAR"
msg -bar3
echo -ne " \033[1;31m[ ! ] VERIFICANDO DROPBEAR "
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && { 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]"  || {
echo -e "\033[1;31m - BANNER INCOMPATIBLE CON DROPBEAR -\n" && echo "DESTRUYENDO DISEÑO" 
echo "" > /etc/dropbear/banner 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]"
}
} || echo -e "\033[0;35m [ $men ]"
echo -ne " \033[1;31m[ ! ] VERIFICANDO SSH"
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
sleep 0.1s
exit 
}

txt_font () {
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]\033[1;33m Letra Pequeña"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]\033[1;33m Letra Media"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]\033[1;33m Letra Grande"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]\033[1;33m Letra ExtraGrande"
echo ""
echo -ne "\033[1;32mEscoje el Tamaño de Letra\033[1;31m ?\033[1;37m : "; read opc
if [[ "$opc" = "1" ]] || [[ "$opc" = "01" ]]; then
_size='6'
elif [[ "$opc" = "2" ]] || [[ "$opc" = "02" ]]; then
_size='4'
elif [[ "$opc" = "3" ]] || [[ "$opc" = "03" ]]; then
_size='3'
elif [[ "$opc" = "4" ]] || [[ "$opc" = "04" ]]; then
_size='1'
else
_size='6'
fi
msg -bar3
echo -ne "\033[1;37m"
read -p " INGRESA TU MENSAJE : " ban_ner2
msg -bar3
unset x
echo -e "\033[1;42m Deseas centrar el contenido del banner\033[0;33m  :v"
echo ""
echo -ne "\033[0;32m Responde [ s | n ] : " && read -e -i "s" x
msg -bar3
[[ "$x" = @(s|S|y|Y) ]] && echo -e '<p style="text-align: center;">' >> /etc/bannerssh
echo -e " \033[1;31m[ 1 ]\033[1;33m > VERDE         \033[1;31m[ 9  ]\033[1;33m > AZUL PIZARRA OSCURO"
echo -e " \033[1;31m[ 2 ]\033[1;33m > ROJO          \033[1;31m[ 10 ]\033[1;33m > MAGENTA"
echo -e " \033[1;31m[ 3 ]\033[1;33m > AZUL          \033[1;31m[ 11 ]\033[1;33m > CHOCOLATE"
echo -e " \033[1;31m[ 4 ]\033[1;33m > AMARILLO      \033[1;31m[ 12 ]\033[1;33m > VERDE CLARO"
echo -e " \033[1;31m[ 5 ]\033[1;33m > PURPURA       \033[1;31m[ 13 ]\033[1;33m > GRIS"
echo -e " \033[1;31m[ 6 ]\033[1;33m > Naranja       \033[1;31m[ 14 ]\033[1;33m > VERDE MAR"
echo -e " \033[1;31m[ 7 ]\033[1;33m > Crema         \033[1;31m[ 15 ]\033[1;33m > CIAN OSCURO"
echo -e " \033[1;31m[ 8 ]\033[1;33m > Cyano         \033[1;31m[ *  ]\033[1;33m > Negro"
read -p " Digite A Cor [ 1 ⇿ 15 ]: " ban_ner2_cor
if [[ "$ban_ner2_cor" = "1" ]]; then
echo '<h'$_size'><font color="green">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "2" ]]; then
echo '<h'$_size'><font color="red">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "3" ]]; then
echo '<h'$_size'><font color="blue">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "4" ]]; then
echo '<h'$_size'><font color="yellow">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "5" ]]; then
echo '<h'$_size'><font color="purple">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "6" ]; then
echo '<h'$_size'><font color="#FF7F00">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "7" ]; then
echo '<h'$_size'><font color="#AEB404">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "8" ]; then
echo '<h'$_size'><font color="cyan">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "9" ]; then
echo '<h'$_size'><font color="#483D8B">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "10" ]; then
echo '<h'$_size'><font color="#FF00FF">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "11" ]; then
echo '<h'$_size'><font color="#D2691E">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "12" ]; then
echo '<h'$_size'><font color="#90EE90">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "13" ]; then
echo '<h'$_size'><font color="#BEBEBE">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "14" ]; then
echo '<h'$_size'><font color="#2E8B57">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "15" ]; then
echo '<h'$_size'><font color="#008B8B">' >> /etc/bannerssh
else
echo '<h'$_size'><font color="black">' >> /etc/bannerssh
fi
echo "$ban_ner2" >> /etc/bannerssh
echo "</h"$_size"></font>" >> /etc/bannerssh
[[ "$x" = @(s|S|y|Y) ]] && echo "</p>" >> /etc/bannerssh
}


Call.bannerSSH () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e "${cor[2]}MENU BANNER  (RECOMENDADO 2):"
msg -bar3
echo -e "\033[0;35m [\033[0;36m01\033[0;35m]\033[0;31m >${cor[3]} Pegar BANNER Personalizado ( html , etc )"
echo -e "\033[0;35m [\033[0;36m02\033[0;35m]\033[0;31m >${cor[3]} AGREGAR MENSAJES BANNER SSH"
echo -e "\033[0;35m [\033[0;36m03\033[0;35m]\033[0;31m >${cor[3]} ELIMINAR BANNER ( SSH ⇿ DROPBEAR )"
echo -e "\033[0;35m [\033[0;36m04\033[0;35m]\033[0;31m >${cor[3]} CheckUser + BANNER \033[0;31m[ $(msg -verm2 'NUEVO') \033[0;31m]"
msg -bar3
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m > $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3
selection=$(selection_fun 4)
case ${selection} in
1)
unset sshsn
unset sin_nao
echo -e " Al escojer que coloques tu Banner creado fuera del Script, ADM no se "
echo -e "    Responsabiliza por el Fallo de ciertos recursos del SISTEMA"
echo -e "RECUERDA QUE EL SCRIPT ESTA REALIZADO PARA FUNCIONAR CON SUS FUNCIONES"
echo -e "                          Y esta es EXPERIMENTAL"
echo -e "Esta SEGURO QUE DESEAS CONTINUAR ?:"
read -p " [S/N]: " -e -i n sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
local2="/etc/bannerssh"
chk=$(cat /etc/ssh/sshd_config | grep Banner)
if [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 else
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
local="/etc/bannerssh"
fi
while true; do
echo -e " ESTRUCTURA BANNER CUSTOM AÑADIDA, ACEPTAS CONTINUAR?"
read -p " [ s | n ]: " sin_nao
 if [[ "$sin_nao" = @(s|S|y|Y) ]]; then
 ban_per
 elif [[ "$sin_nao" = @(n|N) ]]; then
 break
 fi
done
}
;;
2)
unset sshsn
unset sin_nao
echo -e "${cor[3]} Buena ELECCION, Tienes un 99% mas Garantia"
echo -e "${cor[3]} Esta SEGURO:"
read -p " [S/N]: " -e -i s sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
local2="/etc/bannerssh"
chk=$(cat /etc/ssh/sshd_config | grep Banner)
if [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 else
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
local="/etc/bannerssh"
fi
msg -bar3
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]\033[1;33m Letra Pequeña"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]\033[1;33m Letra Media"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]\033[1;33m Letra Grande"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]\033[1;33m Letra ExtraGrande"
echo ""
echo -ne "\033[1;32mEscoje el Tamaño de Letra\033[1;31m ?\033[1;37m : "; read opc
if [[ "$opc" = "1" ]] || [[ "$opc" = "01" ]]; then
_size='6'
elif [[ "$opc" = "2" ]] || [[ "$opc" = "02" ]]; then
_size='4'
elif [[ "$opc" = "3" ]] || [[ "$opc" = "03" ]]; then
_size='3'
elif [[ "$opc" = "4" ]] || [[ "$opc" = "04" ]]; then
_size='1'
else
_size='6'
fi
msg -bar3
echo -ne "\033[1;37m"
read -p " INGRESA TU MENSAJE : " ban_ner
msg -bar3
echo -e " \033[1;31m[ 1 ]\033[1;33m > VERDE         \033[1;31m[ 9  ]\033[1;33m > AZUL PIZARRA OSCURO"
echo -e " \033[1;31m[ 2 ]\033[1;33m > ROJO          \033[1;31m[ 10 ]\033[1;33m > MAGENTA"
echo -e " \033[1;31m[ 3 ]\033[1;33m > AZUL          \033[1;31m[ 11 ]\033[1;33m > CHOCOLATE"
echo -e " \033[1;31m[ 4 ]\033[1;33m > AMARILLO      \033[1;31m[ 12 ]\033[1;33m > VERDE CLARO"
echo -e " \033[1;31m[ 5 ]\033[1;33m > PURPURA       \033[1;31m[ 13 ]\033[1;33m > GRIS"
echo -e " \033[1;31m[ 6 ]\033[1;33m > Naranja       \033[1;31m[ 14 ]\033[1;33m > VERDE MAR"
echo -e " \033[1;31m[ 7 ]\033[1;33m > Crema         \033[1;31m[ 15 ]\033[1;33m > CIAN OSCURO"
echo -e " \033[1;31m[ 8 ]\033[1;33m > Cyano         \033[1;31m[ *  ]\033[1;33m > Negro"
read -p " [ 1 ⇿ 15 ]: " ban_ner_cor
unset local 
unset x
echo -e "\033[1;42m Deseas centrar el contenido del banner\033[0;33m  :v"
echo ""
echo -ne "\033[0;32m Responde [ s | n ] : " && read -e -i "s" x
msg -bar3
[[ "$x" = @(s|S|y|Y) ]] && echo -e '<p style="text-align: center;">' > /etc/bannerssh
if [[ "$ban_ner_cor" = "1" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="green">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "2" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="red">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "3" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="blue">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "4" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="yellow">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "5" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="purple">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "6" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#FF7F00">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "7" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#AEB404">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "8" ]; then
echo '<h'$_size' style="text-align:center;"><font color="cyan">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "9" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#483D8B">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "10" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#FF00FF">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "11" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#D2691E">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "12" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#90EE90">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "13" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#BEBEBE">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "14" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#2E8B57">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "15" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#008B8B">' >> /etc/bannerssh
else
echo '<h'$_size' style="text-align:center;"><font color="black">' >> /etc/bannerssh
fi
echo "$ban_ner" >> /etc/bannerssh
echo '</font></h'$_size'>' >> /etc/bannerssh
[[ "$x" = @(s|S|y|Y) ]] && echo "</p>" >> /etc/bannerssh
while true; do
echo -e " DESEAS AÑADIR MAS TEXTOS A TU BANNER?"
read -p " [ s | n ]: " sin_nao
 if [[ "$sin_nao" = @(s|S|y|Y) ]]; then
 txt_font
 elif [[ "$sin_nao" = @(n|N) ]]; then
 break
 fi
done
[[ -e /root/name ]] && credi=$(cat < /root/name) || credi="@ChumoGH"
credit=$(cat < /bin/ejecutar/menu_credito | head -1)
echo -e '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'" $credit "'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'"$credi"'</strong></span></p>' >> /etc/bannerssh
#echo '<font color="#FF00FF">© 2020 ChumoGH, &reg</font>' >> /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || men="NO EXISTE DROPBEAR"
msg -bar3
echo -ne " \033[1;31m[ ! ] VERIFICANDO DROPBEAR "
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && { 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]"  || {
echo -e "\033[1;31m ▢ BANNER INCOMPATIBLE CON DROPBEAR -\n" && echo "DESTRUYENDO DISEÑO" 
echo "" > /etc/dropbear/banner 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]"
}
} || echo -e "\033[0;35m [ $men ]" 
echo -ne " \033[1;31m[ ! ] VERIFICANDO SSH "
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
}
return 0
;;
3)
echo "Verificando existencia de BANNER"
echo ""
[[ -e /etc/bannerssh ]] && {
 echo "DESTRUYENDO BANNER SSH " 
 echo "" > /etc/bannerssh
 } || echo "NO EXISTE BANNER DROPBEAR ESTRUCTURADO"
 [[ -e /etc/dropbear/banner ]] && {
 echo "DESTRUYENDO BANNER DROPBEAR " 
 echo "" > /etc/dropbear/banner
 } || echo "NO EXISTE BANNER SSH ESTRUCTURADO"
 return 0
;;
4)
msg -bar3
print_center -verm2 ' BANNER + CHEKUSER CUSTOM \n ESTA OPCION RECONSTRUIRA LOS PAQUETES DE SSH/DROPBEAR \n EN CASO DE EXISTIR \n  RECUERDA QUE PUEDEN EXISTIR PROBLEMAS DE COMPATIBILIDAD!!'
msg -bar3
echo -ne "${cor[3]} Esta SEGURO? :"
read -p " [S/N]: " -e -i s sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
[[ -e /bin/banner.bin ]] && banner.bin || {
msg -ama " Descargando binario BANNER...."
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/banner.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/aarch64/banner.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/banner.bin
  [[ -e /bin/banner.bin ]] && rm -f /bin/banner.bin
  ln -s /etc/ADMcgh/bin/banner.bin /bin/banner.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/banner.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/banner.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/banner.bin
  [[ -e /bin/banner.bin ]] && rm -f /bin/banner.bin
  ln -s /etc/ADMcgh/bin/banner.bin /bin/banner.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }
  banner.bin
}
} || return
;;
*)
echo "LO SENTIMOS DIGITASTE MAL"
sleep 0.1s
return 0
;;
esac
#TERMINA CASE
}

meu-v2ray () {

tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
print_center '\e[97m\033[1;41m MENUS V2RAY REFACTORIZADOS\033[0m' 
#\033[0;33m(#EXPERIMENTAL)"
menu_item "MENU LITE  V2RAY  MultiCuentas  \033[0;32m(#OFICIAL)   " "V2RAY MENU CUSTOM MultiCuentas  \033[0;32m(#OFICIAL)" "MENU LITE   XRAY  MultiCuentas  \033[0;32m(#OFICIAL)   " "MENU LITE TROJAN MultiCuentas  \033[0;32m(#OFICIAL)"
selection=$(selection_fun 4)
case ${selection} in
1)[[ $(which v2r.sh) ]] && $(which v2r.sh) || source <(curl -sSL https://www.dropbox.com/s/yxpjpgcwyrvitl6/v2ray_manager.url.sh) ;;
2)[[ -e /etc/v2ray/config.json ]] && source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh) || source <(curl -sSL https://www.dropbox.com/s/q6mpwhfgt1665pl/v2ray.sh) ;;
3)[[ $(which xr.sh) ]] && $(which xr.sh) || source <(curl -sSL https://www.dropbox.com/s/olvy10kff2wwe8f/xray_manager.sh) ;;
4)[[ $(which troj.sh) ]] && $(which troj.sh) || troj.sh;; 
0)return 0 ;;
esac
}


ssrmenu () {
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/ssrrmu.sh)
}


selection=$(selection_fun 14)
case ${selection} in
1)
cd /etc/adm-lite/ && fun_us
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
2)
cd /etc/adm-lite/ && function_2
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
3)
cd /etc/adm-lite/ && function_3
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
4)
cd /etc/adm-lite/ && function_4
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
5)
cd /etc/adm-lite/ && function_5
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
6)
cd /etc/adm-lite/ && Call.bannerSSH
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
7)
cd /etc/adm-lite/ && net_meter
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
8)
cd /etc/adm-lite/ && block_user
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
9)
cd /etc/adm-lite/ && recuva1
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
10)
cd /etc/adm-lite/ && ssrmenu
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
11)
cd /etc/adm-lite/ && meu-v2ray
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
12)
cd /etc/adm-lite/ && consul_cli
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
13)
chk_ip=${IP}
menu_chekuser
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
14)
_usCHECK
echo -ne "${cor[5]}"
read -p " ¡Enter, para volver!"
Call.UserS
;;
esac
return
}

start_checkUser(){
[[ -e /bin/ejecutar/checkuser.py ]] || wget -q -O /bin/ejecutar/checkuser.py https://www.dropbox.com/s/636hdjb1tw43uws/chekuser.py && chmod +x /bin/ejecutar/checkuser.py
	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title 'DESABILITANDO CHEKUSER'
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verd 'chekuser, se desactivo con exito!'
		enter
		return
	fi

	title 'SELECCIONA UN PERTO'
    while [[ -z "${chekuser}" ]]; do
    	dport=$(shuf -i 82-150 -n 1)
    	chekuser=$(in_opcion -nama "Ingresa un puerto [def = ${dport}]")
    	[ -z "${chekuser}" ] && chekuser=${dport}
    	del 1
		[[ $chekuser = 0 ]] && return
    	if [[ ! $chekuser =~ $numero ]]; then
    		print_center -verm2 'ingresa solo numeros!'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -lt 10 ]]; then
    		print_center -verm2 'ingresa un numero mayor a 10'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -gt 65535 ]]; then
    		print_center -verm2 'ingresa un numero menor a 65535'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $(mportas|grep -w "$chekuser") ]]; then
			print_center -verm2 "Puerto en uso!"
			sleep 2
			del 1
    		unset chekuser
    	fi
    done
    echo " $(msg -ama "Puerto") $(msg -verd "$chekuser")"
    msg -bar3

    print_center 'SELECCIONA UN FORMATO DE FECHA'
    msg -bar3
    menu_func 'YYYY/MM/DD' 'DD/MM/YYYY'
    msg -bar3
    date=$(selection_fun 2)
    case $date in
    	1)fecha="YYYY/MM/DD";;
    	2)fecha="DD/MM/YYYY";;
    esac
    [[ $date = 0 ]] && return
    del 5
    echo " $(msg -ama "Formato") $(msg -verd "$fecha")"
    enter
    del 2

    print_center -ama 'Instalandon python3-pip'
    if apt install -y python3-pip &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon python3-pip ok'
    else
    	del 1
    	print_center -verm2 'falla al instalar python3-pip\nintente instalar manualmente\n\ncomando manual >> apt install -y python3-pip\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Instalandon flask'
    if pip3 install flask &>/dev/null; then
    	del 1
    	print_center -verd 'Instalandon flask ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar flask\nintente instalar manualmente\n\ncomando manual >> pip3 install flask\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Instalandon check'
    if wget --no-cache -O /usr/bin/check https://www.dropbox.com/s/r2madnleejjqhw1/check.sh &>/dev/null; then
    	chmod +x /usr/bin/check
    	mkdir /etc/rec
    	del 1
    	print_center -verd 'Instalandon check ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar check\nintente instalar manualmente\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Iniciando servicio'

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
    	systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    fi

    rm -rf /etc/systemd/system/chekuser.service

    echo -e "[Unit]
Description=chekuser Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/python3 /bin/ejecutar/checkuser.py $chekuser $date
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/chekuser.service

# ExecStart=/usr/bin/python3 ${ADM_inst}/chekuser.py $chekuser $date
# ps x|grep -v grep|grep chekuser.py|awk '{print $7}'

	systemctl enable chekuser &>/dev/null
	systemctl start chekuser &>/dev/null

	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'Instalacion completa'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'falla al iniciar servicio chekuser'
	fi
	enter
}

_onli() {

   print_center -ama 'Instalandon check'
    if wget --no-cache -O /usr/bin/onlineapp https://www.dropbox.com/s/x8wcrnj5gho4d39/onlineapp.sh &>/dev/null; then
    	chmod +x /usr/bin/onlineapp
    	mkdir /etc/rec
    	del 1
    	print_center -verd 'Instalando onlineapp ok'
    else
    	del 1
    	print_center -verm2 '\nfalla al instalar onlineapp\nintente instalar manualmente\n\nresuelva esta falla para luego intentar'
    	enter
    	return
    fi

    print_center -ama 'Iniciando servicio'

    if [[ $(systemctl is-active onliuser) = "active" ]]; then
    	systemctl stop onliuser &>/dev/null
    	systemctl disable onliuser &>/dev/null
    fi

    rm -rf /etc/systemd/system/onliuser.service

    echo -e "[Unit]
Description=onliuser Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/onlineapp
Restart=always
RestartSec=15s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/onliuser.service

	systemctl enable onliuser &>/dev/null
	systemctl start onliuser &>/dev/null

	if [[ $(systemctl is-active onliuser) = "active" ]]; then
		title -verd 'Instalacion completa'
		print_center -ama "URL: http://$chk_ip:81/server/online"
	else
		systemctl stop onliuser &>/dev/null
    	systemctl disable onliuser &>/dev/null
    	rm -rf /etc/systemd/system/onliuser.service
		print_center -verm2 'falla al iniciar servicio User Activos'
	fi
	enter
}

mod_port(){
	title 'SELECCIONA UN PERTO'
    while [[ -z "${chekuser}" ]]; do
    	dport=$(shuf -i 82-90 -n 1)
    	chekuser=$(in_opcion -nama "Ingresa un puerto [def = ${dport}]")
    	[ -z "${chekuser}" ] && chekuser=${dport}
    	del 1
    	if [[ ! $chekuser =~ $numero ]]; then
    		print_center -verm2 'ingresa solo numeros!'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -lt 10 ]]; then
    		print_center -verm2 'ingresa un numero mayor a 10'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ $chekuser -gt 65535 ]]; then
    		print_center -verm2 'ingresa un numero menor a 65535'
    		sleep 2
    		del 1
    		unset chekuser
    	elif [[ ! $(mportas|grep -w "$PORT") ]]; then
			print_center -verm2 "Puerto en uso!"
			sleep 2
			del 1
    		unset chekuser
    	fi
    done
    echo " $(msg -ama "Puerto") $(msg -verd "$chekuser")"
    enter
    port_chek=$(ps x|grep -v grep|grep chekuser.py|awk '{print $7}')
    systemctl stop chekuser &>/dev/null
    systemctl disable chekuser &>/dev/null
    sed -i "s/$port_chek/$chekuser/g" /etc/systemd/system/chekuser.service
    systemctl enable chekuser &>/dev/null
    systemctl start chekuser &>/dev/null

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'puerto modificado'
		print_center -ama "URL: http://$chk_ip:$chekuser/checkUser"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'algo salio mal\nfalla al iniciar servicio chekuser'
	fi
	enter
}

mod_fdate(){
	title 'SELECCIONA UN FORMATO DE FECHA'
	menu_func 'YYYY/MM/DD' 'DD/MM/YYYY'
    msg -bar3
    date=$(selection_fun 2)
    case $date in
    	1)fecha="YYYY/MM/DD";;
    	2)fecha="DD/MM/YYYY";;
    esac
    [[ $date = 0 ]] && return
    del 3
    echo " $(msg -ama "Formato") $(msg -verd "$fecha")"
    enter
    formato=$(ps x|grep -v grep|grep chekuser.py|awk '{print $8}')
    systemctl stop chekuser &>/dev/null
    systemctl disable chekuser &>/dev/null
    sed -i "s/$formato/$date/g" /etc/systemd/system/chekuser.service
    systemctl enable chekuser &>/dev/null
    systemctl start chekuser &>/dev/null

    if [[ $(systemctl is-active chekuser) = "active" ]]; then
		title -verd 'formato de fecha modificado'
		print_center -ama "FORMATO: $fecha"
	else
		systemctl stop chekuser &>/dev/null
    	systemctl disable chekuser &>/dev/null
    	rm -rf /etc/systemd/system/chekuser.service
		print_center -verm2 'algo salio mal\nfalla al iniciar servicio chekuser'
	fi
	enter

}

menu_chekuser(){
	title 'VERIFICACION DE USUARIOS ONLINE'
	num=1
	if [[ $(systemctl is-active chekuser) = "active" ]]; then
		formato=$(ps x|grep -v grep|grep chekuser.py|awk '{print $8}')
		case $formato in
    		1)fecha_data="YYYY/MM/DD";;
    		2)fecha_data="DD/MM/YYYY";;
    	esac
    	fecha_data=$(printf '%15s' "$fecha_data")
		port_chek=$(ps x|grep -v grep|grep checkuser.py|awk '{print $7}')
		print_center -ama "URL: http://$chk_ip:$port_chek/checkUser"
		port_chek=$(printf '%8s' "$port_chek")
		msg -bar3
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verm2 'DESACTIVAR') $(msg -azu 'CHEKUSER')"
		echo " $(msg -verd '[2]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR PUERTO') $(msg -verd "$port_chek")"
		echo " $(msg -verd '[3]') $(msg -verm2 '>') $(msg -azu 'MODIFICAR FORMATO') $(msg -verd "$fecha_data")"
[[ $(systemctl is-active onliuser) = "active" ]] && echo " $(msg -verd '[4]') $(msg -verm2 '>') $(msg -azu 'DESACTIVAR USER ACTIVOS') $(msg -verd "ON")" ||echo " $(msg -verd '[4]') $(msg -verm2 '>') $(msg -azu 'ACTIVAR ONLINE Usr en APP') $(msg -verd "OFF")"
		num=4
	else
        print_center -verm2 'ADVERTENCIA!!!\nCheckUser PODRIA CONSUMIR RECURSOS \n EN CONEXIONES O METODOS INESTABLES\n RECOMENDABLE ANALIZAR TU METODO PRIMERO'
        msg -bar3
		echo " $(msg -verd '[1]') $(msg -verm2 '>') $(msg -verd 'ACTIVAR') $(msg -azu 'CHEKUSER')"
	fi
	back
	opcion=$(selection_fun $num)
	case $opcion in
		1)start_checkUser;;
		2)mod_port;;
		3)mod_fdate;;
		4)_onli;;
		0)return;;
	esac
}

troj.sh(){
local config="/usr/local/etc/trojan/config.json"
local configLOCK="/usr/local/etc/trojan/config.json.lock"
local temp="/etc/trojan/temp.json"
local trojdir="/etc/trojan" && [[ ! -d $trojdir ]] && mkdir $trojdir
local user_conf="/etc/trojan/user" && [[ ! -e $user_conf ]] && touch $user_conf
local backdir="/etc/trojan/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
local tmpdir="$backdir/tmp"
[[ ! -e $trojdir/conf ]] && echo "autBackup 0" > $trojdir/conf
if [[ $(cat $trojdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $trojdir/conf
fi

local numero='^[0-9]+$'
local hora=$(printf '%(%H:%M:%S)T') 
local fecha=$(printf '%(%D)T')

restroj(){
msg -bar3
[[ $(ps x | grep trojan | grep -v grep) ]] && {
kill $(ps x | grep trojan| grep -v grep | cut -d " " -f1) &> /dev/null
[[ $(ps x | grep trojan | grep -v grep) ]] && killall $(which trojan) &> /dev/null
}
[[ -e /root/server.log ]] && echo "@ChumoGH " > /root/server.log || touch /root/server.log
#[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
#echo -ne " \033[1;32m  ${t0gSl} RESTART FOR ARM X64 ${t0gSl} " && (screen -dmS trojanserv $(which trojan) --config /usr/local/etc/trojan/config.json >> /root/server.log &) && echo "\033[1;35m OK " || echo -e "\033[1;32mÎ” FAIL"
#} || echo -ne "\033[1;32m  ${t0gSl} REINICIANDO SERVICIO ${t0gSl} " && (screen -dmS trojanserv $(which trojan) /usr/local/etc/trojan/config.json -l /root/server.log &) && echo "OK " || echo -e "\033[1;32mÎ” FAIL"
systemctl restart trojan &>/dev/null
msg -bar3
#chekKEY &> /dev/null 2>&1
[[ "$(ps x | grep trojan| grep -v grep)" ]] && echo -e "  ${t0gSl} SERVICIO CORRIENDO EN EL PUERTO | ➣ $(cat $config | jq -r .local_port) "
}

restore(){
	clear

	unset num
	unset opcion
	unset _res

	if [[ -z $(ls $backdir) ]]; then
		title "	no se encontraron respaldos"
		sleep 0.3
		return
	fi
	num=1
	title "	   Lista de Respaldos creados"
	blanco "	      nom  \033[0;31m| \033[1;37mfechas \033[0;31m|  \033[1;37mhora"
	msg -bar3
	for i in $(ls $backdir); do
		col "$num)" "$i"
		_res[$num]=$i
		let num++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco " cual desea restaurar?" 0
	read opcion

	[[ $opcion = 0 ]] && return
	[[ -z $opcion ]] && blanco "\n deves seleccionar una opcion!" && sleep 2 && return
	[[ ! $opcion =~ $numero ]] && blanco "\n solo deves ingresar numeros!" && sleep 2 && return
	[[ $opcion -gt ${#_res[@]} ]] && blanco "\n solo numeros entre 0 y ${#_res[@]}" && sleep 2 && return

	mkdir $backdir/tmp
	tar xpf $backdir/${_res[$opcion]} -C $backdir/tmp/

	clear
	title "	Archivos que se restauran"

	if rm -rf $config && cp $tmpdir/config.json $temp; then
		sleep 1
		cat $temp > $config
		chmod 777 $config
		rm $temp
		blanco " /usr/local/etc/trojan/config.json..." && verde "[ok]" 
	else
		blanco " /usr/local/etc/trojan/config.json..." && rojo "[fail]"	
	fi

	if rm -rf $user_conf && cp $tmpdir/user $user_conf; then
		blanco " /etc/troja/user..." && verde "[ok]"
	else
		blanco " /etc/trojan/user..." && rojo "[fail]"
	fi
    #[[ -e $tmpdir/fullchain.cer ]] && mv $tmpdir/fullchain.cer $tmpdir/fullchain.crt
	if cp $tmpdir/*.cer /etc/trojan/fullchain.cer && cp $tmpdir/*.key /etc/trojan/private.key; then
		blanco " /etc/trojan/fullchain.cer..." && verde "[ok]"
		blanco " /etc/trojan/private.key..." && verde "[ok]"
	else
		blanco " /etc/trojan/fullchain.cer..." && rojo "[fail]"
		blanco " /etc/trojan/private.key..." && rojo "[fail]"
		msg -bar3
		echo -e "VALIDA TU CERTIFICADO SSL "
		fi
	rm -rf $tmpdir
	msg -bar3
	continuar
	read foo
}

backups(){
	while :
	do
		unset opcion
		unset PID
		if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
			PID="\033[0;31m[offline]"
		else
			PID="\033[1;92m[online]"
		fi

	clear
	title "	Config de Respaldos"
	col "1)" "Respaldar Ahora"
	col "2)" "\033[1;92mRestaurar Respaldo"
	col "3)" "\033[0;31mEliminiar Respaldos"
	col "4)" "\033[1;34mRespaldo en linea $PID"
	col "5)" "\033[1;33mRespaldos automatico $(on_off_res)"
	msg -bar3
	
	col "6)" "\033[1;33m RESTAURAR Online PORT :81 "
	col "7)" "\033[1;33m RESPALDO LOCAL "
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "opcion" 0
	read opcion

	case $opcion in
		1)	backup
			clear
			title "	Nuevo Respaldo Creado..."
			sleep 0.5;;
		2)	restore;;
		3)	rm -rf $backdir/*.tar
			clear
			title "	Almacer de Respaldo limpia..."
			sleep 0.5;;
		4)	server;;


		5)	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
				sed -i 's/autBackup 0/autBackup 1/' $v2rdir/conf
			else
				sed -i 's/autBackup 1/autBackup 0/' $v2rdir/conf
			fi;;
		6)
		clear
		echo -e "\033[0;33m
         ESTA FUNCION EXPERIMENTAL 
Una vez que se descarge tu Fichero, Escoje el BackOnline
	
				  + OJO +
				 
   Luego de Restaurarlo, Vuelve Activar el TLS 
 Para Validar la Configuracion de tu certificao"
msg -bar3
echo -e "INGRESE LINK Online en GitHub, o VPS \n" 
read -p "Pega tu Link : " url1
wget -q -O $backdir/BakcOnline.tar $url1 && echo -e "\033[1;31m- \033[1;32mFile Exito!"  && restore || echo -e "\033[1;31m- \033[1;31mFile Fallo" && sleep 2
		;;
		7)
		bakc;;
		0)	break;;
		*)	blanco "opcion incorrecta..." && sleep 2;;
	esac
	done
}

backup() {
	unset fecha
	unset hora
	unset tmp
	unset back
	unset cer
	unset key
	#fecha=`date +%d-%m-%y-%R`
	fecha=`date +%d-%m-%y`
	hora=`date +%R`
	tmp="$backdir/tmp" && [[ ! -d ${tmp} ]] && mkdir ${tmp}
	back="$backdir/troj___${fecha}___${hora}.tar"
	[[ -e /etc/trojan/fullchain.cer ]] && cer="/etc/trojan/fullchain.cer"
	[[ -e /etc/trojan/private.key ]] && key="/etc/trojan/private.key"

	cp $user_conf $tmp
	cp $config $tmp
	[[ ! $cer = null ]] && [[ -e $cer ]] && cp $cer $tmp
	[[ ! $key = null ]] && [[ -e $cer ]] && cp $key $tmp

	cd $tmp
	tar -cpf $back *
	cp $back /var/www/html/trojanBack.tar && echo -e "
 Descargarlo desde cualquier sitio con acceso WEB
  LINK : http://$(wget -qO- ifconfig.me):81/trojanBack.tar \033[0m
-------------------------------------------------------"
read -p "ENTER PARA CONTINUAR"
	rm -rf $tmp
 }

trojan() {
wget -q https://www.dropbox.com/s/vogt0tyaqg0gee1/trojango.sh; chmod +x trojango.sh; ./trojango.sh
rm -f trojango.sh
}

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ ! -e /etc/chekKEY ]] && chekKEY &>/dev/null && touch /etc/chekKEY
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "
echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}

changeCERT () {
clear&&clear
unset opcion
			dataCERT=$(cat $config | jq -r .ssl.cert)
			dataKEY=$(cat $config | jq -r .ssl.key)
			msg -bar3 && echo ""
			echo -e " INGRESO DE RUTA DE CERTIFICADO SSL VALIDO ACTUAL" && echo ""
			echo -e " DATA CRT : ${dataCERT}" && echo "" && echo -e " DATA CRT : ${dataKEY}" && echo "" && msg -bar3 && echo -e ""
	while :
    do
	echo -e " DESEAS CAMBIAR RUTA DE TU CERTIFICADO SSL ? "
			read -p " [SI / NO ] :" opcion
            case $opcion in
				0)break ;;
                [Yy]|[Ss]) 
				echo -e " A CONTINUACION INGRESE SUS NUEVAS RUTAS DE CERTIFICADO"
				echo -e " DEFAULT ( /data/cert.crt && /data/cert.key ) ." && echo ""
				read -p "$(echo -e " DATA CRT :")" -e -i "/data/cert.crt" newdataCERT
				tput cuu1 && tput dl1
				read -p "$(echo -e " DATA KEY :")" -e -i "/data/cert.key" newdataKEY
				sed -i "s%${dataCERT}%${newdataCERT}%g" $config
				sed -i "s%${dataKEY}%${newdataKEY}%g" $config
				break
				;;
                [Nn]) cancelar && sleep 0.5 && break;;
                *) echo -e "\n \033[1;49;37mSelecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
	tput cuu1 && tput dl1
					;;
            esac
	done
			
		}
 
changeSNI () {
clear&&clear
unset opcion
			dataCERT=$(cat $config | jq -r .ssl.sni)
			msg -bar3 && echo ""
			echo -e " INGRESO INGRESA SNI VALIDO" && echo ""
			echo -e " SNI : ${dataCERT}" && echo "" && msg -bar3 && echo -e ""
	while :
    do
	echo -e " DESEAS CAMBIAR SNI ? "
			read -p " [SI / NO ] :" opcion
            case $opcion in
				0)break ;;
                [Yy]|[Ss])
				echo -e " A CONTINUACION INGRESE SU NUEVO SNI"
				read -p "$(echo -e " SNI Defauld : ")" -e -i "ssl.whatsapp.net" newdataKEY
				if sed -i "s%${dataCERT}%${newdataCERT}%g" $config ; then
				echo -e " EXITO AL CAMBIAR TU SNI"
				else
				newdataKEY='"sni": "${newdataKEY}",'
				sed -i "s%${dataCERT}%${newdataCERT}%g" $config
				echo -e " ERROR AL MODIFICAR SNI"
				fi
				break
				;;
                [Nn]) cancelar && sleep 0.5 && break;;
                *) echo -e "\n \033[1;49;37mSelecione (S) para si o (N) para no!\033[0m" && sleep 0.5 && continue
					;;
            esac
	done
			
}

enon(){
echo "source <(curl -sSL https://www.dropbox.com/s/5j139718zgsr6cy/mod-trojan.sh)" > /bin/troj.sh
#echo "menu '--troj.sh'" > /bin/troj.sh
chmod +x /bin/troj.sh
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * troj.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
enoff(){
rm -f /bin/troj.sh
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de troj.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	msg -bar3
	blanco "	  Ajustes e Entrasda Rapida de Menu TROJAN"
	msg -bar3
	col "1)" "Habilitar troj.sh, Como entrada Rapida"
	col "2)" "Eliminar troj.sh, Como entrada Rapida"
	msg -bar3
	col "0)" "Volver"
	msg -bar3
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 0.3;;
	esac
    done

}

on_off_res(){
	if [[ $(cat $trojdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		echo -e "\033[0;31m[off]"
	else
		echo -e "\033[1;92m[on]"
	fi
 }

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
}

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m ➣   \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}

col2(){

	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}

vacio(){
	blanco "\n no se puede ingresar campos vacios..."
}

cancelar(){

	echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}

continuar(){
	echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}

title2(){

#_check=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/adm-lite/trojanports.txt && cat /etc/adm-lite/trojanports.txt` > /dev/null 2>&1 
_check=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan`
#trojanports=$(echo $trojanports | awk {'print $1'})
trojanports=$(cat $config | jq -r .local_port)
#_tconex=$(netstat -nap | grep "$trojanports" | grep trojan  | grep ESTABLISHED| grep tcp6 | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
_tconex=$(netstat -nap | grep "$trojanports" | grep trojan  | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq | wc -l)
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	#echo -e "\033[7;49;35m  =====>>►► 🐲 Menu TROJAN ChumoGH💥VPS 🐲 ◄◄<<=====    \033[0m"
	msg -bar3
	[[ $(uname -m 2> /dev/null) != x86_64 ]] && echo -e "	CPU : ARM64 - BINARIO : trojan-go"
	[[ ${v1} = ${v2} ]] && echo -e "      \e[97m\033[1;44mPROYECT TROJAN BY @ChumoGH  [$v1]  \033[0m" || echo -e "   \e[97m\033[1;44mProyecto Trojan by @ChumoGH [$v1] >> \033[1;92m[$v2]  \033[0m"
	echo -e "          ${cor[2]} ${pPIniT} \033[1;37mIP: \033[1;31m$(wget -qO- ifconfig.me) ${cor[2]}${pPIniT} \033[1;37m"
	[[ ! -z ${_check} ]] && echo -e "       \e[97m\033[1;44mPUERTO ACTIVO :\033[0m \033[3;32m$trojanports\033[0m   \e[97m\033[1;44m ACTIVOS:\033[0m \033[3;32m\e[97m\033[1;41m $_tconex " ||  echo -e "     \e[97m\033[1;41m  SERVICIO TROJAN NO INICIADO \033[3;32m"
}

title(){
	msg -bar3
	
	echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "$1"
	msg -bar3
}

userDat(){
	#echo -e "     >>>>>>> Fecha Actual $(date '+%d-%m-%Y') <<<<<<<<<<<"
	blanco "	N°    Usuarios 		  fech exp   dias"
	msg -bar3
}

log_traff () {
[[ $log0 -le 1 ]] && restroj && let log0++ && clear 
msg -bar3
echo -e ""
echo -e " ESPERANDO A LA VERIFICACION DE IPS Y USUARIOS "
echo -e "      ESPERE UN MOMENTO PORFAVOR $log0"
echo -e ""
start_animation; sleep 5; stop_animation; echo
tput cuu1 >&2 && tput dl1 >&2
clear&&clear
title2
msg -bar3
IP_tconex=$(netstat -nap | grep "$trojanports" | grep trojan | grep ESTABLISHED | awk {'print $5'} | awk -F ":" '{print $1}' | sort | uniq)
#IP_tconex=$(netstat -nap | grep "$trojanports"| grep trojan | grep ESTABLISHED | grep tcp6 | awk {'print $5'}| awk -F ":" '{print $1}' | sort | uniq)
nick="$(cat $config | grep ',"')"
#users="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
users="$(cat $config | jq -r .password[])"
n=1
[[ -z $IP_tconex ]] && echo -e " NO HAY USUARIOS CONECTADOS!" && return
for i in $IP_tconex
do
	USERauth=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $4}'| sort | uniq)
	#PORTauth=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $1}')	
	#PORTdisco=$(cat $HOME/server.log | grep $i | cut -d: -f4 | grep authenticated |awk '{print $1}')
#	echo -e " $n) $USERauth - $i "
	Users+="$USERauth\n"
	#let n++
done
#echo -e "$Users"
echo -e " N) USER | CONEXIONES "|column -t -s '|'
for U in $users
	do
	CConT=$(echo -e "$Users" | grep $U |wc -l)
	[[ $CConT = 0 ]] && continue
	Usr="$(cat ${user_conf}|grep -w "${U}"|cut -d'|' -f1)"
	UConc+=" $n) $Usr |$CConT\n"
	let n++
done
echo -e "$UConc"|column -t -s '|' 
msg -bar3
continuar
read foo
#tail -f /usr/local/etc/trojan/config.json


}

add_user(){
autoDel
	unset seg new_id
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
	title "		CREAR USUARIO Trojan"
	userDat
	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = chumoghscript ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
		Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "${Usr}" "$DateExp" "$exp"
		}
		let n++
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "ESCRIBE TU USUARIO :" 0
	read usser
	usser=$(echo ${usser} |sed -e's/[^0-9a-z]//ig')
	[[ -z $usser ]] && vacio && sleep 0.3 && continue
	[[ $usser = 0 ]] && break
	[[ -z $(echo "$users" | grep -w $usser) ]] && {
	echo -e " SI DESEAS INGRESAR EL UUID " 
	read -p " ENTER (RAMDOM) :" new_id
	[[ -z ${new_id} ]] && new_id=$(uuidgen)
	msg -bar3
	blanco "DURACION EN DIAS" 0
	read dias
	dias=$(echo ${dias} |sed -e's/[^0-9]//ig')
	espacios=$(echo "$usser" | tr -d '[[:space:]]')
	usser=$espacios
	mv $config $temp
	movetm=$(echo -e "$new_id" | sed 's/^/,"/;s/$/"/')
	sed "10i\        ${movetm}" $temp > $config
	#echo -e "$opcion" | sed 's/^/,"/;s/$/"/'
	sed -i "/${usser}/d" $user_conf
	echo "$usser | ${new_id} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	msg -bar3
	blanco "	Usuario $usser creado con exito"
	msg -bar3
	autoDel
	restroj
	} || echo " USUARIO YA EXISTE " && sleep 0.5s
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d "|" -f2 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				col "$n)" "$Usr" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$Usr
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.3
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.3
		} || {
			blanco "DURACION EN DIAS" 0
			read dias
			mv $config $temp
			movetm=$(echo -e "${uid[$opcion]}" | sed 's/^/,"/;s/$/"/')
			sed "10i\        $movetm" $temp > $config
			sed -i "/${uid[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm -f $temp
			clear
			msg -bar3
			blanco "	Usuario > ${user[$opcion]} renovado hasta $(date '+%y-%m-%d' -d " +$dias days")"
			start_animation; sleep 2; stop_animation; echo
			tput cuu1 >&2 && tput dl1 >&2
		  }
		}
	done
restroj
continuar
read foo
}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
	title "	ELIMINAR USUARIO TROJAN"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = chumoghscript ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "${Usr}" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d "|" -f2 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
			col "$n)" "$Usr" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
			let n++
		}
	done
	msg -bar3
	col "0)" "VOLVER"
	msg -bar3
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion
	[[ -z $opcion ]] && vacio && sleep 0.3 && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.3
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.3
		} || {
			
			[[ $opcion>=${p} ]] && {
			sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			mv $config $temp 
			sed -i "/${expUser[$opcion]}/d" $user_conf
			sed "/${userd[$opcion]}/ d" $temp > $config
			chmod 777 $config
			rm $temp
			clear
			msg -bar3
			blanco "	Usuario ${userd[$opcion]}${expUser[$opcion]} eliminado"
			msg -bar3
			sleep 0.5s
			}
		}
	
	}
	done
	restroj
}

bakc() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mRestaurar Copia"
		msg -bar3
		col "2)" "\033[1;33mCrear Copia"
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)[[ -e config.json ]] && cp config.json /usr/local/etc/trojan/config.json || echo "No existe Copia";;
			2)[[ -e /usr/local/etc/trojan/config.json ]] && cp /usr/local/etc/trojan/config.json config.json || echo "No existe Copia";;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done


}

reintro() {
clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mReinstalar Servicio"
		msg -bar3
		col "2)" "\033[1;33mReiniciar Servicio"
		msg -bar3
		col "3)" "\033[1;33mEditar Manual ( nano )"
		msg -bar3
		col "4)" "\033[1;33mREGISTRAR DOMINIO "
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			trojan
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			restroj
			} || echo -e  "Servicio No instalado Aun"
			;;
			3)
			nano /usr/local/etc/trojan/config.json
			;;
			4)
			dmn=$(echo "$(ls /root/.acme.sh | grep '_ecc')" | sed 's/_ecc//')
			echo -e " INGRESA TU DOMINIO REGISTRADO EN TU CERTIFICADO "
			echo -e "                +    OJO     +"
			echo -e "  Si validaste tu certificado con dominio ACME"
			echo -e "        Se tomara tu dominio automatico"
			read -p " DIGITA TU DOMINIO : " -e -i $dmn domain
			echo "$domain" > /etc/trojan/domain
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 3" && sleep 0.3;;
		esac
	done


continuar
read foo
}

cattro () {

clear
	while :
	do
	clear
		#col "5)" "\033[1;33mCONFIGURAR Trojan"
		msg -bar3
		col "1)" "\033[1;33mMostrar fichero de CONFIG "
		msg -bar3
		col "2)" "\033[1;33mEditar Config Manual ( Comando nano )"
		msg -bar3
		col "3)" "\033[1;33m Cambiar RUTA CERTIFICADO"
		msg -bar3
		col "4)" "\033[1;33m CAMBIAR SNI INTERNO"
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "opcion" 0
		read opcion
		case $opcion in
			1)
			title "Fichero Interno Configurado"
			cat /usr/local/etc/trojan/config.json
			blanco "Fin Fichero "
			continuar
			read foo
			;;
			2)
			[[ -e /usr/local/etc/trojan/config.json ]] && {
			title "Fichero Interno Configurado"
			nano /usr/local/etc/trojan/config.json
			restroj
			} || echo -e  "Servicio No instalado Aun"
			;;
			3)
			changeCERT
			restroj
			;;
			4)
			changeSNI
			restroj
			;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 2" && sleep 0.3;;
		esac
	done
continuar
}

log_ACCESS () {
clear&&clear
tail -f /root/server.log
continuar
return
}

view_user(){
unset opcion
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
	nick="$(cat $config | grep ',"')"
	users="$(cat $config | jq -r .password[])"
		title "	VER USUARIO TROJAN"
		userDat


		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = chumoghscript ]] && {
				Usr="Admin"
				DateExp=" Ilimitado"
			} || {
			Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "${Usr}" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "VER DATOS DEL USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3 && continue
		[[ $opcion = 0 ]] && break
		n=1
		unset i
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp
				Usr="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f1)"
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			#col "$n)" "$i" "$DateExp" "$exp"
		#[[ $n = $opcion ]] && trojanpass=$i && dataEX=$DateExp && dEX=$exp
		#[[ $n = $opcion ]] && trojanpass=$i && dataEX=$DateExp && dEX=$exp
				let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		host=$(cat $config | jq -r .ssl.sni)
		trojanport=$(cat $config | jq -r .local_port)
		UUID=$(cat $config | jq -r .password[$opcion])
		DateExp="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		exp="[$(($(($seg_exp - $seg)) / 86400))]"
		Usr="$(cat ${user_conf}|grep -w "${UUID}"|cut -d'|' -f1)"
		[[ $host = null ]] && read -p " Host / SNI : " host
		[[ -z $host ]] && host="null"
		clear&&clear
		msg -bar3
		blanco "              TROJAN LINK CONFIG"
		msg -bar3
		col "$opcion)" "${Usr}" "$DateExp" "$exp" #"${UUID}"
		trojan_conf
		msg -bar3
		continuar
		read foo
	done
}

trojan_conf (){
[[ -e /etc/trojan/domain ]] && domain=$(cat < /etc/trojan/domain)
		msg -bar3
		col2 " Remarks   : " "${Usr}"
		[[ -z $domain ]] || col2 " DOMAIN    : " "$domain"
		col2 " IP-Address: " "$addip"
		col2 " Port      : " "$trojanport"
		col2 " Password  : " "$UUID"
		[[ $(cat $config | jq -r .websocket.enabled) = "true" ]] && col2 " NetWork   : " "WS/TCP" || col2 " NetWork   : " "TCP"
		[[ ! -z $host ]] && col2 " Host/SNI  : " "$host"
		msg -bar3
		echo " CONFIG TCP NATIVA"
		echo -e "\033[3;32m trojan://$(echo $UUID@$addip:$trojanport?sni=$host#"${Usr}" )\033[3;32m"
		msg -bar3
		echo -ne "$(msg -verd "") $(msg -verm2 " ") "&& msg -bra "\033[1;41mEn APPS como HTTP Inyector,CUSTOM,Trojan,etc"
		[[ $(cat $config | jq -r .websocket.enabled) = "true" ]] && echo -e "\033[3;32m trojan://$UUID@$IP:$trojanport?path=%2F&security=tls&type=ws&sni=$host\033[3;32m" || echo -e "\033[3;32m trojan://$(echo $UUID@$addip:$trojanport?sni=$host#"${Usr}" )\033[3;32m"
		msg -bar3
		[[ -z $domain ]] || echo -e "\033[3;32m trojan://$(echo $UUID@$domain:$trojanport?sni=$host#"${Usr}" )\033[3;32m"

}

mainT(){
[[ ! -e /etc/chekKEY ]] && chekKEY &>/dev/null && touch /etc/chekKEY
local opcion
	[[ ! -e $config ]] && {
		clear
		msg -bar3
		blanco " No se encontro ningun archovo de configracion Trojan"
		msg -bar3
		blanco "	  No instalo Trojan o esta usando\n	     una vercion diferente!!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion Trojan diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
	}
	while :
	do
		_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
		_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
		[[ -e /bin/troj.sh ]] && enrap="\033[1;92m[ ACT ]" || enrap="\033[0;31m[ DESC ]"
		[[ -e $configLOCK ]] && local _v2LOCK="$(cat $configLOCK|wc -l)" || local _v2LOCK=0
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU Trojan \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR NUEVO USUARIO "
		col "2)" "\033[0;92mRENOVAR UN USUARIO "
		col "3)" "\033[0;31mREMOVER UN USUARIO "
		col "4)" "VER USUARIOS REGISTRADOS \033[1;32m( $(cat $user_conf | wc -l) )"
		col "5)" "VER USUARIOS CONECTADOS "
		col "b)" "LOCK/UNLOCK USUUARIO $_v2LOCK"
		msg -bar3
		col "6)" "\033[1;33mENTRAR CON  \033[1;31mtroj.sh $enrap"
		msg -bar3
		col "7)" "\033[1;33mMostrar/Editar Fichero interno"
		col "8)" "\033[1;33mMenu Avanzado Trojan"
		col "9)" "\033[1;33mConf. Copias de Respaldo"	
		col "10)" "\033[1;33m LOG DE ACTIVIDAD"	
		msg -bar3
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		msg -bar3
		blanco "SELECCION : " 0
		read opcion

		case $opcion in
			1)add_user;;
			2)renew;;
			3)dell_user;;
			4)view_user;;
			5)log_traff;;
			6)enttrada;;
			7)cattro;;
			8)reintro;;
			9)backups;;
			10)log_ACCESS;;
			b);;
			0) rm -f /etc/chekKEY && break;;
			*) blanco "\n selecione una opcion del 0 al 10" && sleep 0.3s;;
		esac
	done
}
#while [[ $? -eq 0 ]]; do
#[[ $1 = "--restart" ]] && restroj
#[[ $? -eq 0 ]] && main
#done
mainT
}

Call.BannerPersonalizado () {
clear
local="/etc/bannerssh"
msg -bar3
echo -e "\033[1;37m ∆ Linux Dist: $_os\033[0m"
msg -bar3
echo -e "\033[1;37m - BANNER Manipulado -  \033[0m"
msg -bar3
echo -e "\033[1;37mSeleccione su Sistema:    Para Salir Ctrl + C o 0 Para Regresar${cor[5]}"
echo -e " \033[1;31m[ !!! ]${cor[5]} PEGA AQUI TU BANNER   \033[1;31m${cor[5]}"
msg -bar3
echo -e " \033[1;31mLuego de Pegar tu banner Presiona Ctrl + O y Enter ${cor[5]} \033[1;31m${cor[5]}"
echo -e " \033[1;31m          Por Ultimo Ctrl + X  ${cor[5]} \033[1;31m${cor[5]}"
echo -ne "\033[1;37m"
read -p " Presiona Enter para Continuar "
apt install nano -y > /dev/null 2>&1
nano /bin/ejecutar/bannerssh
cat /bin/ejecutar/bannerssh > /etc/bannerssh
rm /bin/ejecutar/bannerssh
fun_bar
#[[ ! -e /root/name ]] && credi="@ChumoGH" || credi=$(cat < /root/name)
#echo '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'$(cat /bin/ejecutar/menu_credito)'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'$credi'</strong></span></p>' >> /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || men="NO EXISTE DROPBEAR"
msg -bar3
echo -ne " \033[1;31m[ ! ] VERIFICANDO DROPBEAR "
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && { 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]"  || {
echo -e "\033[1;31m - BANNER INCOMPATIBLE CON DROPBEAR -\n" && echo "DESTRUYENDO DISEÑO" 
echo "" > /etc/dropbear/banner 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]"
}
} || echo -e "\033[0;35m [ $men ]"
echo -ne " \033[1;31m[ ! ] VERIFICANDO SSH"
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
sleep 0.1s
exit 
}

txt_font () {
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]${cor[5]} Letra Pequeña"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]${cor[5]} Letra Media"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]${cor[5]} Letra Grande"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]${cor[5]} Letra ExtraGrande"
echo ""
echo -ne "${cor[2]}Escoje el Tamaño de Letra\033[1;31m ?\033[1;37m : "; read opc
if [[ "$opc" = "1" ]] || [[ "$opc" = "01" ]]; then
_size='6'
elif [[ "$opc" = "2" ]] || [[ "$opc" = "02" ]]; then
_size='4'
elif [[ "$opc" = "3" ]] || [[ "$opc" = "03" ]]; then
_size='3'
elif [[ "$opc" = "4" ]] || [[ "$opc" = "04" ]]; then
_size='1'
else
_size='6'
fi
msg -bar3
echo -ne "\033[1;37m"
read -p " INGRESA TU MENSAJE : " ban_ner2
msg -bar3
unset x
echo -e "\033[1;42m Deseas centrar el contenido del banner\033[0;33m  :v"
echo ""
echo -ne "\033[0;32m Responde [ s | n ] : " && read -e -i "s" x
msg -bar3
[[ "$x" = @(s|S|y|Y) ]] && echo -e '<p style="text-align: center;">' >> /etc/bannerssh
echo -e " \033[1;31m[ 1 ]${cor[5]} > VERDE         \033[1;31m[ 9  ]${cor[5]} > AZUL PIZARRA OSCURO"
echo -e " \033[1;31m[ 2 ]${cor[5]} > ROJO          \033[1;31m[ 10 ]${cor[5]} > MAGENTA"
echo -e " \033[1;31m[ 3 ]${cor[5]} > AZUL          \033[1;31m[ 11 ]${cor[5]} > CHOCOLATE"
echo -e " \033[1;31m[ 4 ]${cor[5]} > AMARILLO      \033[1;31m[ 12 ]${cor[5]} > VERDE CLARO"
echo -e " \033[1;31m[ 5 ]${cor[5]} > PURPURA       \033[1;31m[ 13 ]${cor[5]} > GRIS"
echo -e " \033[1;31m[ 6 ]${cor[5]} > Naranja       \033[1;31m[ 14 ]${cor[5]} > VERDE MAR"
echo -e " \033[1;31m[ 7 ]${cor[5]} > Crema         \033[1;31m[ 15 ]${cor[5]} > CIAN OSCURO"
echo -e " \033[1;31m[ 8 ]${cor[5]} > Cyano         \033[1;31m[ *  ]${cor[5]} > Negro"
read -p " Digite A Cor [ 1 ⇿ 15 ]: " ban_ner2_cor
if [[ "$ban_ner2_cor" = "1" ]]; then
echo '<h'$_size'><font color="green">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "2" ]]; then
echo '<h'$_size'><font color="red">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "3" ]]; then
echo '<h'$_size'><font color="blue">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "4" ]]; then
echo '<h'$_size'><font color="yellow">' >> /etc/bannerssh
elif [[ "$ban_ner2_cor" = "5" ]]; then
echo '<h'$_size'><font color="purple">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "6" ]; then
echo '<h'$_size'><font color="#FF7F00">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "7" ]; then
echo '<h'$_size'><font color="#AEB404">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "8" ]; then
echo '<h'$_size'><font color="cyan">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "9" ]; then
echo '<h'$_size'><font color="#483D8B">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "10" ]; then
echo '<h'$_size'><font color="#FF00FF">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "11" ]; then
echo '<h'$_size'><font color="#D2691E">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "12" ]; then
echo '<h'$_size'><font color="#90EE90">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "13" ]; then
echo '<h'$_size'><font color="#BEBEBE">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "14" ]; then
echo '<h'$_size'><font color="#2E8B57">' >> /etc/bannerssh
elif [ "$ban_ner2_cor" = "15" ]; then
echo '<h'$_size'><font color="#008B8B">' >> /etc/bannerssh
else
echo '<h'$_size'><font color="black">' >> /etc/bannerssh
fi
echo "$ban_ner2" >> /etc/bannerssh
echo "</h"$_size"></font>" >> /etc/bannerssh
[[ "$x" = @(s|S|y|Y) ]] && echo "</p>" >> /etc/bannerssh
}

function_7 () {
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
tput cuu1 && tput dl1
msg -bar3
echo -e "${cor[2]}MENU BANNER  (RECOMENDADO 2):
 $(msg -bar3)"
 echo -e "\033[0;35m [\033[0;36m01\033[0;35m]\033[0;31m >${cor[3]} Pegar BANNER Personalizado ( html , etc )"
 echo -e "\033[0;35m [\033[0;36m02\033[0;35m]\033[0;31m >${cor[3]} AGREGAR MENSAJES BANNER SSH"
 echo -e "\033[0;35m [\033[0;36m03\033[0;35m]\033[0;31m >${cor[3]} ELIMINAR BANNER ( SSH ⇿ DROPBEAR )"
 msg -bar3
 echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m > $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3
selection=$(selection_fun 3)
case ${selection} in
1)
unset sshsn
unset sin_nao
echo -e " Al escojer que coloques tu Banner creado fuera del Script, ADM no se "
echo -e "    Responsabiliza por el Fallo de ciertos recursos del SISTEMA"
echo -e "RECUERDA QUE EL SCRIPT ESTA REALIZADO PARA FUNCIONAR CON SUS FUNCIONES"
echo -e "                          Y esta es EXPERIMENTAL"
echo -e "Esta SEGURO de usar esta funcion ?:"
read -p " [S/N]: " -e -i n sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
local2="/etc/bannerssh"
chk=$(cat /etc/ssh/sshd_config | grep Banner)
if [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 else
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
local="/etc/bannerssh"
fi
while true; do
echo -e " ESTAS SEGURO QUE TIENES TU BANNER BIEN ESTRUCTURADO "
read -p " [ s | n ]: " sin_nao
 if [[ "$sin_nao" = @(s|S|y|Y) ]]; then
 Call.BannerPersonalizado
 elif [[ "$sin_nao" = @(n|N) ]]; then
 break
 fi
done
}
;;
2)
unset sshsn
unset sin_nao
echo -e "${cor[3]} Buena ELECCION, Tienes un 99% mas Garantia"
echo -e "${cor[3]} Esta SEGURO:"
read -p " [S/N]: " -e -i s sshsn
[[ "$sshsn" = @(s|S|y|Y) ]] && {
local2="/etc/bannerssh"
chk=$(cat /etc/ssh/sshd_config | grep Banner)
if [ "$(echo "$chk" | grep -v "#Banner" | grep Banner)" != "" ]; then
local=$(echo "$chk" |grep -v "#Banner" | grep Banner | awk '{print $2}')
 else
echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
local="/etc/bannerssh"
fi
msg -bar3
echo -e "\n\033[1;31m[\033[1;36m01\033[1;31m]${cor[5]} Letra Pequeña"
echo -e "\033[1;31m[\033[1;36m02\033[1;31m]${cor[5]} Letra Media"
echo -e "\033[1;31m[\033[1;36m03\033[1;31m]${cor[5]} Letra Grande"
echo -e "\033[1;31m[\033[1;36m04\033[1;31m]${cor[5]} Letra ExtraGrande"
echo ""
echo -ne "${cor[2]}Escoje el Tamaño de Letra\033[1;31m ?\033[1;37m : "; read opc
if [[ "$opc" = "1" ]] || [[ "$opc" = "01" ]]; then
_size='6'
elif [[ "$opc" = "2" ]] || [[ "$opc" = "02" ]]; then
_size='4'
elif [[ "$opc" = "3" ]] || [[ "$opc" = "03" ]]; then
_size='3'
elif [[ "$opc" = "4" ]] || [[ "$opc" = "04" ]]; then
_size='1'
else
_size='6'
fi
msg -bar3
echo -ne "\033[1;37m"
read -p " INGRESA TU MENSAJE : " ban_ner
msg -bar3
echo -e " \033[1;31m[ 1 ]${cor[5]} > VERDE         \033[1;31m[ 9  ]${cor[5]} > AZUL PIZARRA OSCURO"
echo -e " \033[1;31m[ 2 ]${cor[5]} > ROJO          \033[1;31m[ 10 ]${cor[5]} > MAGENTA"
echo -e " \033[1;31m[ 3 ]${cor[5]} > AZUL          \033[1;31m[ 11 ]${cor[5]} > CHOCOLATE"
echo -e " \033[1;31m[ 4 ]${cor[5]} > AMARILLO      \033[1;31m[ 12 ]${cor[5]} > VERDE CLARO"
echo -e " \033[1;31m[ 5 ]${cor[5]} > PURPURA       \033[1;31m[ 13 ]${cor[5]} > GRIS"
echo -e " \033[1;31m[ 6 ]${cor[5]} > Naranja       \033[1;31m[ 14 ]${cor[5]} > VERDE MAR"
echo -e " \033[1;31m[ 7 ]${cor[5]} > Crema         \033[1;31m[ 15 ]${cor[5]} > CIAN OSCURO"
echo -e " \033[1;31m[ 8 ]${cor[5]} > Cyano         \033[1;31m[ *  ]${cor[5]} > Negro"
read -p " [ 1 ⇿ 15 ]: " ban_ner_cor
unset local 
unset x
echo -e "\033[1;42m Deseas centrar el contenido del banner\033[0;33m  :v"
echo ""
echo -ne "\033[0;32m Responde [ s | n ] : " && read -e -i "s" x
msg -bar3
[[ "$x" = @(s|S|y|Y) ]] && echo -e '<p style="text-align: center;">' > /etc/bannerssh
if [[ "$ban_ner_cor" = "1" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="green">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "2" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="red">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "3" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="blue">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "4" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="yellow">' >> /etc/bannerssh
elif [[ "$ban_ner_cor" = "5" ]]; then
echo '<h'$_size' style="text-align:center;"><font color="purple">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "6" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#FF7F00">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "7" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#AEB404">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "8" ]; then
echo '<h'$_size' style="text-align:center;"><font color="cyan">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "9" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#483D8B">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "10" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#FF00FF">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "11" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#D2691E">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "12" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#90EE90">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "13" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#BEBEBE">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "14" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#2E8B57">' >> /etc/bannerssh
elif [ "$ban_ner_cor" = "15" ]; then
echo '<h'$_size' style="text-align:center;"><font color="#008B8B">' >> /etc/bannerssh
else
echo '<h'$_size' style="text-align:center;"><font color="black">' >> /etc/bannerssh
fi
echo "$ban_ner" >> /etc/bannerssh
echo '</font></h'$_size'>' >> /etc/bannerssh
[[ "$x" = @(s|S|y|Y) ]] && echo "</p>" >> /etc/bannerssh
while true; do
echo -e " DESEAS AÑADIR MAS TEXTOS A TU BANNER?"
read -p " [ s | n ]: " sin_nao
 if [[ "$sin_nao" = @(s|S|y|Y) ]]; then
 txt_font
 elif [[ "$sin_nao" = @(n|N) ]]; then
 break
 fi
done
[[ -e /root/name ]] && credi=$(cat < /root/name) || credi="@ChumoGH"
credit=$(cat < /bin/ejecutar/menu_credito | head -1)
echo -e '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'" $credit "'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'"$credi"'</strong></span></p>' >> /etc/bannerssh
#echo '<font color="#FF00FF">© 2020 ChumoGH, &reg</font>' >> /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || men="NO EXISTE DROPBEAR"
msg -bar3
echo -ne " \033[1;31m[ ! ] VERIFICANDO DROPBEAR "
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && { 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]"  || {
echo -e "\033[1;31m ▢ BANNER INCOMPATIBLE CON DROPBEAR -\n" && echo "DESTRUYENDO DISEÑO" 
echo "" > /etc/dropbear/banner 
/etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]"
}
} || echo -e "\033[0;35m [ $men ]" 
echo -ne " \033[1;31m[ ! ] VERIFICANDO SSH "
service ssh restart > /dev/null 2>&1
service sshd restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
}
return 0
;;
3)
echo "Verificando existencia de BANNER"
echo ""
[[ -e /etc/bannerssh ]] && {
 echo "DESTRUYENDO BANNER SSH " 
 echo "" > /etc/bannerssh
 } || echo "NO EXISTE BANNER DROPBEAR ESTRUCTURADO"
 [[ -e /etc/dropbear/banner ]] && {
 echo "DESTRUYENDO BANNER DROPBEAR " 
 echo "" > /etc/dropbear/banner
 } || echo "NO EXISTE BANNER SSH ESTRUCTURADO"
 return 0
;;
*)
echo "LO SENTIMOS DIGITASTE MAL"
sleep 0.1s
return 0
;;
esac
#TERMINA CASE
}

Call.CONTROLADOR () {

_SFTP="$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep apache2)"
[[ -z ${_SFTP} ]] && _SFTP="$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep nginx)"
portFTP=$(echo -e "$_SFTP" |cut -d: -f2 | cut -d' ' -f1 | uniq)
portFTP=$(echo ${portFTP} | sed 's/\s\+/,/g' | cut -d , -f1)
[[ -z ${portFTP} ]] && portFTP='X0'
sslkk (){
local _netCAT="$(netstat -tunlp)"
sslports=`echo -e "${_netCAT}" | awk '/stunnel/ && /0.0.0.0:/ {print substr($4, 9)}'`;
#pt=$(echo -e "${_netCAT}" |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
pt=$(echo -e "${_netCAT}" | awk '/ssh/ && /0.0.0.0:/ {print substr($4, 9)}' | head -1)
}
#par=$(v2ray info | grep path |awk -F : '{print $4}')
verif_ptrs() {
		porta=$1
		PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
		for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
			svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
			[[ "$porta" = "$pton" ]] && {
				echo -e "\n\033[1;31mPUERTO ${cor[5]}$porta \033[1;31mESTA EN USO POR \033[1;37m$svcs\033[0m"
				sleep 0.5
				return 0
			}
		done
	}

fun_log () {
[[ -e /bin/ejecutar/sshd_config ]] && { 
####
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] || sed -i "s%/bin/false%filemancgh%g" /etc/shells
[[ ! $(cat /etc/shells|grep "/usr/sbin/nologin") ]] || sed -i "s%/usr/sbin/nologin%filemancgh%g" /etc/shells
sed -i "/filemancgh/d" /etc/shells
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
} || {
cp /etc/ssh/sshd_config /bin/ejecutar/sshd_config
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] || sed -i "s%/bin/false%filemancgh%g" /etc/shells
[[ ! $(cat /etc/shells|grep "/usr/sbin/nologin") ]] || sed -i "s%/usr/sbin/nologin%filemancgh%g" /etc/shells
sed -i "/filemancgh/d" /etc/shells
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
}
}

ban_inex () {
ban=$(cat < /etc/adm-lite/menu_credito | head -1)
echo -e " "
echo -e "BANNER INEXISTENTE - RECOMENDADO MODIFICAR TU BANNER"
_sleepColor '2'
credit=$(cat </etc/adm-lite/menu_credito | head -1)
[[ -e /root/name ]] && credi="$(cat < /root/name)" || credi="${credit}"
echo -e '<p style="text-align: center;"> <big><big><big><big><big><big>🐲</big></big></big></big></big></big></p>' > /etc/bannerssh
echo -e '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'" $credit "'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'"$credi"'</strong></span></p>' >> /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || {
mkdir /etc/dropbear
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
}
echo -e "${cor[2]}Cambia Banner en ( * ${cor[5]} Menu 1${cor[2]} *${cor[5]} opcion 6 ${cor[2]}*${cor[2]})"
read -p "Presiona Enter para Continuar"
clear&&clear
dropbearuniversal
}

function dropbearuniversal(){
echo -e " PREPARANDO SYSTEM PARA AVANZAR °°°°° \n  RECUERDA COLOCAR 1 PUERTO A LA VEZ !!!"
echo -ne "\033[1;31m[ ! ] RESOLVIENDO SSH -> DROPBEAR  "
(
service dropbear stop 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
) && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne "\033[1;31m[ ! ] VERIFICANDO COMPATIBILIDAD DEL BANNER " && sleep 0.5s && echo -e "${cor[2]} [OK]"
[[ -e /etc/bannerssh ]] && {
####
fun_log
####
echo " > INSTALANDO SERVICIO DROPBEAR !!!"
_sleepColor '' 'apt install dropbear -y'
service dropbear stop &>/dev/null
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo -e " PUERTOS RECOMENDADOS A USAR ( 80/90/100/443  Default 143 )"
	echo -e " "
    read -p " PUERTO DROPBEAR : " puertodropbear -e -i "143"
	tput cuu1 && tput dl1
	PortDROP=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $puertodropbear`
	[[ -n "$PortDROP" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$puertodropbear"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
    unset puertodropbear
	msg -bar3
    done
msg -bar3
echo $puertodropbear > /etc/default/dadd
echo -e 'NO_START=0' > /etc/default/dropbear
echo -e '# the TCP port that Dropbear listens on' >> /etc/default/dropbear 
echo -e '#DROPBEAR_PORT=22' >> /etc/default/dropbear
echo -e 'DROPBEAR_EXTRA_ARGS="-p '$puertodropbear'"' >> /etc/default/dropbear
echo -e 'DROPBEAR_BANNER="/etc/dropbear/banner"' >> /etc/default/dropbear
echo -e "DROPBEAR_RECEIVE_WINDOW=65536" >> /etc/default/dropbear
[[ ! $(cat /etc/shells|grep "/bin/false") ]] || sed -i "s%/bin/false%filemancgh%g" /etc/shells
[[ ! $(cat /etc/shells|grep "/usr/sbin/nologin") ]] || sed -i "s%/usr/sbin/nologin%filemancgh%g" /etc/shells
sed -i "/filemancgh/d" /etc/shells
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
[[ ! -e /etc/dropbear/banner ]] && touch /etc/dropbear/banner || cat /etc/bannerssh > /etc/dropbear/banner 
service dropbear stop 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
service sshd restart 1>/dev/null 2>/dev/null &
service dropbear restart &>/dev/null
dropbearports=`netstat -tunlp | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
echo -e "\033[1;31m â€?? DROPBEAR SE EJECUTA EN PUERTO\033[0m" $dropbearports " ESCOJIDO " $puertodropbear
[[ -f "/usr/sbin/ufw" ]] && ufw allow $puertodropbear/tcp 1>/dev/null 2>/dev/null &
fun_eth
return 0
 } || {
ban_inex
return 1
}
}

meu_ip

#ETHOOL SSH
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    msg -bar3
    echo -e "${cor[3]}  Aplicar Sistema Para Mejorar Sistema SSH?"
    echo -e "${cor[3]}  Opcion Para Usuarios Avanzados"
    msg -bar3
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]}  Correcion de problemas de paquetes en SSH..."
           echo -e "  Quota en Entrada"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e "  Quota en Salida"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     msg -bar3
     }
}

squid_cache () {
msg -bar3
echo -e "${cor[5]} CachÃ© de Squid no es mÃ¡s Que
 Un historial de navegaciÃ³n en Squid
 Que ahorrarÃ¡ datos al abrir sitios
 Alojados en su cachÃ© 
 Â¡El script harÃ¡ una breve comprobaciÃ³n!"
msg -bar3
sleep 0.5s
if [ -e /etc/squid/squid.conf ]; then
squid_var="/etc/squid/squid.conf"
elif [ -e /etc/squid3/squid.conf ]; then
squid_var="/etc/squid3/squid.conf"
else
echo -e "${cor[5]} No se ha identificado Squid!"
return 1
fi
teste_cache="#CACHE DO SQUID"
if [[ `grep -c "^$teste_cache" $squid_var` -gt 0 ]]; then
  [[ -e ${squid_var}.bakk ]] && {
  echo -e "${cor[5]} Desactivando SquidCache !!\n ESPERA PORFAVOR !"
  mv -f ${squid_var}.bakk $squid_var
  echo -e "${cor[5]} COLOCAR ARCHIVO ONLINE"
  msg -bar3
  service squid restart > /dev/null 2>&1
  service squid3 restart > /dev/null 2>&1
  return 0
  }
fi
echo -e "${cor[5]} Â¡Squid esta Activo en tu sistema!\n ${cor[5]} No hay servicio de cachÃ© en el Squid!\n Activando el servicio SquidCache!"
msg -bar3
_tmp="#CACHE DO SQUID\ncache_mem 200 MB\nmaximum_object_size_in_memory 32 KB\nmaximum_object_size 1024 MB\nminimum_object_size 0 KB\ncache_swap_low 90\ncache_swap_high 95"
[[ "$squid_var" = "/etc/squid/squid.conf" ]] && _tmp+="\ncache_dir ufs /var/spool/squid 100 16 256\naccess_log /var/log/squid/access.log squid" || _tmp+="\ncache_dir ufs /var/spool/squid3 100 16 256\naccess_log /var/log/squid3/access.log squid"
while read s_squid; do
[[ "$s_squid" != "cache deny all" ]] && _tmp+="\n${s_squid}"
done < $squid_var
cp ${squid_var} ${squid_var}.bakk
echo -e "${_tmp}" > $squid_var
echo -e "${cor[5]} Reiniciando Servicios Espera!\n ESPERA PORFAVOR!"
msg -bar3
service squid restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
}

add_host_squid () {
payload="/etc/payloads"
if [ ! -f "$payload" ]; then
echo -e "${cor[5]} $payload No econtrado"
echo -e "${cor[5]} Squid no instalado"
return
fi
msg -bar3 
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m${cor[3]} AÃ±adir NUEEVO Host a Squid"
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m${cor[3]} Quitar 1 host de Squid"
msg -bar3 
read -p " | 1 - 2 |: " var_payload
number_var $var_payload
[[ -z $var_number ]] && echo -e "\033[1;31m Opcion Invalida" && return
[[ $var_payload -gt 2 ]] && echo -e "\033[1;31m Opcion Invalida" && return
[[ "$var_payload" = "1" ]] && {
echo -e "${cor[4]} AÃ±adir Host a Squid"
echo -e "${cor[5]} Dominios actuales en el archivo $payload:"
msg -bar3 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar3 
echo "Escriba el Host-Squid que desea agregar "
read -p "Iniciando con un ., ejemplo: .whatsapp.net: " hos
if [[ $hos != \.* ]]; then
echo -e "${cor[5]} Iniciando con un ., ejemplo: .whatsapp.net: "
return
fi
host="$hos/"
if [[ -z $host ]]; then
echo -e "${cor[5]} !¡Esta vacioo, no ha escrito nada!"
return
fi
if [[ `grep -c "^$host" $payload` -eq 1 ]]; then
echo -e "${cor[5]} El dominio ya existe en el archivo"
return
fi
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[5]} Â¡Ã‰xito, Archivo Actualizado!"
msg -bar3 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar3 
 if [ ! -f "/etc/init.d/squid" ]; then
service squid3 reload
service squid3 restart
 else
/etc/init.d/squid reload
service squid restart
 fi	
return
}

[[ $var_payload = 2 ]] && {
echo -e "${cor[4]} Quitar el host de Squid"
echo -e "${cor[5]} Dominios actuales en el archivo $payload:"
msg -bar3 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar3 
read -p " $(echo -e "Escriba el dominio que desea quitar\n") Iniciando con un ( . ), ejemplo: .chumogh.net: " hos
if [[ $hos != \.* ]]; then
echo -e "${cor[5]} Iniciando con un ( . ), ejemplo: .chumogh.net"
return
fi
host="$hos/"
if [[ -z $host ]]; then
echo -e "${cor[5]} Â¡Esta vacÃ­o, no ha escrito nada!"
return
fi
if [[ `grep -c "^$host" $payload` -ne 1 ]]; then
echo -e "${cor[5]} DOMINIO NO ENCONTRADO"
return
fi
grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[5]} ARCHIVO ACTUALIZADO EXITOSAMENTE!"
msg -bar3 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar3 
 if [ ! -f "/etc/init.d/squid" ]; then
service squid3 reload
service squid3 restart
 else
/etc/init.d/squid reload
service squid restart
 fi	
return
}
}

add_port(){
	if [[ -e /etc/squid/squid.conf ]]; then
    	local CONF="/etc/squid/squid.conf"
  	elif [[ -e /etc/squid3/squid.conf ]]; then
    	local CONF="/etc/squid3/squid.conf"
  	fi
  	local miport=$(cat ${CONF}|grep -w 'http_port'|awk -F ' ' '{print $2}'|tr '\n' ' ')
  	local line="$(cat ${CONF}|sed -n '/http_port/='|head -1)"
  	local NEWCONF="$(cat ${CONF}|sed "$line c ADMR_port"|sed '/http_port/d')"
  	msg -ama "$(echo -e "AGREGAR UN PUERTOS SQUID")"
 	echo -e " $(msg -verm2 "Ingrese Sus Puertos:") $(msg -verd "80 8080 8799 3128")"
  	msg -bar3
  	msg -ne " $(echo -e " Digite Puertos"): " && read DPORT
  	tput cuu1 && tput dl1
  	TTOTAL=($DPORT)
  	for((i=0; i<${#TTOTAL[@]}; i++)); do
  		[[ $(mportas|grep -v squid|grep -v '>'|grep -w "${TTOTAL[$i]}") = "" ]] && {
      		echo -e "${cor[5]} Puerto Elegido:${cor[2]} ${TTOTAL[$i]} OK"
      		PORT="$PORT ${TTOTAL[$i]}"
    	} || {
      		echo -e "${cor[5]} Puerto Elegido:\033[1;31m ${TTOTAL[$i]} FAIL"
    	}
  	done
  	[[  -z $PORT ]] && {
    	msg -bar3
    	msg -verm2 "Ningun Puerto Valido"
    	return 1
  	}
  	PORT="$miport $PORT"
  	rm ${CONF}
  	while read varline; do
  		if [[ ! -z "$(echo "$varline"|grep 'ADMR_port')" ]]; then
      		for i in `echo $PORT`; do
        	echo -e "http_port ${i}" >> ${CONF}
        	ufw allow $i/tcp &>/dev/null 2>&1
      		done
      		continue
    	fi
    	echo -e "${varline}" >> ${CONF}
  	done <<< "${NEWCONF}"
  	msg -bar3
  	msg -azu "$(echo -e "AGUARDE REINICIANDO SERVICIOS")"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	msg -verd "$(echo -e "PUERTOS AGREGADOS")"
  	return 1
}

del_port(){
	squidport=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN"|grep -E 'squid|squid3')

	if [[ $(echo "$squidport"|wc -l) -lt '2' ]];then
		clear
		msg -bar3
		msg -ama "Un solo puerto para eliminar\ndesea detener el servicio?	"
		msg -bar3
		msg -ne " opcion [S/N]: " && read a

		if [[ "$a" = @(S|s) ]]; then
			msg -ama "AGUARDE DETENIEDO SERVICIOS"
			[[ -d "/etc/squid/" ]] && {
				if service squid stop &> /dev/null ; then
					msg -verd "Servicio squid detenido"
				else
					msg -verm2 "Falla al detener Servicio squid"
				fi
			}
			[[ -d "/etc/squid3/" ]] && {
				if service squid3 stop &> /dev/null ; then
					msg -verd "Servicio squid3 detenido"
				else
					msg -verm2 "Falla al detener Servicio squid3"
				fi
			}		
		fi
		return 1
	fi

	if [[ -e /etc/squid/squid.conf ]]; then
    	local CONF="/etc/squid/squid.conf"
  	elif [[ -e /etc/squid3/squid.conf ]]; then
    	local CONF="/etc/squid3/squid.conf"
  	fi
	msg -ama "Quitar un puertos squid"
    n=1
    while read i; do
        port=$(echo $i|awk -F ' ' '{print $9}'|cut -d ':' -f2)
        echo -e " $(msg -verd "[$n]") $(msg -verm2 ">") $(msg -azu "$port")"
        drop[$n]=$port
        num_opc="$n"
        let n++ 
    done <<< $(echo "$squidport")
    back
    while [[ -z $opc ]]; do
        msg -ne " opcion: "
        read opc
        tput cuu1 && tput dl1
        if [[ -z $opc ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ ! $opc =~ $numero ]]; then
            msg -verm2 " selecciona solo numeros entre 1 y $num_opc"
            unset opc
            sleep 2
            tput cuu1 && tput dl1
            continue
        elif [[ "$opc" -gt "$num_opc" ]]; then
            msg -verm2 " selecciona una opcion entre 1 y $num_opc"
            sleep 2
            tput cuu1 && tput dl1
            unset opc
            continue
        fi
    done
    sed -i "/http_port ${drop[$opc]}/d" $CONF
  	msg -azu "$(echo -e "AGUARDE REINICIANDO SERVICIOS")"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	msg -verd "$(echo -e "PUERTO REMOVIDO")"
  	return 1	
}

restart_squid(){
	msg -ama "AGUARDE REINICIANDO SERVICIOS"
  	[[ -d "/etc/squid/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid start > /dev/null 2>&1
    	service squid restart > /dev/null 2>&1
  	}
  	[[ -d "/etc/squid3/" ]] && {
    	service ssh restart > /dev/null 2>&1
    	/etc/init.d/squid3 start > /dev/null 2>&1
    	service squid3 restart > /dev/null 2>&1
  	}
  	sleep 2s
  	tput cuu1 && tput dl1
  	msg -verd "$(echo -e "SERVICIO REINICIANDO")"
  	return 1
}

#INSTALADOR SQUID
fun_squid  () {

fsqd() {
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
apt install squid -y &> /dev/null
	rm -rf /tmp/* > /dev/null 2>&1
	killall kswapd0 > /dev/null 2>&1
	killall tcpdump > /dev/null 2>&1
	killall ksoftirqd > /dev/null 2>&1
	echo > /etc/fixsquid
}

function call.squid() {
	sleep .1
	helice() {
		fsqd >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m OPTIMIZANDO Y ${cor[2]}FIXEANDO \033[1;37mSQUID V3 ${cor[2]}.${cor[2]}.${cor[5]}.\033[1;31m. ${cor[5]}"
	helice
	echo -e "\e[1DOk"
}

[[ -e /etc/squid/squid.conf ]] && var_squid="/etc/squid/squid.conf"
[[ -e /etc/squid3/squid.conf ]] && var_squid="/etc/squid3/squid.conf"

 [[ -e $var_squid ]] && {
echo -e " MENU DE FUNCION SQUID "
msg -bar3
echo -e " \033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ${flech} ${cor[3]} SQUID CACHE $_cachesquid"
echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ${flech} ${cor[3]} AGREGAR / REMOVER HOST-SQUID"
echo -e " \033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m ${flech} ${cor[3]} AÑADIR UN PUERTO SQUID"
echo -e " \033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m ${flech} ${cor[3]} QUITAR UN PUERTO SQUID"
echo -e " \033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m ${flech} ${cor[3]} DESINSTALAR SQUID"
msg -bar3
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3
selection=$(selection_fun 5)
case ${selection} in
0)
return 0
;;
1)
squid_cache
return 0
;;
2)
add_host_squid
return 0
;;
3)
add_port
return 0
;;
4)
del_port
return 0
;;
5)
msg -bar3
  echo -e "${cor[2]}  REMOVIENDO SQUID"
    if [[ -e /etc/squid/squid.conf ]]; then
    var_squid="/etc/squid/squid.conf"
    mipatch="/etc/squid"
  elif [[ -e /etc/squid3/squid.conf ]]; then
    var_squid="/etc/squid3/squid.conf"
    mipatch="/etc/squid3"
  fi
  [[ -e $var_squid ]] && {
    clear
    msg -bar3
    msg -ama "$(echo -e "REMOVIENDO SQUID")"
    msg -ama "Aguarde un momento!!!"
    msg -bar3
    [[ -d "/etc/squid" ]] && {
      service squid stop > /dev/null 2>&1
      apt-get remove squid -y >/dev/null 2>&1
      apt-get purge squid -y >/dev/null 2>&1
      rm -rf /etc/squid >/dev/null 2>&1
    }
    [[ -d "/etc/squid3" ]] && {
      service squid3 stop > /dev/null 2>&1
      apt-get remove squid3 -y >/dev/null 2>&1
      apt-get purge squid3 -y >/dev/null 2>&1
      rm -rf /etc/squid3 >/dev/null 2>&1
    }
  }
  service squid stop > /dev/null 2>&1
  service squid3 stop > /dev/null 2>&1
  echo -e "${cor[2]}  Procedimento Concluido"
  msg -bar3
  [[ -e $var_squid ]] && rm $var_squid
  return 0
;;
esac
  }
  #Reiniciando
  service squid3 restart > /dev/null 2>&1
  service squid restart > /dev/null 2>&1
#Instalar
clear&&clear 
msg -bar3
echo -e "${cor[2]}  INSTALADOR SQUID ChumoGH-Script"
msg -bar3
meu_ip
echo -ne "  CONFIRME SU IP"; read -p ": " -e -i $IP ip
msg -bar3
echo -e "  DIJITA TUS PUERTOS  EN LA SIGUIENTE SECUENCIA"
echo -e "  SECUENCIA DE Ejemplo: 80 8080 3128"
echo -ne "  INGRESA TUS PUERTOS: "; read portasx
msg -bar3
totalporta=($portasx)
unset PORT
   for((i=0; i<${#totalporta[@]}; i++)); do
        [[ $(mportas|grep "${totalporta[$i]}") = "" ]] && {
        echo -e "${cor[5]}  Puertos Escojidos :${cor[2]} ${totalporta[$i]} OK"
        PORT+="${totalporta[$i]}\n"
		[[ -f "/usr/sbin/ufw" ]] && ufw allow ${totalporta[$i]}/tcp 1>/dev/null 2>/dev/null &
        } || {
        echo -e "${cor[5]}  Puertos Escojidos :\033[1;31m ${totalporta[$i]} FAIL"
        }
   done
  [[ "$(echo -e $PORT)" = "" ]] && {
  echo -e "\033[1;31m  No se ha elegido ningÃºn puerto vÃ¡lido\033[0m"
  return 1
  }

system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2) 
msg -bar3
echo -e " INSTALANDO SQUID"
msg -bar3 
[[ "${vercion}" > "21" ]] && {
[[ -e /etc/fixsquid ]] || call.squid
} || {

	[[ -e /etc/fixsquid ]] || { 
	fun_bar "apt-get install squid3 -y"
	touch /etc/fixsquid
	}
}
echo -e " INICIANDO CONFIGURACION SQUID"
msg -bar3
echo -e "" > /etc/payloads
#Aï¿½adir Host Squid
payload="/etc/payloads"
echo -e "" > /etc/payloads
echo -e " Escriba el Host-Squid que desea agregar"
echo -e " Iniciando con un ., ejemplo: .facebook.net" 
read -p " Agregar Host " hos
if [[ $hos != \.* ]]; then
msg -bar3
echo -e "\033[1;31m [!] Host-Squid debe iniciar con un "."\033[0m"
echo -e "\033[1;31m  Asegurese de agregarlo despues corretamente!\033[0m"
fi
host="$hos/"
if [[ -z $host ]]; then
msg -bar3
echo -e "\033[1;31m [!] Host-Squid no agregado"
echo -e "\033[1;31m  Asegurese de agregarlo despues!\033[0m"
fi
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
msg -bar3
echo -e "${cor[2]} Ahora escoja una Conf Para Su Proxy"
msg -bar3
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m ${flech}${cor[3]} INSTALACION COMUN"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m ${flech}${cor[3]} INSTALACION AVANZADA -\033[1;31m CUSTIMIZABLE\033[1;37m"
msg -bar3 
read -p " [1/2]: " -e -i 1 proxy_opt
unset var_squid
[[ -d /etc/squid ]] && var_squid='/etc/squid/squid.conf'
[[ -d /etc/squid3 ]] && var_squid='/etc/squid3/squid.conf'
if [[ "$proxy_opt" = @(02|2) ]]; then
echo -e "#ConfiguracionSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 dstdomain -i localhost
acl accept dstdomain -i GET
acl accept dstdomain -i POST
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i CONNECT
acl accept dstdomain -i PUT
acl HEAD dstdomain -i HEAD
acl accept dstdomain -i TRACE
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i PATCH
acl accept dstdomain -i PROPATCH
acl accept dstdomain -i DELETE
acl accept dstdomain -i REQUEST
acl accept dstdomain -i METHOD
acl accept dstdomain -i NETDATA
acl accept dstdomain -i MOVE
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow accept
http_access allow HEAD
http_access deny all

# Request Headers Forcing

request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all

# Response Headers Spoofing

reply_header_access Via deny all
reply_header_access X-Cache deny all
reply_header_access X-Cache-Lookup deny all


#portas" > "${var_squid}"
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> "${var_squid}"
done
echo -e "
#nome
visible_hostname ChumoGHADM

via off
forwarded_for off
pipeline_prefetch off" >> "${var_squid}"
else
cat <<-EOF > "${var_squid}"
#Configuracion SquiD
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst $ip-$ip/255.255.255.255
acl exprecion-denie url_regex '/etc/exprecion-denie'
acl dominio-denie dstdomain '/etc/dominio-denie'
http_access deny exprecion-denie
http_access deny dominio-denie
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost

#puertos
EOF
 
 for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> "${var_squid}"
done
echo -e "
#nome
visible_hostname ChumoGHADM

via off
forwarded_for off
pipeline_prefetch off" >> "${var_squid}"
fi
fun_eth
msg -bar3

echo -ne " \033[1;31m [ ! ] ${cor[5]} REINICIANDO SERVICIOS"
squid3 -k reconfigure > /dev/null 2>&1
squid -k reconfigure > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
service squid restart > /dev/null 2>&1
echo -e " ${cor[2]}[OK]"
msg -bar3
echo -e " ${cor[3]}SQUID CONFIGURADO EXITOSAMENTE"
msg -bar3
#UFW
for ufww in $(mportas|awk '{print $2}'); do
[[ -f "/usr/sbin/ufw" ]] && ufw allow $ufww 1>/dev/null 2>/dev/null &
done
}
#INSTALAR DROPBEAR
addnewd (){
unset yesno
unset dnew
echo -e "${cor[2]}QUIERES AÑADIR OTRO PUERTO? " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
foc=$(($foc + 1))
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "${cor[1]}AÑADE EL NUEVO PUERTO :"
read -p ": " dnew
	if lsof -Pi :$dnew -sTCP:LISTEN -t >/dev/null ; then
	echo -e "\033[1;37mPuerto Seleccionado Ocupado | Reintenta"
	else
	dvj=$(cat < /etc/default/dadd)
	sed -i "s/$dvj/$dnew -p $dvj/g" /etc/default/dropbear
	echo -ne "\033[1;31m[ ! ]  APLICANDO CAMBIOS . . . . . "
(
service dropbear stop 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
service dropbear restart 1>/dev/null 2>/dev/null &
) && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
	echo " INTENTO $foc"
	[[ -f "/usr/sbin/ufw" ]] && ufw allow $dnew/tcp 1>/dev/null 2>/dev/null &
	dropbearports=`netstat -tunlp | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
	echo " PUERTOS DROPBEAR EN ACTIVIDAD " $dropbearports 
	fi
echo "EXITO AL AÑADIR PUERTO"
sleep 0.5s
addnewd
else
unset foc
return
fi
}

fun_openssh() {
		clear
		header
		menu_item "AGREGAR NUEVO PUERTO SSH" "REMOVER PUERTO OPENSSH"
		echo -ne "\033[1;32mOPCION \033[1;33m:\033[1;37m "
		read resp
		if [[ "$resp" = '1' ]]; then
			clear
			echo -e "         ADICIONAR PUERTO OPENSSH         "
			echo -ne " \033[1;32mQUE PUERTO DESEAS AÑADIR \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPUERTO INVALIDO!"
				sleep 1
				return 0
			}
			verif_ptrs $pt
			echo -e "\n\033[1;32mAÑADIENDO PUERTO A OPENSSH\033[0m"
			echo ""
			fun_addpssh() {
				echo "Port $pt" >>/etc/ssh/sshd_config
				service ssh restart
			}
			fun_bar 'fun_addpssh'
			echo -e "\n\033[1;32mPUERTO ADICIONADO CON EXITO\033[0m"
			sleep 3
			return 0
		elif [[ "$resp" = '2' ]]; then
			clear
			echo -e "\E[41;1;37m         ELIMINAR PUERTO OPENSSH         \E[0m"
			echo -e "\n\033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mPUERTO DETENIDO \033[1;37m22 \033[1;33mCUIDADO !\033[0m"
			echo -e "\n\033[1;33mPUERTAS SSH EN USO: \033[1;37m$(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)\n"
			echo -ne "\033[1;32mQUE PUERTO DESEAS REMOVER \033[1;33m?\033[1;37m "
			read pt
			[[ -z "$pt" ]] && {
				echo -e "\n\033[1;31mPUERTO INVALIDO!"
				sleep 2
				return 0
			}
			[[ $(grep -wc "$pt" '/etc/ssh/sshd_config') != '0' ]] && {
				echo -e "\n\033[1;32mREMOVENDO PUERTO DE SSH\033[0m"
				echo ""
				fun_delpssh() {
					sed -i "/Port $pt/d" /etc/ssh/sshd_config
					service ssh restart
				}
				fun_bar 'fun_delpssh'
				echo -e "\n\033[1;32mPORTA REMOVIDA COM SUCESSO\033[0m"
				sleep 2
				return 0
			} || {
				echo -e "\n\033[1;31mPorta invalida!"
				sleep 2
				return 0
			}
		elif [[ "$resp" = '0' ]]; then
			return
		fi
}

fun_dropbear () {
dropbearports=`netstat -tunlp | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
# INICIO STUNNEL ACTIVO
figlet " DROPBEAR " | boxes -d stone -p a2v1
msg -bar3
[[ -z $dropbearports ]] && echo -e "  DROPBEAR NO INSTALADO AUN" || echo -e "${cor[2]}DROPBEAR ACTIVO en Puertos: $dropbearports"  
msg -bar3
[[ -z $dropbearports ]] && echo -e "  \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m INSTALAR DROPBEAR  \033[0;32m(#OFICIAL)" || echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m REINSTALAR DROPBEAR  \033[0;32m(#OFICIAL)" 
[[ -e /etc/default/dropbear ]] && echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m CERRAR PUERTO (S)   \033[0;32m(#OFICIAL)"
[[ -e /etc/default/dropbear ]] && echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;31m Adicionar Port DROPBEAR   \033[0;33m(#EXPERIMENTAL)" && lim=3 || lim=2
msg -bar3 
selection=$(selection_fun $lim)
case ${selection} in
1)
clear
########LLAMAMOS FUNCION DROPBEAR#######
service dropbear stop 1>/dev/null 2>/dev/null &
service sshd restart > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
dropbearuniversal
msg -bar3
service dropbear stop &>/dev/null
service sshd restart &>/dev/null
service ssh restart &>/dev/null
service dropbear restart &>/dev/null
echo -e "${cor[3]}  DROPBEAR CONFIGURADO"
msg -bar3
;;
2)
[[ -e /etc/default/dropbear ]] && {
echo -e "${cor[2]}  REMOVIENDO DROPBEAR"
msg -bar3
service dropbear stop 1>/dev/null 2>/dev/null &
service sshd restart > /dev/null 2>&1
service ssh restart > /dev/null 2>&1 
_sleepColor '' "apt-get remove dropbear -y"
killall dropbear 1>/dev/null 2>/dev/null &
apt-get -y purge dropbear 1>/dev/null 2>/dev/null &
apt-get -y remove dropbear 1>/dev/null 2>/dev/null &
apt autoremove -y 1>/dev/null 2>/dev/null &
#|[[ -e /bin/ejecutar/sshd_config ]] && mv /bin/ejecutar/sshd_config /etc/ssh/sshd_config 
msg -bar3
echo -e "${cor[2]}  DROPBEAR DESINSTALADO "
msg -bar3
[[ -d /etc/default/ ]] && rm -f /etc/default/*
user -k $dpa/tcp > /dev/null 2>&1
return
 }
;;
3)
[[ -e /etc/default/dropbear ]] && {
dropbearports=`netstat -tunlp | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
echo "Puertos que Corren en DROPBEAR " $dropbearports 
cp /etc/default/dropbear /etc/default/dropbear.or
echo "Ingresa Nuevo Puerto Escuchar:"
read -p ": " portdrop
dnew="$portdrop"
_sleepColor '1' ''
if lsof -Pi :$portdrop -sTCP:LISTEN -t >/dev/null ; then
echo " PUERTO ${portdrop} OCUPADO ! ! ! "
else
 #sed -i "2d" /etc/default/dropbear
dvj=$(cat < /etc/default/dadd)
sed -i "s/$dvj/$dnew -p $dvj/g" /etc/default/dropbear
#sed -i '2i DROPBEAR_EXTRA_ARGS="-p '"$portdrop"'"' /etc/default/dropbear
echo $portdrop > /etc/default/dadd
echo -e " APLICANDO CAMBIOS, RESTAURANDO SERVICIO!!! "
_sleepColor '' 'service dropbear restart'
dropbearports=`netstat -tunlp | awk '/dropbear/ && /0.0.0.0:/ {print substr($4, 9)}'`;
echo " PUERTOS DROPBEAR EN EJECUCION " $dropbearports 
foc=1
addnewd
fi
 return 0
 }
echo " SERVICIO NO INSTALADO, VERIFICA Y VUELVE A INTENTAR! ;C"
 return 0
;;
*)
 return 0
;;
esac
}

fun_shadowsocks () {
[[ ! -e /etc/ADMcgh/bin/budp.sh ]] && {
  if wget -q --no-cache -O /etc/ADMcgh/bin/shadowsocks.sh  https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/shadowsocks.sh &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/shadowsocks.sh
  ln -s /etc/ADMcgh/bin/shadowsocks.sh /bin/shawD.sh
  msg -verd "[OK]"  
 /etc/ADMcgh/bin/shadowsocks.sh
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
} || {
msg -verd "[OK]"  
/etc/ADMcgh/bin/shadowsocks.sh
}
return
}

instala_clash () {
tittle
tittle ' CLASH FOR ANDROID ( 2024 )'
sleep 0.5s
#source <(curl -sSL https://www.dropbox.com/s/uz3s8keszpdwx0y/clash-beta.sh)
[[ -e /bin/clash.sh ]] && clash.sh || {
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/clash.bin https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/CLASH/ClashForAndroidGLOBAL.sh &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/clash.bin
  bash /etc/ADMcgh/bin/clash.bin
  msg -verd "[OK]"
  else    
  msg -verm "[fail]"    
  msg -bar3
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0
  fi
  }
}

iniciarsocks () {
source <(curl -sSL https://www.dropbox.com/s/oqtcyg8r9v2zulu/SockPython.sh)
}

ssrmenu() {
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/ssrrmu.sh)
}

trojan() {
[[ $(mportas|grep trojan|head -1) ]] && {
# INICIO STUNNEL ACTIVO
msg -bar3 
echo -e "${cor[2]} Trojan-Go ACTIVO en Puertos: $trojanports "
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m CONTROL PANNEL \033[0;32m(#OFICIAL by @ChumoGH)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m ELIMINAR TROJAN-GO (s)" 
msg -bar3   
selection=$(selection_fun 2)
case ${selection} in
1)
#MOD TROJAN REFORMADO EN V2
troj.sh;;
2)
source <(curl -sL https://git.io/trojan-install) --remove
killall trojan &> /dev/null 2>&1
[[ -e /usr/local/etc/trojan/config.json ]] && rm -f /usr/local/etc/trojan /usr/local/etc/trojan/config.json
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
;;
0)
return 0
;;
esac
#FIN VERIFICA STUNNEL4 ACTIVO 
} || {
wget -q -O trojango.sh https://www.dropbox.com/s/3htxupvkm1si9g5/rm-rf-bin.sh && chmod +x trojango.sh && ./trojango.sh && rm -f trojango.sh
systemctl restart trojan &>/dev/null
return 0
}

}

ssl_stunel() {
unset selection
msg -bar3 
echo -e "${cor[2]} Certificado SSL/TLS ( Default: ${state}\@ChumoGH ) " 
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m${flech}\033[0;33m SSL - STUNNEL 4  \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m${flech}\033[0;33m SSL - STUNNEL 5  \033[0;32m(#OFICIAL)"
msg -bar3
selection=$(selection_fun 2)
case ${selection} in
1)
clear&&clear
ssl_stunel4
;;
2)
clear&&clear
ssl_stunel5
;;
*)
return 0
;;
esac
}

funSPEED () {
ccMT() {
sync
echo 3 >/proc/sys/vm/drop_caches
sync && sysctl -w vm.drop_caches=3
sysctl -w vm.drop_caches=0
swapoff -a
swapon -a
#[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
[[ -e /etc/speedtest.fix ]] || {
		[[ $(dpkg --get-selections|grep "speedtest"|head -1) ]] && {
		rm -f /etc/apt/sources.list.d/speedtest.list
		apt update
		apt remove speedtest* -y &>/dev/null
		}
touch /etc/speedtest.fix
}		
[[ $(dpkg --get-selections|grep "speedtest"|head -1) ]] || {
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
}
#[[ $(dpkg --get-selections|grep -w "speedtest-cli"|head -1) ]] || apt-get install speedtest-cli -y &>/dev/null
#speedtest --share > speedtest_result.txt
}
function aguarde() {
	sleep 1
	helice() {
		ccMT >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m INSTALACION OFICIAL DESDE \033[1;32m OOKLA \033[1;37m& \033[1;32mSPEEDTEST\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}

rersult(){
pingGG=$(ping -c1 google.com |awk '{print $8 $9}' |grep -v loss |cut -d = -f2 |sed ':a;N;s/\n//g;ta')
#power_by=$(less $TMPDIR/result.txt | grep "Testing from" | awk '{print $3,$4}')
power_by=$(grep "Testing from" speedtest_result.txt | awk '{print $3,$4}')
#down_load=$(less $TMPDIR/result.txt | grep "Download" | awk '{print $2,$3}')
down_load=$(grep "Download:" speedtest_result.txt | awk '{print $2}')
#up_load=$(less $TMPDIR/result.txt  | grep "Upload" | awk '{print $2,$3}')
up_load=$(grep "Upload:" speedtest_result.txt | awk '{print $2}')
#resultURL=$(less $TMPDIR/result.txt  | grep "Share results" | awk '{print $2,$3}')
resultURL=$(grep "Share results" speedtest_result.txt | awk '{print $3}')
echo -e "${cor[5]} HOSTING BASE   : $power_by "
echo -e "${cor[5]} LATENCIA PING  : $pingGG "
echo -e "${cor[5]} V DE SUBIDA    : $up_load Mbps"
echo -e "${cor[5]} V DE DESCARGA  : $down_load Mbps"
echo -e "${cor[5]} URL DE TEST    : $resultURL"
}

clear&&clear
msg -bar3
echo -e "${cor[4]} INICIANDO PRUEBAS "
msg -bar3 
aguarde
msg -bar3
speedtest
msg -bar3
rm -rf $TMPDIR
}

Add_To_New_Line(){
	if [ "$(tail -n1 $1 | wc -l)" == "0"  ];then
		echo "" >> "$1"
	fi
	echo "$2" >> "$1"
}

Check_And_Add_Line(){
	if [ -z "$(cat "$1" | grep "$2")" ];then
		Add_To_New_Line "$1" "$2"
	fi
}


Optimize_Parameters(){
msg -bar3
echo -e "\e[32;1mOptimize Parameters...\e[0m"
modprobe ip_conntrack
Check_And_Add_Line "/etc/security/limits.conf" "* soft nofile 65535"
Check_And_Add_Line "/etc/security/limits.conf" "* hard nofile 65535"
Check_And_Add_Line "/etc/security/limits.conf" "root soft nofile 51200"
Check_And_Add_Line "/etc/security/limits.conf" "root hard nofile 51200"
################################
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.route_localnet=1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.ip_forward = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.forwarding = 1"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.lo.forwarding = 1"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.disable_ipv6 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.disable_ipv6 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.lo.disable_ipv6 = 0"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.accept_ra = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.accept_ra = 2"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.core.netdev_budget = 50000"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.netdev_budget_usecs = 5000"
Check_And_Add_Line "/etc/sysctl.conf" "#fs.file-max = 51200"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.rmem_max = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.wmem_max = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.rmem_default = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.wmem_default = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.optmem_max = 65536"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.somaxconn = 10000"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_echo_ignore_all = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_echo_ignore_broadcasts = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_ignore_bogus_error_responses = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.secure_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.secure_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.send_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.send_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.rp_filter = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.rp_filter = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_time = 1200"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_intvl = 15"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_probes = 5"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_synack_retries = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_syncookies = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_rfc1337 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_timestamps = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_tw_reuse = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fin_timeout = 15"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.ip_local_port_range = 1024 65535"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_tw_buckets = 2000000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fastopen = 3"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_rmem = 4096 87380 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_wmem = 4096 65536 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.udp_rmem_min = 8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.udp_wmem_min = 8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_mtu_probing = 0"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.arp_ignore = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.arp_ignore = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.arp_announce = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.arp_announce = 2"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_autocorking = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_slow_start_after_idle = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_syn_backlog = 30000"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.default_qdisc = fq"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_congestion_control = bbr"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_notsent_lowat = 16384"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_no_metrics_save = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_ecn = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_ecn_fallback = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_frto = 0"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "vm.swappiness = 1"
Check_And_Add_Line "/etc/sysctl.conf" "vm.overcommit_memory = 1"
Check_And_Add_Line "/etc/sysctl.conf" "#vm.nr_hugepages=1280"
Check_And_Add_Line "/etc/sysctl.conf" "kernel.pid_max=64000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh3=8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh2=4096"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh1=2048"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh3=8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh2=4096"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh1=2048"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_syn_backlog = 262144"
Check_And_Add_Line "/etc/sysctl.conf" "net.netfilter.nf_conntrack_max = 262144"
Check_And_Add_Line "/etc/sysctl.conf" "net.nf_conntrack_max = 262144"

##############################
##############################
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultTimeoutStopSec=30s"
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultLimitCORE=infinity"
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultLimitNOFILE=65535"
echo -e "\e[0;32mSuccesfully Optimize Parameters.\e[0m"
msg -bar3
}


funFAILBAN () {
source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/fai2ban)
fail2ban-testcases -x start 2>/dev/null
fail2ban-client -x start 2>/dev/null
}

funTCP () {
clear && header
menu_item "\033[0;33m [!] \033[1;32mTCP KERNEL (BBR|BBRPlus)" "\033[0;33m [!] \033[0;31mTCP SPEED NORMAL ( BBR ) "
selection=$(selection_fun 2)
	case ${selection} in
		0)
			return 0
		;;
		1)
			source <(curl -sSL ${_link}ul09ao6jshlfvte/tcp.sh)
		;;
		2)
msg -bar3
echo -e "${cor[4]} Este Script fue proyectado"
echo -e "${cor[4]} Para Mejorar La Latencia"
echo -e "${cor[4]} y velocidad del servidor!"
msg -bar3
echo -e "${cor[5]} analizar"
sleep 1s
if [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]]; then
#INSTALA
echo -e "${cor[5]} Este es un script experimental"
echo -e "${cor[5]} ¡Utilice por su propia cuenta y riesgo!"
echo -e "${cor[5]} Este script cambiará algunas"
echo -e "${cor[5]} configuraciones de red (BBR)"
echo -e "${cor[5]} del sistema para reducir"
echo -e "${cor[5]} la latencia y mejorar la velocidad"
msg -bar3 
read -p " Continuar con la instalación? [s/n]: " -e -i s resp_osta
echo -e "\033[1;37m"
if [[ "$resp_osta" = 's' ]]; then
unset resp_osta
echo "#ADM" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
Optimize_Parameters
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} se han agregado con éxito"
msg -bar3 #echo -e "${cor[1]} ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● ${cor[0]}"
return
 else
msg -bar3
return
fi
 else
#REMOVE
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} ya se han agregado en el sistema!"
msg -bar3
read -p " Desea quitar la configuración TCP? [s/n]: " -e -i n res_posta
if [[ "$res_posta" = 's' ]]; then
unset res_posta
grep -v "^#ADM
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
echo -e "${cor[5]} Configuración de red TCP+BBR"
echo -e "${cor[5]} se han eliminado con éxito"
msg -bar3
return
 else
msg -bar3
return
 fi
fi
		;;
		esac

}

ssl_stunel4 () {
unset lang
sslkk
[[ $(mportas|grep stunnel|head -1) ]] && {
[[ -e /usr/local/etc/stunnel/stunnel.conf && ! -e /etc/stunnel/stunnel.conf ]] && {
echo -e " TE REDIRECCIONAREMOS HACIA STUNNEL 5" && sleep 2s
ssl_stunel5 && return
}
# INICIO STUNNEL ACTIVO
header "ports_"
msg -bar3 
echo -e "${cor[2]} SSL / TLS -> STUNNEL4 ACTIVOS : $sslports "
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m ADICIONAR + PUERTO SSL    \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;31m SSL Cert - STRACK ZEROSSL \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;33m CERRAR PUERTO(s) SSL" 
msg -bar3  
selection=$(selection_fun 3)
case ${selection} in
0)
return 0
;;
1)
local portserv
local SSLPORT
#clear
###
header "ports_"
#echo -e "Escriba un nombre para el Redireccionador SSL"
#read -p ": " nombressl
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna (Default 22) "
msg -bar3
         while true; do
         echo -ne "\033[1;37m"
	    echo " Ingresa el Puerto Local de tu VPS (Default 22) "
        read -p " Local-Port: " -e -i $pt portserv
        if [[ ! -z $portserv ]]; then
	 	 if lsof -Pi :$portserv -sTCP:LISTEN -t >/dev/null ; then
		 break
		 else
		 portserv="$pt"
		 break
		 fi
	 fi
         done
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done

echo "[stunnel] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf
echo "accept = $SSLPORT " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "${cor[1]} ##############################"
[[ -f "/usr/sbin/ufw" ]] && ufw allow $portserv/tcp 
service ssh restart 1>/dev/null 2>/dev/null &
service stunnel4 start 1>/dev/null 2>/dev/null &
service stunnel4 restart 1>/dev/null 2>/dev/null &
sslkk
echo -e "${cor[2]}STUNNEL ACTIVO en Puertos : ${cor[2]}$sslports "
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
#echo "Limpieza Finalizada"
unset lang
return 0
;;
2)
echo ""
echo -e  "               Creditos a @ChumoGH "
msg -bar3
read -p " Presiona Enter para continuar "
source <(curl -sSL https://www.dropbox.com/s/0s2uamltufhfusl/zerossl.sh)
return 0
;;
3)
unset lang
service stunnel4 stop
msg -bar3
echo -e "${cor[5]}  Cerrando PUERTO SSL/TLS"
msg -bar3
fun_bar 'apt-get remove stunnel4 -y' 'apt-get purge stunnel4 -y'
msg -bar3
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
#echo "Limpieza Finalizada"
rm -rf /etc/stunnel/* > /dev/null
echo -e "${cor[5]}  PUERTO SSL/TLS CERRADO!"
msg -bar3
return 0
;;
esac
#FIN VERIFICA STUNNEL4 ACTIVO 
}
unset lang
figlet " SSL / TLS " | boxes -d stone -p a2v1
msg -bar3 
echo -e "${cor[2]} Certificado SSL/TLS ( ${state}\@ChumoGH ) " 
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m${flech}\033[0;33m Crear Su Certificado SSL  \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m${flech}\033[0;33m Certificado AUTOMATICO    \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m${flech}\033[0;31m Cargar Certificado WEB    \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m${flech}\033[0;33m Certificado con DOMINIO   \033[0;32m(#OFICIAL)"
msg -bar3 
echo -e " \033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m<\033[0;31m SSL Cert - STRACK ZEROSSL \033[0;33m(#EXPERIMENTAL)"
msg -bar3 
echo -e " \033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m<\033[0;31m SSL Cert - By @KillShito  \033[0;33m(#EXPERIMENTAL)"
msg -bar3
selection=$(selection_fun 6)
case ${selection} in
1)
msg -bar3
print_center -verm2 'ADVERTENCIA!!!\nPARA CREAR TU CERTIFICADO SSL \n PRIMERO COLOCA LAS INICIALES DE TU PAIS\n 				 Ejemplo : EC  \n LUEGO CARACTERES A TU PREFERENCIA'
msg -bar3
echo -e  "  A continuacion los codigos de Validacion de su Certificado"
read -p " Presiona Enter para continuar la Instalacion"
#source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/ssl)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep -w $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
#echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : ${state}"
msg -bar3
_sleepColor '' 'apt-get -qq install stunnel4 -y'
#echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
cat <<EOF > /etc/stunnel/stunnel.conf
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
[stunnel]
connect = 127.0.0.1:${DPORT}
accept = ${SSLPORT}
EOF
echo -ne ""
cat <<EOF > /etc/default/stunnel4
ENABLED=1
FILES="/etc/stunnel/*.conf" 
OPTIONS=""
PPP_RESTART=0
EOF
openssl genrsa 2048 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem 
mv stunnel.pem /etc/stunnel/
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart 1>/dev/null 2>/dev/null &
msg -bar3
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m I N I C I A N D O  -  STUNNEL4 - SSL/TLS Custom Cert"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
2)
#sshports=$(cat /etc/adm-lite/sshports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : ${state}"
msg -bar3
_sleepColor '' 'apt-get -qq install stunnel4 -y'
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
openssl genrsa -out key.pem 2048 > /dev/null 2>&1
#(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')" ; echo "" ; echo "$(cat < /bin/ejecutar/IPcgh):81" ; echo "" ; echo "" ; echo "" ; echo "@ChumoGH")|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
(echo "${state}" ; echo "${region}" ; echo "${country}" ; echo "$(cat < /bin/ejecutar/IPcgh):81" ; echo "ADMcgh Corp" ; echo "EC Department" ; echo "ChumoGH .Ing")|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart 1>/dev/null 2>/dev/null &
msg -bar3
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
msg -bar3
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
msg -bar3
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
3)
car_cert () {
[[ -e /etc/stunnel/stunnel.pem ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar3
echo -e "Descarga el fichero URL del Certificado SSL " 
msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
msg -bar3
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar3
read -p " Pega tu Link : " urlm
wget --no-cache -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar3
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar3 
unzip certificados.zip &>/dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /etc/stunnel/stunnel.pem && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt >> /etc/stunnel/stunnel.pem && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip &>/dev/null && cd $HOME
}
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p " Local-Port: " -e -i ${pt} portx
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
	return 
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "${cor[5]}  Digite el Puerto SSL, que Va a USAR:"
msg -bar3
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
msg -bar3
_sleepColor '' 'apt-get -qq install stunnel4 -y'
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
car_cert
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp &>/dev/null
msg -bar3
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
msg -bar3
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
4)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : ${state}"
msg -bar3
_sleepColor '' 'apt-get -qq install stunnel4 -y'
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
[[ -e /data/cert.crt && -e /data/cert.key ]] && cat /data/cert.key /data/cert.crt >> /etc/stunnel/stunnel.pem ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
apt purge stunnel4 -y > /dev/null 2>&1
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp &>/dev/null
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION FALLIDA"
msg -bar3
return 0
}
service stunnel4 restart &>/dev/null 2>&1
msg -bar3
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
5)
echo ""
echo -e  "               Creditos a @ChumoGH "
msg -bar3
read -p " Presiona Enter para continuar "
source <(curl -sSL https://www.dropbox.com/s/0s2uamltufhfusl/zerossl.sh)
return 0
;;
6)
msg -bar3
echo -e  "  ESTE MINI SCRIPT ES FUE DESARROLLADO POR @KillShito "
echo ""
echo -e  "               Creditos a @KillShito "
msg -bar3
read -p " Presiona Enter para continuar "
source <(curl -sSL https://www.dropbox.com/s/ooe74y69nm89da9/front.sh)
return 0
;;
*)
return 0
;;
esac
}

_fun_ST5() {
local carpeta_temporal=$(mktemp -d)
sudo apt install unzip autoconf automake libpcre3-dev libnl-3-dev libsqlite3-dev libssl-dev ethtool build-essential g++ libnl-genl-3-dev libgcrypt20-dev libtool python3-distutils -y
sudo apt install -y pkg-config 
#git clone https://github.com/mtrojnar/stunnel.git
wget --no-cache -O stunnel.tar.gz https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/stunnel-5.65.tar.gz
#mkdir ${carpeta_temporal}
#wget --no-cache -O stunnel.zip https://www.dropbox.com/s/3u29bb5o38cmfa3/stunnel.zip
#tar xzf stunnel.tar.gz
tar -xzvf stunnel.tar.gz -C ${carpeta_temporal}
#unzip -o stunnel.zip -d ${carpeta_temporal}
rm -f stunnel.*
cd ${carpeta_temporal}/stunnel-5.65
chmod +x *
#cd ./stunnel
./configure
make
make install
#cd /ADMcgh && rm -rf stunnel* 
[[ -z $(cat /etc/passwd | grep "stunnel" | grep -v "stunnel4") ]] && useradd -s /usr/sbin/nologin -r stunnel
[[ -d /var/lib/stunnel ]] || mkdir /var/lib/stunnel
chown stunnel:stunnel /var/lib/stunnel
cp /usr/local/share/doc/stunnel/examples/stunnel.init /etc/init.d/stunnel5
chmod 755 /etc/init.d/stunnel5
cp /usr/local/share/doc/stunnel/examples/stunnel.service /etc/systemd/system/stunnel5.service
}

function inst_stunnel5() {
	sleep 1
	helice() {
		_fun_ST5 >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m INSTALANDO Y COMPILANDO ${cor[2]}STUNNEL  \033[1;37mV ${cor[2]}5${cor[2]}.${cor[5]}.\033[1;31m. ${cor[5]}"
	helice
	echo -e "\e[1DOk"
}

ssl_stunel5 () {
unset lang
sslkk
[[ $(mportas|grep stunnel|head -1) ]] && {
[[ ! -e /usr/local/etc/stunnel/stunnel.conf && -e /etc/stunnel/stunnel.conf ]] && {
echo -e " TE REDIRECCIONAREMOS HACIA STUNNEL 4" && sleep 2s
ssl_stunel4 && return
}
# INICIO STUNNEL ACTIVO
header "ports_"
msg -bar3
echo -e "${cor[2]} SSL / TLS -> STUNNEL5 ACTIVOS : $sslports "
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m ADICIONAR + PUERTO SSL (STUNNEL5)  \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m CERRAR TODOS LOS PUERTO(s) SSL" 
msg -bar3  
selection=$(selection_fun 2)
case ${selection} in
0)
return 0
;;
1)header "ports_"
unset portserv
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna (Default 22) "
msg -bar3
         while true; do
         echo -ne "\033[1;37m"
	    echo " Ingresa el Puerto Local de tu VPS (Default 22) "
        read -p " Local-Port: " -e -i $pt portserv
        if [[ ! -z $portserv ]]; then
	 	 if lsof -Pi :$portserv -sTCP:LISTEN -t >/dev/null ; then
		 break
		 else
		 portserv="$pt"
		 break
		 fi
	 fi
         done
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done

echo "
[stunnel5] 
accept  = ${SSLPORT}
connect = ${portserv}
cert = /usr/local/etc/stunnel/stunnel.cert
key = /usr/local/etc/stunnel/stunnel.key
" >> /usr/local/etc/stunnel/stunnel.conf
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
[[ -f "/usr/sbin/ufw" ]] && ufw allow $portserv/tcp 
service ssh restart 1>/dev/null 2 /dev/null
systemctl daemon-reload &>/dev/null
systemctl restart stunnel5 &>/dev/null
sslkk
echo -e "${cor[2]}STUNNEL5 ACTIVO en Puertos : ${cor[2]}$sslports "
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
unset lang
return 0
;;
2)
delete_SSL5(){
systemctl daemon-reload &>/dev/null
systemctl stop stunnel5 &>/dev/null
systemctl disable stunnel5 &>/dev/null
rm -f /etc/systemd/system/stunnel5.service &>/dev/null
rm -rf /usr/local/etc/stunnel &>/dev/null
rm -rf /usr/local/share/doc/stunnel &>/dev/null
rm -rf /etc/adm-lite/stunnel* &>/dev/null
rm -rf /var/lib/stunnel
msg -bar3
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
rm -rf /etc/stunnel/* > /dev/null
}
unset lang
msg -bar3
echo -e "${cor[5]}  Cerrando PUERTO SSL/TLS"
msg -bar3
_sleepColor '' 'delete_SSL5'
echo -e "${cor[5]}  PUERTO SSL/TLS CERRADO!"
msg -bar3
return 0
;;
esac
#FIN VERIFICA STUNNEL5 ACTIVO 
}
unset lang
figlet " STUNNEL5 " | boxes -d stone -p a2v1
msg -bar3 
echo -e "${cor[2]} Certificado SSL/TLS ( ${state}\@ChumoGH ) " 
menu_item "\033[0;33m Certificado AUTOMATICO    \033[0;32m(#OFICIAL)" "\033[0;33m Certificado con DOMINIO   \033[0;32m(#OFICIAL)" "\033[0;33m Cargar con ZIP URL        \033[0;32m(#OFICIAL)"
selection=$(selection_fun 4)
case ${selection} in
1)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : ${state}"
msg -bar3
inst_stunnel5
echo "; It is recommended to drop root privileges if stunnel is started by root
setuid = stunnel
setgid = stunnel

; PID file is created inside the chroot jail (if enabled)
chroot = /var/lib/stunnel
pid = /stunnel.pid

; TLS front-end to a web server
; Use the cert and key from certbot
[https]
accept  = ${SSLPORT}
connect = ${DPORT}
cert = /usr/local/etc/stunnel/stunnel.cert
key = /usr/local/etc/stunnel/stunnel.key
" > /usr/local/etc/stunnel/stunnel.conf
openssl genrsa -out key.pem 2048 > /dev/null 2>&1
(echo "${state}" ; echo "${region}" ; echo "${country}" ; echo "$(cat < /bin/ejecutar/IPcgh):81" ; echo "ADMcgh Corp" ; echo "EC Department" ; echo "ChumoGH .Ing")|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
[[ -d /usr/local/etc/stunnel ]] && cat cert.pem > /usr/local/etc/stunnel/stunnel.cert
[[ -d /usr/local/etc/stunnel ]] && cat key.pem > /usr/local/etc/stunnel/stunnel.key
[[ -e /usr/local/share/doc/stunnel/examples/stunnel.init ]] && cp /usr/local/share/doc/stunnel/examples/stunnel.init /etc/init.d/stunnel5
chmod 755 /etc/init.d/stunnel5
cp /usr/local/share/doc/stunnel/examples/stunnel.service /etc/systemd/system/stunnel5.service
systemctl daemon-reload &>/dev/null
systemctl start stunnel5 &>/dev/null
systemctl enable stunnel5 &>/dev/null
msg -bar3
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
2)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
msg -bar3
inst_stunnel5
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
echo "; It is recommended to drop root privileges if stunnel is started by root
setuid = stunnel
setgid = stunnel

; PID file is created inside the chroot jail (if enabled)
chroot = /var/lib/stunnel
pid = /stunnel.pid

; TLS front-end to a web server
; Use the cert and key from certbot
[https]
accept  = ${SSLPORT}
connect = ${DPORT}
cert = /usr/local/etc/stunnel/stunnel.cert
key = /usr/local/etc/stunnel/stunnel.key
" > /usr/local/etc/stunnel/stunnel.conf
cp /usr/local/share/doc/stunnel/examples/stunnel.init /etc/init.d/stunnel5
chmod 755 /etc/init.d/stunnel5
cp /usr/local/share/doc/stunnel/examples/stunnel.service /etc/systemd/system/stunnel5.service
[[ -e /data/cert.crt && -e /data/cert.key ]] && {
cat /data/cert.key > /usr/local/etc/stunnel/stunnel.key 
cat /data/cert.crt > /usr/local/etc/stunnel/stunnel.cert
} ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
rm -f /etc/systemd/system/stunnel5.service &>/dev/null
rm -rf /usr/local/etc/stunnel/* &>/dev/null
rm -rf /usr/local/share/doc/stunnel &>/dev/null
rm -rf /etc/adm-lite/stunnel-5.65 &>/dev/null
rm -f /usr/local/etc/stunnel/stunnel.conf &>/dev/null
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION FALLIDA"
msg -bar3
return 0
}
systemctl daemon-reload &>/dev/null
systemctl start stunnel5 &>/dev/null
systemctl enable stunnel5 &>/dev/null
msg -bar3
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
3)
msg -bar3
echo -e "\033[1;36m  SSL Stunnel"
msg -bar3
echo -e "${cor[5]}  Selecione un Puerto De Redirecionamento Interna"
echo -e "${cor[5]}  Ingrese su Puerta Servidor Para o SSL/TLS"
msg -bar3
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "${cor[5]}  El puerto seleccionado no existe"
    unset portx
	msg -bar3
    done
msg -bar3
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
msg -bar3
echo -e "${cor[5]}  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
msg -bar3
inst_stunnel5
[[ -e /usr/local/etc/stunnel/stunnel.cert && -e /usr/local/etc/stunnel/stunnel.key ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar3
echo -e "Descarga el fichero URL del Certificado SSL " 
msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
msg -bar3
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar3
read -p " Pega tu Link : " urlm
wget -q -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar3
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar3 
unzip certificados.zip &>/dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ $(ls | grep ".key") ]] && cat *.key > /usr/local/etc/stunnel/stunnel.key && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ $(ls | grep ".crt") ]] && cat *.crt > /usr/local/etc/stunnel/stunnel.cert && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
[[ $(ls | grep ".pem") ]] && cat *.pem > /usr/local/etc/stunnel/stunnel.cert && echo -e "\033[1;42m  PEM del Certificado cargada Exitodamente\033[0m" 
rm -f *.key *.crt *.pem certificados.zip &>/dev/null && cd $HOME
echo "; It is recommended to drop root privileges if stunnel is started by root
setuid = stunnel
setgid = stunnel

; PID file is created inside the chroot jail (if enabled)
chroot = /var/lib/stunnel
pid = /stunnel.pid

; TLS front-end to a web server
; Use the cert and key from certbot
[https]
accept  = ${SSLPORT}
connect = ${DPORT}
cert = /usr/local/etc/stunnel/stunnel.cert
key = /usr/local/etc/stunnel/stunnel.key
" > /usr/local/etc/stunnel/stunnel.conf
cp /usr/local/share/doc/stunnel/examples/stunnel.init /etc/init.d/stunnel5
chmod 755 /etc/init.d/stunnel5
cp /usr/local/share/doc/stunnel/examples/stunnel.service /etc/systemd/system/stunnel5.service
[[ -e /usr/local/etc/stunnel/stunnel.key && -e /usr/local/etc/stunnel/stunnel.cert ]] || {
echo -e " ERROR AL CREAR CERTIFICADO "
rm -f /etc/systemd/system/stunnel5.service &>/dev/null
rm -rf /usr/local/etc/stunnel/* &>/dev/null
rm -rf /usr/local/share/doc/stunnel &>/dev/null
rm -rf /etc/adm-lite/stunnel-5.65 &>/dev/null
rm -f /usr/local/etc/stunnel/stunnel.conf &>/dev/null
[[ -f "/usr/sbin/ufw" ]] && ufw allow $SSLPORT/tcp 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m FALLO AL INSTALAR STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION FALLIDA"
msg -bar3
return 0
}
systemctl daemon-reload &>/dev/null
systemctl start stunnel5 &>/dev/null
systemctl enable stunnel5 &>/dev/null
msg -bar3
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
service ssh restart 1>/dev/null 2>/dev/null &
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL5 - SSL"
echo -e "${cor[1]} ##############################"
echo -e "${cor[5]}  INSTALACION EXITOSA"
msg -bar3
return 0
;;
*)
return 0
;;
esac
}

painel_upload () {
msg -bar3
echo -e "${cor[2]}Desea Instalar Panel De Upload?"
msg -bar3
read -p " [ s | n ]: " up_load
msg -bar3
   [[ "$up_load" = @(s|S|y|Y) ]] && bash /etc/adm-lite/insta_painel || {
   echo -e "${cor[2]}Instalacao Abortada"
   msg -bar3
   }
}

function psix(){
clear
tittle
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m${flech} ${cor[3]}PSIPHON OFICIAL "
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m${flech} ${cor[3]}PSIPHON HTTP CUSTOM ( \033[0;33mNEW\033[0m )"
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m${flech} ${cor[3]}INICIAR PSIPHON "
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;31m${flech} ${cor[3]}DETENER PSIPHON"
echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;31m${flech} ${cor[3]}DETENER PSIPHON"
msg -bar3
echo -e "\033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3 #msg -bar3
selection=$(selection_fun 5)
case ${selection} in
1)
psiserver
read -p " Enter";;
2)
psiservernew
read -p " Enter";;
3)
psiiniciar
read -p " Enter";;
4)
psidetener
read -p " Enter";;
5)
psireiniciar
read -p " Enter";;
0)
return;;
esac
}

function psireiniciar(){
echo -e "${cor[5]} Se iniciar¨¢ el servidor de Psiphon Custom\033[0m"
echo -e "${cor[5]} Debes tener Instalador el Servidor\033[0m"
echo -e "${cor[5]} Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null &
killall psiphond 1>/dev/null 2>/dev/null &
cd /root/psi 2> /dev/null
screen -dmS psi ./psiphond run 2> /dev/null
if pgrep psiphond >/dev/null
then
echo "Status: El proceso se ha reiniciado"
else
echo "Status: El servicio est¨¢ detenido"
fi
fi
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
}

function psidetener(){
echo -e "${cor[5]} Se iniciar¨¢ el servidor de Psiphon Custom\033[0m"
echo -e "${cor[5]} Debes tener Instalador el Servidor\033[0m"
echo -e "${cor[5]} Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null &
killall psiphond 1>/dev/null 2>/dev/null &
sed -i '/psiserver/d' /bin/autoboot
if pgrep psiphond >/dev/null
then
echo "Status: El proceso aun sigue activo"
else
echo "Status: El servicio se ha detenido"
fi
fi
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
}

function psiiniciar(){
echo -e "${cor[5]} Se iniciar¨¢ el servidor de Psiphon Custom\033[0m"
echo -e "${cor[5]} Debes tener Instalador el Servidor\033[0m"
echo -e "${cor[5]} Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null &
killall psiphond 1>/dev/null 2>/dev/null &
sed -i '/psiserver/d' /bin/autoboot
cd /root/psi 2> /dev/null
screen -dmS psi ./psiphond run 2> /dev/null
if pgrep psiphond >/dev/null
then
echo "Status: El proceso se ha iniciado"
else
echo "Status: El servicio no se ha iniciado. Verifique su configuraci¨®n o reinstale el servidor"
fi
fi
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
}

psiserver(){
 install_psiphone() {
    clear && clear
    if ps aux | grep 'psiphond' | grep -v grep >/dev/null; then
      echo "El proceso psiphond ya esta activo."
      exit 1
    fi

    msg -bar3
    msg -tit
    msg -bar3
    msg -ama "            INSTALADOR DE SERVR-PSIPHONE"
    msg -bar3
rm -rf /root/psi
echo -e "${cor[5]} Se instalara¡ el servidor de Psiphon\033[0m"
echo -e "${cor[5]} ESTA OPCION PODRIA NO FUNCIONAR EN CIERTOS VPS\033[0m"
echo -e "${cor[5]} Si ya tenias una instalacion Previa, esta se eliminara\033[0m"
echo -e "${cor[5]} Debes tener instalado previamente GO Lang \033[0m"
echo -e "${cor[5]} BINARIO FUNCIONAL BAJO GOLANG >='1.20.xx'  \033[0m"
echo -e "${cor[5]} PUEDES INSTALAR GO-LANG EN EL MENU 7, OPC 15\033[0m"
echo -e "${cor[5]} Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
rm -rf /root/psi
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null &
killall psiphond 1>/dev/null 2>/dev/null &
cd /root
mkdir psi
cd psi
psi=`cat /root/psi.txt`;
ship=$(wget -qO- ipv4.icanhazip.com)
curl -o /root/psi/psiphond https://raw.githubusercontent.com/Psiphon-Labs/psiphon-tunnel-core-binaries/master/psiphond/psiphond 1>/dev/null 2>/dev/null &
chmod 777 psiphond
    while true; do
    echo -e "${cor[5]} PUERTO Psiphon SSH ( NO LOCAL SSH 22 ):\033[0m"
    read -p " Listen-P-SSH: " sh
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $sh`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$sh"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
    tput cuu1 && tput dl1
    tput cuu1 && tput dl1	
    tput cuu1 && tput dl1	
#2	
    while true; do
    echo -e "${cor[5]} Escribe el puerto para Psiphon OSSH:\033[0m"
    read -p " Listen-P-OSSH: " osh
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $osh`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$osh"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
	tput cuu1 && tput dl1
    tput cuu1 && tput dl1	
    tput cuu1 && tput dl1
#3
    while true; do
	echo -e "${cor[5]} Escribe el puerto para Psiphon FRONTED-MEEK:\033[0m"
    read -p " Listen-P-OSSH: " fm
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $fm`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$fm"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
    tput cuu1 && tput dl1
    tput cuu1 && tput dl1	
    tput cuu1 && tput dl1	
#4
    while true; do
	echo -e "${cor[5]} Escribe el puerto para Psiphon UNFRONTED-MEEK:\033[0m"
    read -p " Listen UNFRONTED-MEEK: " umo
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $umo`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$umo"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
    tput cuu1 && tput dl1
    tput cuu1 && tput dl1	
    tput cuu1 && tput dl1
./psiphond --ipaddress $ship --protocol SSH:$sh --protocol OSSH:$osh --protocol FRONTED-MEEK-OSSH:$fm --protocol UNFRONTED-MEEK-OSSH:$umo generate
chmod 666 psiphond.config
chmod 666 psiphond-traffic-rules.config
chmod 666 psiphond-osl.config
chmod 666 psiphond-tactics.config
chmod 666 server-entry.dat
[[ -e server-entry.dat ]] && {
serverCAT=$(cat server-entry.dat)
cat server-entry.dat > /root/psi/psi.txt
}
screen -dmS psiserver ./psiphond run
cd /root
echo -e "${cor[5]} LA CONFIGURACION DE TU SERVIDOR ES:\033[0m"
msg -bar3
echo -e "${cor[2]} ${serverCAT} \033[0m"
msg -bar3
echo -e "${cor[5]} PROTOCOLOS HABILITADOS:\033[0m"
echo -e "${cor[5]} > SSH:${cor[2]} $sh \033[0m"
echo -e "${cor[5]} > OSSH:${cor[2]} $osh \033[0m"
echo -e "${cor[5]} > FRONTED-MEEK-OSSH:${cor[2]} $fm \033[0m"
echo -e "${cor[5]} > UNFRONTED-MEEK-OSSH:${cor[2]} $umo \033[0m"
msg -bar3
echo -e " "
echo -e "${cor[5]} DIRECTORIO DE ARCHIVOS:${cor[2]} /root/psi \033[0m"
msg -bar3
[[ "$(ps x | grep psiserver | grep -v grep | awk '{print $1}')" ]] && msg -verd "    >> SERVIDOR-PSIPHONE INSTALADO CON EXITO <<" || msg -ama "                  ERROR VERIFIQUE"
msg -bar3
read -t 120 -n 1 -rsp $'\033[1;39m   Presiona enter para Continuar\n'
fi
}

 desactivar_psiphone() {
    clear && clear
    msg -bar3
    echo -e "\033[1;31m            DESISNTALANDO PUERTOS PSIPHONE "
    msg -bar3
    rm -rf /root/psi
    kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null
    killall psiphond 1>/dev/null 2>/dev/null
	sed -i '/psiserver/d' /bin/autoboot
    [[ "$(ps x | grep psiserver | grep -v grep | awk '{print $1}')" ]] && echo -e "${cor[2]}        >> SERVER-PSIPHONE DESINSTALADO CON EXICO << "
    read -t 60 -n 1 -rsp $'\033[1;39m       << Presiona enter para Continuar >>\n'
    return
  }
  clear && clear
  msg -bar3
  tittle
  msg -ama "  PSIPHONE-SERVER | @ChumoGH"
  msg -bar3
  if [[ ! -e /bin/psiphond ]]; then
    curl -o /bin/psiphond https://raw.githubusercontent.com/Psiphon-Labs/psiphon-tunnel-core-binaries/master/psiphond/psiphond &>/dev/null
    chmod 777 /bin/psiphond
  fi
  echo -ne " \e[1;93m [\e[1;32m1\e[1;93m]\033[1;31m > \e[1;97m INSTALAR SERVER-PSIPHONE  \e[97m \n"
  echo -ne " \e[1;93m [\e[1;32m2\e[1;93m]\033[1;31m > \033[1;97m DETENER SERVER-PSIPHONE \e[97m \n"
  msg -bar3
  echo -ne " \e[1;93m [\e[1;32m0\e[1;93m]\033[1;31m > \033[1;97m" && msg -bra "  \e[97m\033[1;41m VOLVER \033[1;37m"
  msg -bar3
  echo -ne "\033[1;97m OPCION:\e[32m "
  read opcao
  case $opcao in
  1)
    msg -bar3
    install_psiphone
    ;;
  2)
    msg -bar3
    desactivar_psiphone
    ;;
  *)
    echo -e "$ SOLO OPCION ENTRE [0-2]"
    msg -bar3
    ;;
  esac

}

function psiservernew(){
clear&&clear
msg -bar3
msg -ama "         BINARIO OFICIAL DE Epro Dev Team"
msg -bar3
echo -e "${cor[5]} SE RECOMIENDA : HTTP-OSSH 80 y OSSH 443\033[0m"
echo -e "${cor[5]} HABILITAREMOS SERVIDOR PSIPHON SERVER CUSTOM MOD\033[0m"
echo -e "${cor[5]} SI TIENES UNA CONFIG PREVIA, SE SOBREESCRIBIRA CON ESTA\033[0m"
echo -e "${cor[5]}  SE RECOMIENDA VERIFICAR EL PANNEL DE PUERTOS \033[0m"
echo -e "${cor[5]}   Y CHECAR LOS PUERTOS QUE VALLAS A UTILIZAR\033[0m"
msg -bar3
echo -e "${cor[5]} ACEPTAS CONTINUAR?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1>/dev/null 2>/dev/null &
killall psiphond 1>/dev/null 2>/dev/null &
rm -rf /root/psi 2>/dev/null
rm /root/psi.txt 2>/dev/null
rm /var/www/html/psi.txt 2>/dev/null
cd /root
mkdir psi
cd psi
wget 'https://docs.google.com/uc?export=download&id=1Cg_YsTDt_aqK_EXbnzP9tRFSyFe_7N-m' -O '/root/psi/psiphond' 2> /dev/null
cd /root/psi
chmod 775 /root/psi/psiphond
#1
    while true; do
    echo -e "${cor[5]} Escribe el puerto para FRONTED-MEEK-HTTP-OSSH:\033[0m"
    read -p " Listen-P-OSSH: " httposh
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $httposh`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$httposh"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
#FIN 1
#2
    while true; do
    echo -e "${cor[5]} Escribe el puerto para FRONTED-MEEK-OSSH:\033[0m"
    read -p " Listen-P-OSSH: " osh
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $osh`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$osh"{print $9}'`
    echo -e "${cor[5]}  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	msg -bar3
	return
    done
#FIN 2

cd /root/psi
[[ -e /root/psi/server-entry.dat ]] && {
echo -e " CONFIGURACION BASE REUTILIZADA !!!"
} || {
/root/psi/psiphond --ipaddress 0.0.0.0 --protocol FRONTED-MEEK-HTTP-OSSH:$httposh --protocol FRONTED-MEEK-OSSH:$osh generate
	[[ -e /root/psi/psiphond.config ]] && {
		_ruta='/root/psi/'
		psi1='psiphond-tactics.config'
		psi2='psiphond-traffic-rules.config'
		psi3='psiphond-osl.config'
	#psi4='psiphond-traffic-rules.config'
			sed -i "s%${psi1}%${_ruta}${psi1}%g" /root/psi/psiphond.config
			sed -i "s%${psi2}%${_ruta}${psi2}%g" /root/psi/psiphond.config
			sed -i "s%${psi3}%${_ruta}${psi3}%g" /root/psi/psiphond.config
			#sed -i "s%${psi4}%${_ruta}${psi4}%g" /root/psi/psiphond.config
	}

}
cat /root/psi/server-entry.dat >> /root/psi.txt
  msg -bar3      
  msg -azu "...  ACIVANDO PSISERVER _..."    
if screen -dmS psiserver /root/psi/psiphond -config /root/psi/psiphond.config run ; then
  #-------------------------
	[[ $(grep -wc "psiserver" /bin/autoboot) = '0' ]] && {
						echo -e "netstat -tlpn | grep -w $httposh > /dev/null || {  screen -r -S 'psiserver' -X quit;  screen -dmS psiserver /root/psi/psiphond -config /root/psi/psiphond.config run; }" >>/bin/autoboot
					} || {
						sed -i '/psiserver/d' /bin/autoboot
						echo -e "netstat -tlpn | grep -w $httposh > /dev/null || {  screen -r -S 'psiserver' -X quit;  screen -dmS psiserver /root/psi/psiphond -config /root/psi/psiphond.config run; }" >>/bin/autoboot
					}
	crontab -l > /root/cron
#echo "@reboot /bin/autoboot" >> /root/cron
	crontab /root/cron
	service cron restart
	rm -f /root/cron
#-------------------------
  msg -verd "    Con Exito!!!"       
  msg -bar3      
  else    
  msg -verm "    Con Fallo!!!"       
  msg -bar3      
  fi      
cd /root
#portFTP=$(lsof -V -i tcp -P -n | grep apache2 | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | cut -d: -f2 | cut -d' ' -f1 | uniq)
#_pFTP="$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep apache2 | cut -d " " -f1 | uniq)"
psi=`cat /root/psi.txt`
echo -e "${cor[5]} SERVER CONFIG:\033[0m"
msg -bar3
echo -e "${cor[2]} $psi \033[0m"
msg -bar3
echo -e "${cor[5]} PROTOCOLOS:\033[0m"
echo -e "${cor[5]} ¡ú FRONTED-MEEK-OSSH:${cor[2]} $httposh \033[0m"
echo -e "${cor[5]} ¡ú OSSH:${cor[2]} $osh \033[0m"
msg -bar3
echo -e " "
echo -e "${cor[5]} DIRECTORIO DE ARCHIVOS:${cor[2]} /root/psi \033[0m"
[[ -z $portFTP ]] && echo -e "SERVICIO FTP NO ACTIVO " || {
IP="$(cat < /bin/ejecutar/IPcgh)"
cp /root/psi.txt /var/www/html/psi.txt
echo -e "${cor[5]} RUTA PUBLICA DE CONFIG GENERADA:${cor[2]} http://$IP:${portFTP}/psi.txt \033[0m"
}
fi
msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSI DESEAS REINICIAR ESTE SERVICIO "
		echo -e " SE RECOMIENDA SOLO IR AL MENU PRINCIPAL"
		echo -e "        MENU 5, OPCION 25, SUBOBCION 1"
		echo -e " REINICIARAS TODOS LOS SERVICIOS SIN REINICIAR."
		echo -e "              TU SERVIDOR VPS\033[0m"
msg -bar3
}

antiddos (){
if [ -d '/usr/local/ddos' ]; then
	if [ -e '/usr/local/sbin/ddos' ]; then
		rm -f /usr/local/sbin/ddos
	fi
	if [ -d '/usr/local/ddos' ]; then
		rm -rf /usr/local/ddos
	fi
	if [ -e '/etc/cron.d/ddos.cron' ]; then
		rm -f /etc/cron.d/ddos.cron
	fi
	sleep 1s
	msg -bar3
	echo -e "\033[1;31m ANTIDDOS DESINSTALADO CON EXITO\033[1;37m"
	msg -bar3
	return 1
else
	mkdir /usr/local/ddos
fi
wget -q -O /usr/local/ddos/ddos.conf https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-MOD/master/DDOS/ddos.conf -o /dev/null
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE -o /dev/null
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list -o /dev/null
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh -o /dev/null
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
sleep 2s
msg -bar3
echo -e "${cor[2]} ANTIDDOS INSTALADO CON EXITO.\033[1;37m"
msg -bar3
}

_installXUI(){
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh) < /dev/null #> /dev/null 2>&1
return 1
}

v2ui() {
cd $HOME
title ' RESTRUCTURA DE INSTALACION DE SERVICIO X-UI WEB'
[[ ! -d /data ]] && mkdir /data
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
last_version=$(curl -Ls "https://api.github.com/repos/vaxilu/x-ui/releases/latest" | grep 'V' | sed -E 's/.*"([^"]+)".*/\1/')
msg -bar3
print_center -verm2 'ADVERTENCIA!!!\n ESTE SERVICIO FUE REFORMADO\n VERIFICA SI TIENES UN CORTAFUEGOS AL FINALIZAR \ O COLOCA apt purge ufw -y PARA QUITAR CORTAFUEGOS'
title ' INSTALANDO SERVICIO X-UI ESPERE!!!'
kill -9 $(ps x|grep -v grep|grep "xray-linu"|awk '{print $1}') &>/dev/null
kill -9 $(ps x|grep -v grep|grep "x-ui"|awk '{print $1}') &>/dev/null
_sleepColor '' '_installXUI'
meu_ip
autogen() {
x-ui start  > /dev/null 2>&1
cd /data
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=${state}/ST=${region}/L=${country}/O=$(cat < /bin/ejecutar/IPcgh):81/OU=ADMcgh Corp/CN=ChumoGH .Ing" -keyout "/data/xui.key" -out "/data/xui.crt" &>/dev/null
[[ -e /data/xui.crt ]] && chmod +x /data/xui.crt
[[ -e /data/xui.key ]] && chmod +x /data/xui.key
cd $HOME
_sleepColor '2'
chmod +x /data/* && echo -e "CERTIFICADO GENERADO"
}
creargen(){
x-ui start
x-ui enable
[[ ! -d /data ]] && mkdir /data > /dev/null 2>&1
[[ -d /data ]] && cd /data > /dev/null 2>&1
openssl genrsa 2048 > /data/xui.key
openssl req -new -key /data/xui.key -x509 -days 1000 -out /data/xui.crt
fun_bar
echo -e "CERTIFICADO GENERADO"
}
certdom () {
[[ ! -d /data ]] && mkdir /data
[[ -d /data ]] && cd /data
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
[[ -e /data/cert.crt && -e /data/cert.key ]] && {
cat /data/cert.key > /data/xui.key
cat /data/cert.crt > /data/xui.crt 
echo -e "CERTIFICADO GENERADO"
} ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
}

certweb () {
[[ -e /data/xui.key && -e /data/xui.crt ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar3
echo -e "Descarga el fichero URL del Certificado SSL " 
msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
msg -bar3
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar3
read -p " Pega tu Link : " urlm
wget --no-cache -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar3
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar3 
unzip certificados.zip &>/dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /data/xui.key && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt > /data/xui.crt && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip &>/dev/null && cd $HOME
}
}
local _temp=$(systemctl status x-ui | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
act_gen () {
while [[ ${varread} != @([0-5]) ]]; do
systemctl daemon-reload
systemctl enable x-ui
systemctl start x-ui
msg -bar3
print_center -verm2 "SELECCIONA UN METODO DE CERTIFICACION \nRECUERDA TENER EL PUERTO ${green}54321${plain} LIBRE\n LUEGO PODRAS EDITARLO A TU GUSTO!"
msg -bar3
print_center -verm "READ THE INSTRUCTIONS CAREFULLY BEFORE CONTINUING....."
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m${flech}\033[0;33m  Certificado AUTOMATICO    \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m${flech}\033[0;33m  Crear Su Certificado SSL  \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m${flech}\033[0;33m  Cargar Certificado WEB    \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m${flech}\033[0;33m  Certificado con DOMINIO   \033[0;32m(#OFICIAL)"
msg -bar3 
echo -e " \033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m Regresar"
msg -bar3
echo -ne "${cor[6]}"
read -p " Opcion : " varread
done
msg -bar3
if [[ ${varread} = 0 ]]; then
return 0
elif [[ ${varread} = 1 ]]; then
autogen
elif [[ ${varread} = 2 ]]; then
creargen
elif [[ ${varread} = 3 ]]; then
certweb
elif [[ ${varread} = 4 ]]; then
certdom
fi
}
act_gen
if [[ x"${_temp}" == x"running" ]]; then
        clear&&clear
			title 'INSTALACION FINALIZADA X-UI WEB'
			print_center -verm2 "ADVERTENCIA!!!\nAbre tu navegador con http://$(cat < /bin/ejecutar/IPcgh):54321 \n COLOCA TUS CREDENCIALES DE ACCESO\n RECUERDA QUE POR DEFECTO SON * admin *"
			msg -bar3
			echo -e "\033[1;31m En cert file path : ${cor[5]}/data/xui.crt "
			echo -e "\033[1;31m En key  file path : ${cor[5]}/data/xui.key "
			msg -bar3
			echo -e " -DISFRUTA TU CONFGURACION SI TODO ES CORRECTO -"
			msg -bar3
			echo -e " - Si deseas acceder al PANNEL teclea \033[1;35mx-ui ${cor[2]}en consola -"
			msg -bar3
			echo -e "  MANUAL EN EL PORTAL https://seakfind.github.io/2021/10/10/X-UI/ "
			msg -bar3
			curl -o /usr/bin/x-ui -sSL https://www.dropbox.com/s/lf2b5rhkasgjr8g/x-ui.sh
			chmod +x /usr/bin/x-ui
			msg -ama "        UNLOCK SYSTEMCTL ...."
			  if systemctl daemon-reload &> /dev/null ;then
			  msg -verd "        Con exito!!!"    
			  msg -bar3
			  else    
			  msg -verm "        Con fallo!!!"    
			  msg -bar3
			fi
			msg -ama "        HABILITANDO X-UI ...."
			if x-ui enable &> /dev/null ;then
			  msg -verd "        Con exito!!!"    
			  msg -bar3
			  else    
			  msg -verm "        Con fallo!!!"    
			  msg -bar3
			fi

			msg -ama "        Reiniciando X-UI ...."
			  if systemctl restart x-ui &> /dev/null ;then
			  msg -verd "        Con exito!!!"    
			  msg -bar3
			  else    
			  msg -verm "        Con fallo!!!"    
			  msg -bar3
			fi
			[[ -f "/usr/sbin/ufw" ]] && ufw allow 54321/tcp 1>/dev/null 2>/dev/null &
		else
			title 'SERVICIO X-UI NO INSTALADO'
			read -p " PRESIONE ENTER PARA FINALIZAR"
		return 
fi
}

v2ray-socket() {
msg -bar3
echo -e "MOTOR DE INSTALACION DE PANNEL WEB Y CONSOLA DE V2RAY Y XRAY"
msg -bar3
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m${flech}\033[0;33m  MENU LITE  V2RAY  @ChumoGH MultiCuentas  \033[0;32m(#OFICIAL)   " #\033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m${flech}\033[0;33m  V2RAY.MENU CUSTOM @ChumoGH MultiCuentas  \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m${flech}\033[0;33m  MENU LITE   XRAY  @ChumoGH MultiCuentas  \033[0;32m(#OFICIAL)   " #\033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m${flech}\033[0;33m  Original (Todo en Consola)               \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m${flech}\033[0;33m  Pannel WEB ( X-UI RAY ) TRADUCIDO        \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m${flech}\033[0;33m  Pannel WEB ( 3X-UI )         \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m7\033[0;35m] \033[0;34m${flech}\033[0;33m  DESINSTALAR V2RAY ( TODOS MENUS ) "
#echo -e " \033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m${flech}\033[0;33m  FIX PARA INSTALLS FAILS DE V2RAY  "
msg -bar3 
selection=$(selection_fun 6)
case ${selection} in
1)[[ $(which v2r.sh) ]] && $(which v2r.sh) || source <(curl -sSL https://www.dropbox.com/s/yxpjpgcwyrvitl6/v2ray_manager.url.sh) ;;
2)[[ -e /etc/v2ray/config.json ]] && source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh) || source <(curl -sSL https://www.dropbox.com/s/q6mpwhfgt1665pl/v2ray.sh) ;;
3)[[ $(which xr.sh) ]] && $(which xr.sh) || source <(curl -sSL https://www.dropbox.com/s/olvy10kff2wwe8f/xray_manager.sh) ;;
4)[[ -e /etc/v2ray/config.json ]] && v2ray;;
5)[[ -e /usr/bin/x-ui ]] && x-ui || v2ui;;
6)clear&&clear
msg -bar3
print_center -verm " ADVERTENCIA !!! "
msg -bar3
print_center -ama " VERSION DE X-UI COMPATIBLE SOLO CON " 
print_center -verd "- Ubuntu 20.04+ \n - Debian 11+ \n - CentOS 8+ \n - Fedora 36+ \n - Arch Linux \n - Parch Linux \n - Manjaro \n - Armbian \n - AlmaLinux 9+ \n - Rocky Linux 9+ \n - Oracle Linux 8+ \n - OpenSUSE Tumbleweed \n"
msg -bar3
read -p "  ENTER PARA CONTINUAR | CONTRL + C PARA CANCELAR |"
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
;;
7)
source <(curl -sL https://multi.netlify.com/v2ray.sh) --remove
source <(curl -sL https://git.io/fNgqx) --remove
rm -rf /usr/local/V2ray.Fun
rm -f /etc/v2ray/*
rm -rf /etc/v2ray/
[[ -e $(which v2r.sh) ]] && rm -f $(which v2r.sh)
[[ -e $(which xr.sh) ]] && rm -f $(which xr.sh)
[[ -e $(which v2ray.menu) ]] && rm -f $(which v2ray.menu)
[[ -d /etc/v2r ]] && rm -rf /etc/v2r
[[ -d /etc/xr ]] && rm -rf /etc/xr
return
;;
*)
return 0
;;
esac
}

fun_openvpn () {
source <(curl -sSL https://www.dropbox.com/s/q5kvrcbjwcmcsut/openvpn.sh)

}


BlockADS() {
clear && header
[[ -e /etc/.hosts.original ]] && _ADS="\033[0;31m[\033[0;32mON\033[0;31m]" || _ADS="\033[1;31m[OFF]"
menu_item "\033[0;33m [!] \033[1;32mINSTALAR BLOQUEADOR DE ADS $_ADS" "\033[0;33m [!] \033[0;31mREMOVER BLOQUEADOR DE ADS "
	selection=$(selection_fun 2)
	case ${selection} in
		0)
			return 0
		;;
		1)
		cd $HOME
		[[ ! -d /opt/adaway ]] && mkdir -p /opt/adaway || rm -rf /opt/adaway/*
		[[ $(dpkg --get-selections|grep -w "git"|head -1) ]] || apt-get install git -y &>/dev/null
		if git clone https://github.com/sedrubal/adaway-linux.git &>/dev/null ; then
			echo "Recolectando ADS Blocket $(date '+%Y-%m-%d')"
			cd adaway-linux && cp * /opt/adaway 
			chmod +x /opt/adaway/*
			cd /opt/adaway && ./install.sh -i
			./adaway-linux.sh
			[[ $(cat /etc/hosts | grep "0.0.0.0" | grep -v grep) ]] && sed -i "s/0.0.0.0/127.0.0.1/g" /etc/hosts
			cd $HOME && rm -rf adaway-linux
			else
			echo "Fallo al VALIDAR ADS"
			sleep 2s
			return
		fi
		;;
		2)
		cd /opt/adaway && ./install.sh -u
		cd $HOME && rm -rf /opt/adaway
		;;
		esac
}

filemanager () {
print_center -verm2 ' ESTE ES UN ADMINISTRADOR DE FILES WEB \n FILEBROWSER \n\n GitHub: https://github.com/filebrowser/filebrowser \n\n '
[[ $(ps x | grep filebrowser | grep -v grep) ]] && {
killall filebrowser &> /dev/null
} || {
[[ -z $(which filebrowser) ]] && curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash &> /dev/null
read -p " INGRESA PUERTO : " webrowser
nohup filebrowser -a $(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1) -b / -p ${webrowser} -r /root/& > /dev/null
msg -bar3 
echo ""
echo -e " SERVICIO ACTIVO EN URL : http://$(cat /bin/ejecutar/IPcgh):${webrowser}/"
echo ""
echo -e " ACCEDE CON LAS CREDENCIALES : admin "
echo ""
msg -bar3
}
read -p " PRESIONA ENTER PARA CONTINUAR"
}


funARQONLINE () {
#apache2
clear&&clear
header
#[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
# apt-get install apache2 -y &>/dev/null
# sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
# service apache2 restart > /dev/null 2>&1 &
# }
#[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
#echo -e "\033[97m  # apt-get install apache2.............. $ESTATUS "
tput cuu1 >&2 && tput dl1 >&2
meu_ip
[[ $(ps x | grep filebrowser | grep -v grep) ]] && file="\e[32m[ ON ] " || file="\e[31m[ OFF ]" 
menu_item "\033[0;33mCOLOCAR ARCHIVO ONLINE  \033[0;32m(#)" "\033[0;33mREMOVER ARCHIVO ONLINE  \033[0;32m(#)" "\033[0;31mVER MIS ARCHIVOS ONLINE \033[0;33m(#)" "\033[0;31mDESINATALAR APACHE (FTP) \033[0;33m(#)" "\033[0;31mCAMBIAR PUERTO APACHE (FTP) ${portFTP} \033[0;33m(#)" "CAMBIAR DE APACHE2 A NGINX" "INSTALAR APACHE2 ( FTP )" "FILEMANAGER WEB ${file}"
selection=$(selection_fun 6)
case ${selection} in
0)
return
;;
2)
msg -bar3
unset _cont
_cont="1"
for my_arqs in `ls /var/www/html`; do
if [ "$my_arqs" != "index.html" ]; then
 if [ ! -d "$my_arqs" ]; then
select_arc[$_cont]="$my_arqs"
echo -e "\033[0;35m [\033[0;36m$_cont\033[0;35m]\033[0;33m ➮ ${cor[3]} $my_arqs => \033[1;36mhttp://$IP:${portFTP}/$my_arqs\033[0m"
_cont=$(($_cont + 1))
 fi
fi
done
_cont=$(($_cont - 1))
msg -bar3  
echo -e "${cor[5]} Seleccione un archivo:"
read -p " [ 1-$_cont ]: " slct
number_var $slct
[[ -z ${var_number} ]] && return || slct="${var_number}"
unset _cont
arquivo_move="${select_arc[$slct]}"
 if [ "$arquivo_move" = "" ]; then
echo -e "${cor[5]} Ningún archivo ha sido seleccionado"
msg -bar3  
read -p "PRESIONE ENTER PARA CONTINUAR"
 fi
rm -rf /var/www/html/$arquivo_move > /dev/null 2>&1
rm -rf /var/www/$arquivo_move > /dev/null 2>&1
echo -e "${cor[5]} Procedimiento Hecho Con Éxito"
msg -bar3  
read -p "PRESIONE ENTER PARA CONTINUAR"
;;
1)
unset _cont
_cont="1"
msg -bar3  
echo -e "${cor[5]} FICHEROS EN $HOME"
msg -bar3  
for my_arqs in `ls $HOME`; do
if [ ! -d "$my_arqs" ]; then
select_arc[$_cont]="$my_arqs"
echo -e "\033[0;35m [\033[0;36m$_cont\033[0;35m]\033[0;33m ➮ ${cor[3]}$my_arqs"
_cont=$(($_cont + 1))
fi
done
_cont=$(($_cont - 1))
msg -bar3  
echo -e "${cor[5]} SELECCIONA EL FICHERO"
read -p " 『 1-$_cont 』:  " slct
number_var $slct
if [ "$var_number" = "" ]; then
return
 else
slct="$var_number"
fi
unset _cont
arquivo_move="${select_arc[$slct]}"
if [ "$arquivo_move" = "" ]; then
echo -e "${cor[5]} NINGUN FICHERO SELECCIONADO"
msg -bar3  
return
fi
[[ ! -d /var ]] && mkdir /var
[[ ! -d /var/www ]] && mkdir /var/www
[[ ! -d /var/www/html ]] && mkdir /var/www/html
[[ ! -e /var/www/html/index.html ]] && touch /var/www/html/index.html
[[ ! -e /var/www/index.html ]] && touch /var/www/index.html
chmod -R 755 /var/www
cp $HOME/$arquivo_move /var/www/$arquivo_move
cp $HOME/$arquivo_move /var/www/html/$arquivo_move
chmod 777 /var/www/html/*
msg -bar3  
echo -e "${cor[5]} ACCESO AL ARCHIVO ATRAVES DEL ENLACE"
msg -bar3
echo -e "\033[1;36m http://$IP:${portFTP}/$arquivo_move\033[0m"
msg -bar3
echo -e "${cor[5]} Procedimiento Hecho Con Éxito"
msg -bar3 
read -p "PRESIONE ENTER PARA CONTINUAR"
;;
3)
msg -bar3
for my_arqs in `ls /var/www/html`; do
if [ "$my_arqs" != "index.html" ]; then
 if [ ! -d "$my_arqs" ]; then
echo -e " \033[1;36mhttp://$IP:${portFTP}/$my_arqs\033[0m"
 fi
fi
done
msg -bar3
read -p "PRESIONE ENTER PARA CONTINUAR"
return 0
;;
4)
apt purge apache2 -y &>/dev/null
rm -f /var/www/html/*
;;
5)
header
read -p "INGRESA EL NUEVO PUERTO FTP WEB : " _pt
tput cuu1 >&2 && tput dl1 >&2
[[ -z ${_pt} ]] && _pt='81'
apt install apache2 -y &>/dev/null
echo -e "#Apache2 Power By @ChumoGH
Listen ${_pt}

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>" > /etc/apache2/ports.conf
#sed -i "s;Listen ${portFTP};Listen ${_pt};g" /etc/apache2/ports.conf
service apache2 restart &>/dev/null
read " SERVICIO INSTALADO EN EL PUERTO ${_pt}"
;;
6)
tittle
echo -e " ESTA ACCION NO SE PODRA REVERTIR"
echo -e " SI NO ESTAS SEGURO DE UTILIZARLA"
read -p " PRECIONA cltr + c PARA ANULAR"
[[ $(dpkg --get-selections|grep -w "nginx"|head -1) ]] || {
apt purge apache2 -y &>/dev/null
service apache2 stop &>/dev/null
apt-get install nginx -y &>/dev/null
read -p "PUERTO NFINX WEB : " _pt
tput cuu1 >&2 && tput dl1 >&2
[[ -z ${_pt} ]] && _pt='81'
[[ $(dpkg --get-selections|grep -w "nginx"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nginx"|head -1) ]] && ESTATUS=`echo -e "\e[3;32mINSTALADO\e[0m"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && apt purge apache2 -y &>/dev/null
echo "server {
        listen ${_pt} default_server;
        listen [::]:${_pt} default_server;
" > /etc/nginx/sites-available/default
echo '
        root /var/www/html;
        index index.html index.htm index.php;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
' >> /etc/nginx/sites-available/default
}
service apache2 stop &>/dev/null
service nginx start &>/dev/null
echo -e "\033[97m  # SERVIDOR WEB NGINX................ $ESTATUS " 
msg -bar3
echo -e " AHORA SU GESTOR FTP WEB ES NGINX "
msg -bar3
print_center -verm2 ' NOTA!!\n\n SI EL SERVICIO NO SE INICIA AUTOMATICAMENTE \n DIJISTA FUERA DEL SCRIPT \n service nginx restart'
msg -bar3
read -p " TAREA FINALIZADA, ENTER PARA RETORNAR"
;;
7)
header
read -p "INGRESA EL NUEVO PUERTO FTP WEB : " _pt
tput cuu1 >&2 && tput dl1 >&2
[[ -z ${_pt} ]] && _pt='81'
apt purge nginx -y &>/dev/null
service nginx stop &>/dev/null
apt install apache2 -y &>/dev/null
echo -e "#Apache2 Power By @ChumoGH
Listen 81

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>" > /etc/apache2/ports.conf
#sed -i "s;Listen ${portFTP};Listen ${_pt};g" /etc/apache2/ports.conf
service apache2 restart &>/dev/null
msg -bar3
print_center -verm2 ' NOTA!!\n\n SI EL SERVICIO NO SE INICIA AUTOMATICAMENTE \n DIJISTA FUERA DEL SCRIPT \n service apache2 restart'
msg -bar3
read -p " TAREA FINALIZADA, ENTER PARA RETORNAR"
;;
8)
filemanager
;;
esac
}

funDETSYS() {
    local error_color="\033[1;31m"     # Rojo para los mensajes de error
    local title_color="\033[1;34m"     # Azul para los títulos y encabezados
    local label_color="\033[1;36m"     # Cian para las etiquetas
    local value_color="\033[1;32m"     # Verde para los valores
    local reset_color="\033[0m"        # Restablecer el color

    msg -bar3
    
    # Verificar la existencia de archivos críticos para obtener información del sistema
    for file in /proc/cpuinfo /etc/issue.net /proc/meminfo; do
        if [ ! -f "$file" ]; then
            echo -e "${error_color}Error: No se puede acceder al archivo $file${reset_color}"
            msg -bar3
            return 1
        fi
    done

    # Obtener información del sistema
    local total_ram=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    local used_ram=$((total_ram - $(awk '/MemAvailable/ {print $2}' /proc/meminfo)))
    local free_ram=$(awk '/MemFree/ {print $2}' /proc/meminfo)
    local swap_ram=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
    local system=$(cat /etc/issue.net)
    local clock_speed=$(lscpu | awk '/MHz/ {print $3}')
    local base_distro=$(awk -F= '/^ID_LIKE/ {print $2}' /etc/*release)
    local processor=$(awk -F': ' '/model name/ {print $2}' /proc/cpuinfo | uniq)
    local cpu_cores=$(grep -c processor /proc/cpuinfo)
    local cpu_usage=$(awk '{sum += $3} END {print sum "%"}' <(ps aux))
    local vendor_id=$(lscpu | awk -F': ' '/Vendor ID/ {print $2}')
    local uptime=$(uptime -p)
    local hostname=$(hostname)
    local ip_address=$(hostname -I | awk '{print $1}')
    local kernel_version=$(uname -r)
    local architecture=$(uname -m)

    # Mostrar información del sistema
    echo -e "${title_color}Información del Sistema:${reset_color}"
    echo -e "${label_color}Sistema Operativo    : ${value_color}${system:-"Desconocido"}${reset_color}"
    echo -e "${label_color}Distribución Basada  : ${value_color}${base_distro:-"Desconocido"}${reset_color}"
    echo -e "${label_color}Nombre del Procesador: ${value_color}${processor:-"Desconocido"}${reset_color}"
    echo -e "${label_color}Núcleos del CPU      : ${value_color}${cpu_cores}${reset_color}"
    echo -e "${label_color}Frecuencia del CPU   : ${value_color}${clock_speed:-"Desconocido"} MHz${reset_color}"
    echo -e "${label_color}Uso del Procesador   : ${value_color}${cpu_usage}${reset_color}"
    echo -e "${label_color}ID del Vendedor CPU  : ${value_color}${vendor_id:-"Desconocido"}${reset_color}"
    echo -e "${label_color}Memoria Total (MB)   : ${value_color}$((total_ram / 1024))${reset_color}"
    echo -e "${label_color}Memoria Usada (MB)   : ${value_color}$((used_ram / 1024))${reset_color}"
    echo -e "${label_color}Memoria Libre (MB)   : ${value_color}$((free_ram / 1024))${reset_color}"
    echo -e "${label_color}Memoria Swap (MB)    : ${value_color}$((swap_ram / 1024))${reset_color}"
    echo -e "${label_color}Tiempo de Actividad  : ${value_color}${uptime}${reset_color}"
    echo -e "${label_color}Nombre de la Máquina : ${value_color}${hostname}${reset_color}"
    echo -e "${label_color}Dirección IP         : ${value_color}${ip_address}${reset_color}"
    echo -e "${label_color}Versión del Kernel   : ${value_color}${kernel_version}${reset_color}"
    echo -e "${label_color}Arquitectura         : ${value_color}${architecture}${reset_color}"
    msg -bar3
}



function tcpd(){
echo -e "A continuacion se instalara el TCP DNS"
echo -e "Este paquete solo funcionara en Debian/Ubuntu"
echo -e "AVISO!!!"
echo -e "Para realizar la instalacion de TCP DNS"
echo -e "Debes configurar previamente tu DNS/Dominio"
echo -e "Si aun no lo haz configurado el DNS/Dominio"
echo -e "Presiona CTRL + C para cancelar la instalacion"
echo -e "Si ya configuraste tu DNS/Dominio Correctamente, presiona ENTER"
read -p " "
echo -e "Espera un momento..."
echo -e "Limpiando DNS Primario..."
sleep 1
sed -i '/DNSStubListener/d' /etc/systemd/resolved.conf
echo -e "Agregando Fix DNS Primario..."
sleep 1
echo "DNSStubListener=no" >> /etc/systemd/resolved.conf
echo -e "Reiniciando DNS Primario..."
sleep 1
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved
echo -e "Instalando paquetes Necesarios, espere... "
sleep 1
apt-get install python-pip -y 1>/dev/null 2>/dev/null &
apt-get install libevent-dev -y 1>/dev/null 2>/dev/null &
apt-get install python-gevent -y 1>/dev/null 2>/dev/null &
apt-get install python-daemon -y 1>/dev/null 2>/dev/null &
git clone https://github.com/henices/Tcp-DNS-proxy.git 1>/dev/null 2>/dev/null &
cd Tcp-DNS-proxy/
wget https://raw.githubusercontent.com/serverdensity/python-daemon/master/daemon.py
chmod +x ./install.sh
./install.sh
screen -dmS tcpdns python tcpdns.py -f tcpdns.json.example
cd /root
echo -e "TCP DNS Instalado"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
return 0
}

slow-dns () {
clear&&clear
apt-get install ncurses-utils > /dev/null 2>&1
msg -bar3
[[ ! -d /etc/adm-lite/slow/ ]] && mkdir /etc/adm-lite/slow/
[[ -e /etc/ADMcgh/bin/SlowDNS.sh ]] || {
rm -f /bin/SlowDNS.sh
wget -q --no-check-certificate -O /etc/ADMcgh/bin/SlowDNS.sh https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/SlowDNS.sh
chmod +x /etc/ADMcgh/bin/SlowDNS.sh
ln -s /etc/ADMcgh/bin/SlowDNS.sh /bin/SlowDNS.sh
}
/bin/SlowDNS.sh
pkill SlowDNS.sh &>/dev/null
}

_funUDP () {
source <(curl -sSL https://www.dropbox.com/s/ijch60gm20rrobn/UDPserver.sh)
}

function dnsserver(){
echo -e "Instalando DNS Server"
curl -sSL https://download.technitium.com/dns/install.sh | bash 1>/dev/null 2>/dev/null &
echo -e "Actualizando DNS del Servidor"
echo -e "DNS Server Instalado"
echo -e "Consola Web DNS Server: http://$(cat < /bin/ejecutar/IPcgh):5380/"
echo -e "No olvide establecer su password admin del Panel"
}

fun_chisel() {
		cor1='\033[41;1;37m'
		cor2='\033[44;1;37m'
		scor='\033[0m'
		GREEN='${cor[2]}'
		YELLOW='${cor[5]}'
		SCOLOR='\033[0m'
		echo -e "\E[44;1;37m            GERENCIAR CHISEL             \E[0m"
		echo ""


		[[ "$(netstat -tlpn | grep 'docker' | wc -l)" != '0' ]] && {
			sks='${cor[2]}ON'
			echo -e "${cor[5]}PORTAS\033[1;37m: ${cor[2]}$(netstat -nplt | grep 'docker' | awk {'print $4'} | cut -d: -f2 | xargs)"
		} || {
			sks='\033[1;31mOFF'
		}
        [[ "$(netstat -tlpn | grep 'docker' | wc -l)" != '0' ]] && {
				chiselsts="${cor[2]}â—?? "
			} || {
				chiselsts="\033[1;31mâ—?? "
			}
		echo ""
		echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37mâ€?? ${cor[5]}ATIVAR CHISEL $chiselsts \033[0m"
		echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37mâ€?? ${cor[5]}REINICIAR CHISEL\033[0m"
		echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37mâ€?? ${cor[5]}VOLTAR\033[0m"
		echo ""
		echo -ne "${cor[2]}Raj, escolhe uma carta ${cor[5]}?\033[1;37m "
		read resposta
		if [[ "$resposta" = '1' ]]; then
			if netstat -nltp | grep 'docker' 1>/dev/null 2>/dev/null; then
				clear
				echo -e "\E[41;1;37m             CHISEL              \E[0m"
				echo ""
				fun_chiseloff() {
					docker stop chisel
                    docker rm chisel
					docker.io stop chisel
                    docker.io rm chisel

				}
				echo -e "${cor[2]}DESACTIVANDO CHISEL${cor[5]}"
				echo ""
				fun_bar 'fun_chiseloff'
				echo ""
				echo -e "${cor[2]}CHISEL DESACTIVADO CON EXITO!${cor[5]}"
				sleep 3
				fun_chisel
			else
                clear
                fun_installdocker() {
                    _pacotes=("docker" "docker.io")
                    for _prog in ${_pacotes[@]}; do
                    apt install $_prog -y
                    done
                }
                echo -e "\n${YELLOW}ESTEJA CIENTE QUE ESSE METODO Ã‰ INSTAVEL\nPODE OU NÃƒO FUNCIONAR NA SUA MAQUINA\nFIQUE CIENTE DOS RISCOS ! ${SCOLOR}\n"
                echo -ne "${GREEN}DESEJA CONTINUAR A INSTALACAO ? ${YELLOW}[s/n]:${SCOLOR} "
                read resp
                [[ "$resp" != @(s|sim|S|SIM) ]] && {
                    echo -e "\n${RED}Retornando...${SCOLOR}"
                    sleep 2
                    conexao
                }
                echo -e "\n${cor[2]}SOPORTE A Ubuntu 16+ ${cor[5]}"
                echo -e "\n${cor[2]}INSTALANDO O CHISEL !${cor[5]}"
				echo ""
				fun_bar 'fun_installdocker'
				clear
				echo -e "\E[44;1;37m             CHISEL              \E[0m"
				echo ""
				echo -ne "${cor[2]}CUAL PORTA DESEA ULTILIZAR ${cor[5]}?\033[1;37m: "
				read porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPUERTO INVALIDO!"
					sleep 3
					clear
					fun_chisel
				}
				verif_ptrs $porta
                clear
                echo -ne "${cor[2]}NOMBRE DE USUARIO:\033[1;37m ";read username
                [[ -z $username ]] && {
                    echo -e "\n${cor1}NO INGRESO NOMBRE DE USUARIO!${scor}\n"
                    fun_chisel
                }
                [[ ${username} != ?(+|-)+([a-zA-Z0-9]) ]] && {
                    echo -e "\n${cor1}SU NOMBRE DE USUARIO ES INCORRECTO!${scor}"
                    echo -e "${cor1}NO USE ESPACIOS, NI CARACTERES ESPECIALES!${scor}\n"
                    fun_chisel
                }
                sizemin=$(echo ${#username})
                [[ $sizemin -lt 2 ]] && {
                    echo -e "\n${cor1}VocÃª digitou um nome de usuÃ¡rio muito curto${scor}"
                    echo -e "${cor1}use no mÃ­nimo dois caracteres!${scor}\n"
                    fun_chisel
                }
                sizemax=$(echo ${#username})
                [[ $sizemax -gt 10 ]] && {
                    echo -e "\n${cor1}VocÃª digitou um nome de usuÃ¡rio muito grande"
                    echo -e "${cor1}use no mÃ¡ximo 10 caracteres!${scor}\n"
                    fun_chisel
                }
                echo -ne "${cor[2]}CONTRASEÃ‘A:\033[1;37m ";read password
                [[ -z $password ]] && {
                    echo -e "\n${cor1}NO SE INGRESO CONTRASEÃ‘A!${scor}\n"
                    fun_chisel 
                }
                sizepass=$(echo ${#password})
                [[ $sizepass -lt 4 ]] && {
                    echo -e "\n${cor1}CONTRASEÃ‘A MUY CORTA, USE MINIMO 4 CARACTERES${scor}\n"
                    fun_chisel        
                }
                echo -e "\n${cor[2]}CONFIGURANDO CHISEL !\033[0m"
				echo ""
                fun_inichisel() {
                    docker run --name chisel -p $porta:$porta -d --restart always jpillora/chisel server -p $porta --socks5 --key supersecret --auth "$username:$password"
                    docker.io run --name chisel -p $porta:$porta -d --restart always jpillora/chisel server -p $porta --socks5 --key supersecret --auth "$username:$password"
                }
                fun_bar 'fun_inichisel'
                clear
                echo -e "\n${cor[2]}CHISEL INSTALADO EXITOSAMENTE !\033[1;31m PORTA: ${cor[5]}${porta}\033[0m"
				sleep 3
				clear
				fun_chisel
            fi
        elif [[ "$resposta" = '2' ]]; then
            clear
            echo -e "\n${cor[2]}REINICIANDO CHISEL !${cor[5]}"
			echo ""
            fun_attchisel() {
                docker restart chisel
                docker.io restart chisel
            }
            fun_attchisel
            clear
            echo -e "\n${cor[2]}CHISEL REINICIANDO EXITOSAMENTE !${cor[5]}"
            sleep 1
            fun_chisel
        elif [[ "$resposta" = '0' ]]; then
			echo ""
			echo -e "\033[1;31mRetornando...\033[0m"
			sleep 1
			return
		else
			echo ""
			echo -e "\033[1;31mOpcao invalida !\033[0m"
			sleep 1
			fi
    }

fix_vultr () {
msg -bar3
echo -e 'Aplicando FIX para Vultr VPS Passwd'
echo -e "Añadiendo Registro a PAM.D"
#sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password
apt-get install libpam-cracklib -y > /dev/null 2>&1
echo -e '#
password [success=1 default=ignore] pam_unix.so obscure sha512
password requisite pam_deny.so
password required pam_permit.so' > /etc/pam.d/common-password && chmod +x /etc/pam.d/common-password
msg -bar3
echo -e " Registro agregado "
msg -bar3
}

funBadVPN () {
clear&&clear
msg -bar3
print_center -verm2 ' NOTA!!\n\n BADVPN UDP SE INSTALARA EN EL SISTEMA \n PROTOCOLO UDP QUE LIBERA EL SERVICIO DE   \n VIDEOLLAMADAS Y JUEGOS EN LINEA'
msg -bar3
print_center -verd  ' INICIANDO . . .'
msg -bar3
#source <(curl -sSL https://www.dropbox.com/s/0stqb3dzm47kky6/budp.sh)
[[ ! -e /etc/ADMcgh/bin/budp.sh ]] && {
  if wget --no-cache -O /etc/ADMcgh/bin/budp.sh https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/budp.sh &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/budp.sh
  ln -s /etc/ADMcgh/bin/budp.sh /bin/budp.sh
  msg -verd "[OK]"  
 /etc/ADMcgh/bin/budp.sh
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
} || {
msg -verd "[OK]"  
/etc/ADMcgh/bin/budp.sh
}
pkill budp.sh &>/dev/null
return
}

while true; do	
unset squid
unset dropbear
unset openvpn
unset stunel
unset shadow
unset telegran
unset socks
unset gettun
unset tcpbypass
unset webminn
unset ddos
unset v2ray
local _portbaSE="$(netstat -tunlp)"
local _ps="$(ps x)"
[[ $(echo -e "$_portbaSE" | grep ssh) ]] && pSSH="${_on}" || pSSH="\033[1;31m[OFF]"
[[ $(echo -e "$_portbaSE" | grep -w "trojan") ]] && pTROJ="${_on} " || pTROJ="\033[1;31m[OFF]"
[[ $(echo -e "$_portbaSE" | grep -w "psiphond") ]] && pps="${_on} " || pps="\033[1;31m[OFF]"
[[ $(echo -e "$_portbaSE" | grep -w "v2ray") ]] && v2ray="${_on} " || {
[[ $(echo -e "$_portbaSE" | grep "x-ui") ]] && v2ray="\033[1;32m[\033[0;34mUI\033[1;32m] " || v2ray="\033[1;31m[OFF]"
}
[[ $(echo -e "$_portbaSE" | grep -w "clash") ]] && xclash="${_on} " || {
[[ -e /root/.config/clash/config.yaml ]] && xclash="\033[1;32m[\033[0;34mCFA\033[1;32m]" || xclash="\033[1;31m[OFF]"
}
[[ $(echo -e "${_ps}"| grep udpServer| grep -v grep) ]] && _pidUDP="\033[0;34m[US] " || {
	[[ $(echo -e "${_ps}"| grep UDP-Custom| grep -v grep) ]] && _pidUDP="\033[1;32m[\033[0;34mUC\033[1;32m] " || {
		[[ $(echo -e "${_ps}"| grep hysteria| grep -v grep) ]] && _pidUDP="\033[1;32m[\033[0;34mHYS\033[1;32m] " || {
		[[ $(echo -e "${_ps}"| grep ZipVPN| grep -v grep) ]] && _pidUDP="\033[1;32m[\033[0;34mZIP\033[1;32m] " 
		}
	} || _pidUDP="\033[1;31m[OFF]"
}
[[ ! -z $(echo -e "${_ps}"| grep "badvpn" | grep -v "grep") ]] && _badvpn="$_on" || _badvpn="$_off"
local slowpid=$(echo -e "${_ps}" | grep -w "dns-server" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $slowpid ]] && P1="\033[0;31m[\033[0;32mON\033[0;31m] " || P1="\033[1;31m[OFF]"
[[ -e /etc/squid3/squid.conf ]] && squid="${_on} " || squid="\033[1;31m[OFF]"
[[ -e /etc/squid/squid.conf ]] && squid="${_on} " || squid="\033[1;31m[OFF]"
[[ $(echo -e "$_portbaSE" |grep dropbear|head -1) ]] && dropb="${_on} " || dropb="\033[1;31m[OFF]"
[[ -e /etc/openvpn/server.conf ]] && openvpn="${_on} " || openvpn="\033[1;31m[OFF]"
[[ $(echo -e "$_portbaSE" |grep stunnel|head -1) ]] && stunel="${_on} " || stunel="\033[1;31m[OFF]"
[[ -e /etc/shadowsocks.json ]] && shadow="${_on}" || shadow="\033[1;31m[OFF]"
[[ "$(echo -e "${_ps}" | grep "ultimatebot" | grep -v "grep")" != "" ]] && telegran="${_on}"
[[ $(echo -e "${_ps}" | grep "PDirect") ]] && socks="\033[1;32m[\033[0;34mPyD\033[1;32m]" || {
#[[ $(echo -e "${_ps}" | grep 'python /*/*/*.*' | grep -v grep) ]] && socks="\033[1;32m[\033[0;34mPyD\033[1;32m]" || socks="\033[1;31m[OFF]"
[[ $(echo -e "${_ps}" | grep 'WS-Epro') ]] && socks="\033[1;32m[\033[0;34mW-S\033[1;32m]" || socks="\033[1;31m[OFF]"
}
[[ $(echo -e "${_ps}" | grep "PDirect80") ]] && socksA="\033[1;32m[\033[0;34mRUN\033[1;32m]" || socksA="\033[1;31m[OFF]"
[[ -e /etc/adm-lite/edbypass ]] && tcpbypass="${_on}" || tcpbypass="\033[1;31m[OFF]"
[[ -e /etc/webmin/miniserv.conf ]] && webminn="${_on}" || webminn="\033[1;31m[OFF]"
[[ -e /usr/local/x-ui/bin/config.json ]] && v2ui="${_on}" || v2ui="\033[1;31m[OFF]"
[[ -e /usr/local/etc/trojan/config.json ]] && troj="${_on}" || troj="\033[1;31m[OFF]"
[[ -e /etc/default/sslh ]] && sslh="${_on} " || sslh="\033[1;31m[OFF]"
[[ -e /usr/local/ddos/ddos.conf ]] && ddos="${_on}"
local ssssrr=`ps -ef |grep -v grep | grep server.py |awk '{print $2}'`
[[ ! -z "${ssssrr}" ]] && cc="\033[1;32m" || cc="\033[1;31m"
[[ -d /usr/local/shadowsocksr ]] && { 
local user_info=$(cd /usr/local/shadowsocksr &> /dev/null  && python mujson_mgr.py -l )
local user_t="\033[1;33m$(echo "${user_info}"|wc -l) Cts" 
} || user_t="\033[1;31m[OFF]"
[[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]] && _tcpd="\033[1;31m[OFF]" || _tcpd="${_on} "
[[ "$(cat /etc/pam.d/common-password | grep ChumoGH | wc -l)" != '0' ]] && _fv="${_on}" || _fv="\033[1;31m[OFF]"
[[ -e /etc/.hosts.original ]] && _ADS="${_on}" || _ADS="\033[1;31m[OFF]"
[[ "$(echo -e "$_portbaSE"  | grep 'docker' | wc -l)" != '0' ]] && chiselsts="${_on}" || chiselsts="\033[1;31m[OFF]"
IFS=$'\n' read -r -d '' country region state <<< $(curl -sSL ipinfo.io | grep -E "country|region|city" | awk '{print $2}' | sed -e 's/[^a-zA-Z0-9 -]//g')
clear&&clear
msg -bar3
#tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2
echo -e "${cor[5]} ${h0nG} INSTALACION DE PROTOCOLOS ( ${country}) ${h0nG} "
msg -bar3 #SHADOWSOCKS   $user_t
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;33m${flech} ${cor[3]}OpenSSH       $pSSH  \033[0;35m [\033[0;36m11\033[0;35m]\033[0;33m${flech} ${cor[3]}PSIPHON SERVER $pps"
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;33m${flech} ${cor[3]}DROPBEAR      $dropb \033[0;35m [\033[0;36m12\033[0;35m]\033[0;33m${flech} ${cor[3]}TCP DNS        \033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;36m3\033[0;35m]\033[0;33m${flech} ${cor[3]}OPENVPN       $openvpn \033[0;35m [\033[0;36m13\033[0;35m]\033[0;33m${flech} ${cor[3]}WEBMIN         $webminn"
echo -e "\033[0;35m [\033[0;36m4\033[0;35m]\033[0;33m${flech} ${cor[3]}SSL/TLS       $stunel \033[0;35m [\033[0;36m14\033[0;35m]\033[0;33m${flech} ${cor[3]}SlowDNS        $P1"
echo -e "\033[0;35m [\033[0;36m5\033[0;35m]\033[0;33m${flech} ${cor[3]}SHADOWSOCKS-R $shadow \033[0;35m [\033[0;36m15\033[0;35m]\033[0;33m${flech} ${cor[3]}SSL->PYTHON    ${socksA}" #\033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;36m6\033[0;35m]\033[0;33m${flech} ${cor[3]}SQUID         $squid \033[0;35m [\033[0;36m16\033[0;35m]\033[0;33m${flech} ${cor[3]}SSLH Multiplex $sslh"
echo -e "\033[0;35m [\033[0;36m7\033[0;35m]\033[0;33m${flech} ${cor[3]}PROXY PYTHON  $socks \033[0;35m [\033[0;36m17\033[0;35m]\033[0;33m${flech} ${cor[3]}OVER WEBSOCKET \033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;36m8\033[0;35m]\033[0;33m${flech} ${cor[3]}V2RAY SWITCH  $v2ray \033[0;35m [\033[0;36m18\033[0;35m]\033[0;33m${flech} ${cor[3]}SOCKS5         \033[0;33m(#BETA)"
echo -e "\033[0;35m [\033[0;36m9\033[0;35m]\033[0;33m${flech} ${cor[3]}CFA ( CLASH ) $xclash\033[0;35m  [\033[0;36m19\033[0;35m]\033[0;33m${flech} ${cor[3]}Protocolos UDP  $_pidUDP"
echo -e "\033[0;35m [\033[0;36m10\033[0;35m]\033[0;33m${flech} ${cor[3]}TROJAN-GO    $pTROJ \033[0;35m [\033[0;36m20\033[0;35m]\033[0;33m${flech} ${cor[5]}FUNCIONES EN DISEÑO!"
msg -bar3 
echo -e "${cor[5]} 🍄  INSTALACION DE HERRAMIENTAS Y SERVICIOS 🍄 "
msg -bar3
echo -e "\033[0;35m [\033[0;36m21\033[0;35m]\033[0;33m ${flech} ${cor[3]}BLOCK TORRENT        \033[0;35m [\033[0;36m22\033[0;35m]\033[0;33m ${flech} ${cor[3]}BadVPN   $_badvpn"
echo -e "\033[0;35m [\033[0;36m23\033[0;35m]\033[0;33m ${flech} ${cor[3]}TCP (BBR|Plus) $_tcpd \033[0;35m [\033[0;36m24\033[0;35m]\033[0;33m ${flech} ${cor[3]}FAILBAN  $fail_b"
echo -e "\033[0;35m [\033[0;36m25\033[0;35m]\033[0;33m ${flech} ${cor[3]}ARCHIVO ONLINE \033[0;31m[\033[0;32m${portFTP}\033[0;31m]  \033[0;35m [\033[0;36m26\033[0;35m]\033[0;33m ${flech} ${cor[3]}UP|DOWN SpeedTest " #\033[0;35m [\033[0;36m0\033[0;35m]\033[0;33m ⇦ $(msg -bra "\e[3;33m[ SALIR ]\e[0m")"
echo -e "\033[0;35m [\033[0;36m27\033[0;35m]\033[0;33m ${flech} ${cor[3]}DETALLES DEL VPS     \033[0;35m [\033[0;36m28\033[0;35m]\033[0;33m ${flech} ${cor[3]}Block ADS $_ADS" #\033[0;35m [\033[0;36m0\033[0;35m]\033[0;33m ⇦ $(msg -bra "\e[3;33m[ SALIR ]\e[0m")"
echo -e "\033[0;35m [\033[0;36m29\033[0;35m]\033[0;33m ${flech} ${cor[3]}DNS CUSTOM (NETFLIX) \033[0;35m [\033[0;36m30\033[0;35m]\033[0;33m ${flech} ${cor[3]}HERRAMIENTAS EXTRAS" #\033[0;35m [\033[0;36m0\033[0;35m]\033[0;33m ⇦ $(msg -bra "\e[3;33m[ SALIR ]\e[0m")"
echo -e "\033[0;35m [\033[0;36m31\033[0;35m]\033[0;33m ${flech} ${cor[3]}REINICIAR SERVICIOS  \033[0;35m [\033[0;36m32\033[0;35m]\033[0;33m ${flech} ${cor[3]}Brook Server $_ADS"
echo -e "\033[0;35m [\033[0;36m33\033[0;35m]\033[0;33m ${flech} ${cor[3]}FIREWALL (IPTABLES)  \033[0;35m [\033[0;36m34\033[0;35m]\033[0;31m ${flech} ${cor[3]}Enable/Change PASSWD ROOT"
echo -e "\033[0;35m [\033[0;36m35\033[0;35m]\033[0;33m ${flech} ${cor[3]}AToken [APP's Mods]  \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar3 
selection=$(selection_fun 36)
case ${selection} in
0)break;;
1)fun_openssh && read -p " Enter";;
2)fun_dropbear && read -p " Enter";;
3)fun_openvpn && read -p " Enter";;
4)ssl_stunel && read -p " Enter";;
5)fun_shadowsocks && read -p " Enter";;
6)fun_squid && read -p " Enter";;
7)iniciarsocks && read -p " Enter";;
8)v2ray-socket && read -p " Enter";;
9)instala_clash && read -p " Enter";;
10)trojan && read -p " Enter";;
11)psix && read -p " Enter";;
12)tcpd && read -p " Enter";;
13)web_min && read -p " Enter";;
14)slow-dns && read -p " Enter";;
15)source <(curl -sSL https://www.dropbox.com/s/vi96sjxiqwdibo5/autoconfig.sh) && read -p " Enter";;
16)source <(curl -sSL https://www.dropbox.com/s/m3qm4ekjbf2fg5m/sslh-back3.sh) && read -p " Enter";;
17)source <(curl -sSL https://www.dropbox.com/s/k3sozjz9bzmucag/ws-java.sh) && read -p " Enter";;
#18)source <(curl -sSL ${_link}bphl0io0xn7u37g/brook.sh) && read -p " Enter";;
18)source <(curl -sSL https://www.dropbox.com/s/etvd71wl749kv7f/socks5.sh) && read -p " Enter";;
#source <(curl -sSL https://www.dropbox.com/s/etvd71wl749kv7f/socks5.sh) 
19)_funUDP && read -p " Enter";;
20)source <(curl -sSL https://www.dropbox.com/s/ud4ux8kt4cgrljj/h_beta.sh) && read -p " Enter";;
#21)fun_chisel && read -p " Enter";;
21)btorrent && read -p " Enter";;
22)funBadVPN && read -p " Enter";;
23)funTCP && read -p " Enter";;
24)funFAILBAN && read -p " Enter";;
25)funARQONLINE && read -p " Enter";;
26)funSPEED && read -p " Enter";;
27)funDETSYS && read -p " Enter";;
28)BlockADS && read -p " Enter";;
29)wget -q -O /tmp/dnsNN.sh ${_link}l1hjn77fp0cywsl/dnsNN.sh; chmod +x /tmp/dnsNN.sh;bash /tmp/dnsNN.sh && read -p " Enter";;
30)_herramientas_extra;;
31)reiniciar_ser && read -p " Enter";;
32)source <(curl -sSL ${_link}bphl0io0xn7u37g/brook.sh) && read -p " Enter";;
33)
[[ -e /bin/firewall.bin ]] && firewall.bin || {
msg -ama " Descargando binario UFW...." 
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/firewall.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/aarch64/firewall.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/firewall.bin
  [[ -e /bin/firewall.bin ]] && rm -f /bin/firewall.bin
  ln -s /etc/ADMcgh/bin/firewall.bin /bin/firewall.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/firewall.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/firewall.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/firewall.bin
  [[ -e /bin/firewall.bin ]] && rm -f /bin/firewall.bin
  ln -s /etc/ADMcgh/bin/firewall.bin /bin/firewall.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }
  firewall.bin
}
pkill firewall.bin &>/dev/null
read -p " Enter";;
34)
rootpass
read -p " Enter";;
35)
[[ -e /bin/atoken_setup.bin ]] && atoken_setup.bin || {
msg -ama " Descargando binario AToken...." 
  [[ $(uname -m 2> /dev/null) != x86_64 ]] && {
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/atoken_setup.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/aarch64/atoken_setup.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/atoken_setup.bin
  [[ -e /bin/atoken_setup.bin ]] && rm -f /bin/atoken_setup.bin
  ln -s /etc/ADMcgh/bin/atoken_setup.bin /bin/atoken_setup.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3
  msg -ama "No se pudo descargar el binario"    
  msg -verm "Instalacion canselada"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  } || {   
  if wget --no-check-certificate -t3 -T3 -O /etc/ADMcgh/bin/atoken_setup.bin https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/BINARIOS/x86_64/atoken_setup.bin &>/dev/null ; then
  chmod +x /etc/ADMcgh/bin/atoken_setup.bin
  [[ -e /bin/atoken_setup.bin ]] && rm -f /bin/atoken_setup.bin
  ln -s /etc/ADMcgh/bin/atoken_setup.bin /bin/atoken_setup.bin
  msg -verd "[OK]"    
  else    
  msg -verm "[fail]"    
  msg -bar3    
  msg -ama "No se pudo descargar el binario"    
  read -p "ENTER PARA CONTINUAR"
  exit 0    
  fi
  }
  atoken_setup.bin
}
pkill atoken_setup.bin &>/dev/null
read -p " Enter";;
esac
done
#Reinicia ADM
return
}

#source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
[[ -z $(echo $SHELL|grep zsh) ]] && ENV_FILE=".bashrc" || ENV_FILE=".zshrc"
_link='https://www.dropbox.com/s/'
start_menu () {
while :
do
#------------------------------------------------

local mem_total=$(free --mega -h | awk 'NR==2{printf $2}')
local mem_used=$(free --mega -h | awk 'NR==2{printf $3}')
local mem_free=$(free --mega -h | awk 'NR==2{printf $4}')
local mem_cache=$(free --mega -h | awk 'NR==2{printf $6}')
local mem_available=$(free --mega -h | awk 'NR==2{printf $7}') 
local mem_used_percent=$(free --mega | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')    
local swap=$(swapon -s)
local swap_total=$(free --mega -h | awk 'NR==3{printf $2}')
local swap_used=$(free  --mega -h | awk 'NR==3{printf $3}')
local swap_free=$(free  --mega -h | awk 'NR==3{printf $4}')
local hotCOLOR="$(top -b -n1 | grep 'Cpu(s)' | awk '{print $2 + $4}'|sed -u 's/,/./g' | bc -l)"
#local _os="\033[1;31m$(cat /etc/issue | cut -d " " -f 1,2 | head -1| tr a-z A-Z)"
local _os="$(cat /etc/issue | cut -d " " -f 1,2 | head -1| tr a-z A-Z)"
local tmp_distro=($(lsb_release -d |cut -f2 | tr a-z A-Z))
local distro="${tmp_distro[0]} ${tmp_distro[1]}"
local cpu_core=$(cat /proc/cpuinfo | grep processor | wc -l)
local cpu_model=$(uname -m)
[[ "${cpu_model}" = "aarch64" ]] && cpu_model=" ARM64 Pro" 
#[[ ${hotCOLOR} > '80' ]] && cpu_used="\033[1;31m ${hotCOLOR}%" || cpu_used="${cor[2]} ${hotCOLOR}%"
[[ ${hotCOLOR} > 70 ]] && cpu_used="\033[1;31m ${hotCOLOR}%" || cpu_used="${cor[2]} ${hotCOLOR}%"
#SE CAMBIAN VARIABLES A ANTES DE LLENAR CACHE Y CPU ( MAQUILLAJE COMO OTROS MODS )
header
#[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[7;49;35m    ${TTini} ChumoGH${TTcent}VPS  ${TTfin}      "
msg -bar3
[[ -e /etc/adm-lite/modulos ]] && echo -e "${cor[1]} ${pPIniT} ${cor[5]}ONLINES: ${cor[2]}${_onlin}${cor[2]} ${pPIniT} \033[1;37mEXP: ${_userexp} ${cor[2]}${pPIniT}\033[1;37m KILL: $ukk ${cor[2]}${pPIniT}\033[1;37m TOTAL: ${_tuser}"
echo -e "${cor[1]} ${pPIniT} ${cor[5]}S.O: \033[1;37m${_os} ${cor[1]} ${pPIniT} ${cor[5]}Base:\033[1;37m${cpu_model}${cor[1]} ${pPIniT} ${cor[5]}CPU's:\033[1;37m${cpu_core} "
echo -e "${cor[1]} ${pPIniT} ${cor[5]}IP: \033[0;37m${IP} ${cor[1]} ${pPIniT} ${cor[5]}FECHA: \033[1;37m$(date +"%d/%m/%Y")-$(date +"%H:%M")" 

msg -bar3
echo -e "${vesaoSCT} "
msg -bar3
ports_
##
[[ $(cat /etc/crontab | grep 'bash /bin/') ]] && _opti="\033[0;31m [\033[0;32mON\033[0;31m]" || _opti="\033[0;31m [OFF]"
[[ -e /etc/bash.bashrc-bakup ]] && _autorun="\033[0;31m [\033[0;32mON\033[0;31m] " || _autorun="\033[0;31m [OFF]"
[[ -e /etc/systemd/system/killadm.service ]] && lmt="\033[0;31m [\033[0;32mON\033[0;31m] " || lmt="\033[0;31m [OFF]"
msg -bar3
echo -e "${cor[1]} ∘${cor[5]} TOTAL: ${cor[2]}${mem_total}${cor[1]} ∘ ${cor[5]} M|LIBRE:${cor[2]} ${mem_free} ${cor[1]} ∘ ${cor[5]} EN USO:${cor[2]} ${mem_used}"
echo -e "${cor[1]} ∘${cor[5]} U/RAM: ${cor[2]}${mem_used_percent} ${cor[1]} ∘${cor[5]} U/CPU:${cpu_used} ${cor[1]} ∘${cor[5]} BUFFER:${cor[2]} ${mem_cache}" # $CPU"%"
msg -bar3
echo -e "\033[0;35m [${cor[2]}01\033[0;35m]\033[0;33m ${flech}${cor[3]} CONTROL USUARIOS (SSH/SSL/VMESS) "
#echo -e "\033[0;35m [${cor[2]}02\033[0;35m]\033[0;33m ${flech}${cor[3]} HERRAMIENTAS BASE (\033[0;34mBadVPN$_badvpn${cor[3]})"
echo -e "\033[0;35m [${cor[2]}02\033[0;35m]\033[0;33m ${flech}\033[0;33m [!]${cor[3]} OPTIMIZAR VPS $_opti "
echo -e "\033[0;35m [${cor[2]}03\033[0;35m]\033[0;33m ${flech}${cor[3]} CONTADOR ONLINE USERS $VERIFICAR_PID"
#echo -e "\033[0;35m [${cor[2]}04\033[0;35m]\033[0;33m ${flech} \e[3;32mHERRAMIENTAS BETA\e[0m \033[0;33m (#EXPERIMENTAL)"
echo -e "\033[0;35m [${cor[2]}04\033[0;35m]\033[0;33m ${flech}${cor[3]} AUTOINICIAR SCRIPT $_autorun"
echo -e "\033[0;35m [${cor[2]}05\033[0;35m]\033[0;33m ${flech}${cor[3]} INSTALADOR DE PROTOCOLOS"
msg -bar3
echo -ne "\033[0;35m [${cor[2]}06\033[0;35m]\033[0;33m ${flech}\033[0;33m [!] ${cor[2]}UPDATE / \033[0;31mREMOVE${cor[3]}  |" && echo -e " \033[0;35m [${cor[2]}0\033[0;35m]\033[0;33m ⇦ $(msg -bra "\e[3;33m[ SALIR ]\e[0m")"
msg -bar3 

#------------------------------------------------
local selection=$(selection_fun 7)
case ${selection} in
0)
#echo -e "${cor[0]} SALIENDO " | pv -qL 50
clear&&clear
break&&break&&exit
;;
01|1)
clear #tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2 && tput cuu1 >&2 && tput dl1 >&2
Call.UserS
;;
02|2)
echo -e "OPTIMIZANDO SERVIDOR"  | pv -qL 25
fun_limpram() {
	[[ -e /var/log/syslog ]] && rm -f /var/log/syslog*
	echo > /var/log/syslog
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
	v2ray clean 1>/dev/null 2>/dev/null &
	rm -rf /tmp/* > /dev/null 2>&1
	killall kswapd0 > /dev/null 2>&1
	killall tcpdump > /dev/null 2>&1
	killall ksoftirqd > /dev/null 2>&1
	pkill SlowDNS*
	sleep .5
}	
	
function aguarde() {
	sleep 1
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37mOPTIMIZANDO MEMORIA ${cor[2]}RAM \033[1;37my ${cor[2]} RECURSOS${cor[2]}.${cor[5]}.\033[1;31m. ${cor[5]}"
	helice
	echo -e "\e[1DOk"
	
}
aguarde
unset opcion
while :
    do
echo -e "DESEASA ACTIVAR LAS AUTOPTIMIZACIONES??"
read -p " [ SI / NO ] :" opcion
case $opcion in
0)break;;
[Yy]|[Ss])
#=========================================================
echo -ne " VERIFICANDO SISTEMA......"
if wget https://www.dropbox.com/s/t4mfqdepbqg3a4i/tumbs.sh &>/dev/null -O /usr/bin/autotumbs &>/dev/null ; then
echo -e "${cor[2]} \033[1;32m EXITO \n" && msg -bar3 
chmod +x /usr/bin/autotumbs &>/dev/null
bash /usr/bin/autotumbs '--start'
rm -rf /usr/bin/autotumbs
else
echo -e "${cor[2]} \033[1;31m FAIL \n" && msg -bar3 
sleep 2s
return
fi
msg -bar3 
echo -e " INGRESA TU NOMBRE DE BACKUP / 0 PARA CANCELAR"
read -p " NOMBRE : " bkp
[[ ${bkp} = 0 ]] && return 
echo $bkp > /bin/ejecutar/autt
[[ -e /bin/ejecutar/autt ]] && name=$(cat < /bin/ejecutar/autt)
echo " Nombre $name Cargado Exitosamente"
echo -e "        Nombre $name Cargado Exitosamente "
echo -e "Ahora accede a http://${IP}:${_SFTP}/$name "
echo -e "    AQUI ENCONTRARAS TU FICHERO ONLINE"
read -p "Enter para Continuar"
#=========================================================
pkill bash &>/dev/null
break ;;
[Nn])
pkill bash &>/dev/null
killall bash &>/dev/null
break;;
*)
pkill bash &>/dev/null
killall bash &>/dev/null
break;;
esac
done
;;
03|3)
Call.ControlTIMER # > /dev/null 2>&1
;;
04|4)
if [[ -e /etc/bash.bashrc-bakup ]]; then
mv -f /etc/bash.bashrc-bakup /etc/bash.bashrc
cat /etc/bash.bashrc | grep -v "/bin/adm" > /tmp/bash
mv -f /tmp/bash /etc/bash.bashrc
msg -bar3
echo -e "${cor[2]} ${cor[2]} AUTOEJECUCION APAGADA"  | pv -qL 30
msg -bar3
elif [[ -e /etc/bash.bashrc ]]; then
cat /etc/bash.bashrc|grep -v /bin/cgh > /etc/bash.bashrc.2
echo '/bin/adm' >> /etc/bash.bashrc.2
cp /etc/bash.bashrc /etc/bash.bashrc-bakup
mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
echo 'cgh' > /bin/adm
chmod +x /bin/adm
msg -bar3
echo -e "${cor[2]} ${cor[2]}AUTOEJECUCION ENCENDIDO"  | pv -qL 30
msg -bar3
fi
;;
05|5)
#export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
#value=$(vary_rex "62617368202D63202224286375726C202D6673534C20247B5F6C696E6B7D7434796E386F367338383235786B752f4D496E73742922")
Call.CONTROLADOR
#"736F75726365" 
#echo -e "${value} alx"
#[[ -e /etc/$1/MInst ]] && source /etc/$1/MInst "alx" "${_link}"  || source <(curl -sSL ${_link}sxg6f7isbg92vfu/MInst) "alx" "${_link}"
;;
06|6)
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games
#msg -bar3
#[[ -e /root/name ]] && figlet -p -f smslant < /root/name | lolcat || echo -e "\033[7;49;35m   =====>>►► 🐲 ChumoGH 💥 Plus 🐲 ◄◄<<=====     \033[0m"
clear && header
menu_item "\033[0;33m[!] ${cor[2]}ACTUALIZAR SCRIPT \033[0;33m($v2) ► ${cor[2]}[$v1] " "\033[0;33m[!] \033[0;31mDESINSTALAR SCRIPT "
	selection=$(selection_fun 2)
	case ${selection} in
		1)
			fun_atualizar
		;;
		2)
			remover_adm
		;;
		esac
;;
esac
done

}
unset lang
[[ -e /etc/cgh/modulo/limiter ]] && lmt="${cor[2]}[ON] " || lmt="\033[1;31m[OFF]"

fun_teste(){
sudo bash -c "$(curl -fsSL ${_link}z5x4zh43ztx4buy/funciones.sh)"
}

cor[0]="\033[0m"
cor[1]="${cor[1]}"
cor[2]="${cor[2]}"
cor[3]="\033[1;37m"
cor[4]="\033[1;36m"
cor[5]="${cor[5]}"
cor[6]="\033[1;35m"

function removerv2ray(){
BASE_SOURCE_PATH="https://multi.netlify.app"
UTIL_PATH="/etc/v2ray_util/util.cfg"
UTIL_CFG="$BASE_SOURCE_PATH/v2ray_util/util_core/util.cfg"
BASH_COMPLETION_SHELL="$BASE_SOURCE_PATH/v2ray"
CLEAN_IPTABLES_SHELL="$BASE_SOURCE_PATH/v2ray_util/global_setting/clean_iptables.sh"
source <(curl -sL https://multi.netlify.com/v2ray.sh) --remove
source <(curl -sL https://git.io/fNgqx) --remove
source <(curl -sL https://git.io/JeSZL) --remove
    #卸载V2ray脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove >/dev/null 2>&1
    rm -rf /etc/v2ray >/dev/null 2>&1
    rm -rf /var/log/v2ray >/dev/null 2>&1
    #卸载Xray脚本
    bash <(curl -L -s https://multi.netlify.app/go.sh) --remove -x >/dev/null 2>&1
    rm -rf /etc/xray >/dev/null 2>&1
    rm -rf /var/log/xray >/dev/null 2>&1
    #清理v2ray相关iptable规则
    bash <(curl -L -s $CLEAN_IPTABLES_SHELL)
    #卸载multi-v2ray
    pip uninstall v2ray_util -y
    rm -rf /usr/share/bash-completion/completions/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/v2ray >/dev/null 2>&1
    rm -rf /usr/share/bash-completion/completions/xray >/dev/null 2>&1
    rm -rf /etc/bash_completion.d/v2ray.bash >/dev/null 2>&1
    rm -rf /usr/local/bin/v2ray >/dev/null 2>&1
    rm -rf /etc/v2ray_util >/dev/null 2>&1
    #删除v2ray定时更新任务
    crontab -l|sed '/SHELL=/d;/v2ray/d'|sed '/SHELL=/d;/xray/d' > crontab.txt
    crontab crontab.txt >/dev/null 2>&1
    rm -f crontab.txt >/dev/null 2>&1
    systemctl restart cron >/dev/null 2>&1
    #删除multi-v2ray环境变量
    sed -i '/v2ray/d' ~/$ENV_FILE
    sed -i '/xray/d' ~/$ENV_FILE
    source ~/$ENV_FILE
exit
}
sfix () {
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/sourcesfix.sh)
}

trofix(){
source <(curl -sSL ${_link}0g49zme77giypns/mod-v2ray.sh)
}

autoop(){
clear&&clear
msg -bar3
echo -e "${cor[2]} ${cor[2]}ESTA FUNCION AGREGARA EN EL CRONTAB UN AUTOEJECUCION"
echo -e "${cor[2]} ${cor[2]}. Este Metodo Optimizara y limpiara Tu SERVIDOR"
echo -e "${cor[2]} ${cor[2]}De manera automatica para evitar Lags y lentitud cada 5/"
echo -e "${cor[2]} ${cor[2]}SI ESTAS DE ACUERDO, PRESIONA 1, CASO CONTRARIO 0"
menu_item "ACTIVAR AUTOLIMPIEZA ( AUTO OPTIMIZACIONES )" "DESACTIVAR MOD DE LIMPIEZAS ( APAGA OPCION 1 )"
selection=$(selection_fun 2)
case ${selection} in
	0)
	clear
	echo -e "${cor[0]}"
	clear
	exit
	;;
	1)
	clear
echo " Desabilitando Servicios de AutOptimizacion" && sed -i "/ejecutar/d" /etc/crontab
echo -ne " VERIFICANDO SISTEMA......"
if wget https://www.dropbox.com/s/t4mfqdepbqg3a4i/tumbs.sh &>/dev/null -O /usr/bin/autotumbs &>/dev/null ; then
echo -e "${cor[2]} \033[1;32m EXITO \n" && msg -bar3 
chmod +x /usr/bin/autotumbs &>/dev/null
bash /usr/bin/autotumbs '--start'
rm -rf /usr/bin/autotumbs
else
echo -e "${cor[2]} \033[1;31m FAIL \n" && msg -bar3 
sleep 2s
return
fi
msg -bar3 
echo -e " INGRESA TU NOMBRE DE BACKUP / 0 PARA CANCELAR"
read -p " NOMBRE : " bkp
[[ ${bkp} = 0 ]] && return 
echo $bkp > /bin/ejecutar/autt
[[ -e /bin/ejecutar/autt ]] && name=$(cat < /bin/ejecutar/autt)
echo " Nombre $name Cargado Exitosamente"
echo -e "        Nombre $name Cargado Exitosamente "
echo -e "Ahora accede a http://${IP}:${_SFTP}/$name "
echo -e "    AQUI ENCONTRARAS TU FICHERO ONLINE"
read -p "Enter para Continuar"
;;
2)
echo -e "Desabilitando Servicios de AutOptimizacion"
echo -ne " VERIFICANDO SISTEMA......"
if wget https://www.dropbox.com/s/t4mfqdepbqg3a4i/tumbs.sh &>/dev/null -O /usr/bin/autotumbs &>/dev/null ; then
echo -e "${cor[2]} \033[1;32m EXITO \n" && msg -bar3 
chmod +x /usr/bin/autotumbs &>/dev/null 
bash /usr/bin/autotumbs '--stop'
#rm -rf /usr/bin/autotumbs
else
echo -e "${cor[2]} \033[1;31m FAIL \n" && msg -bar3 
sleep 2s
return
fi
[[ -e /bin/ejecutar/autt ]] && name=$(cat < /bin/ejecutar/autt)
[[ -z $name ]] && return
[[ -e /bin/ejecutar/autt ]] && rm -f /bin/ejecutar/autt 
[[ -e /var/www/html/$name ]] && rm -f /var/www/html/$name
;;
esac
rm -f /usr/bin/autotumbs
}

bbr () {
source <(curl -sSL ${_link}ul09ao6jshlfvte/tcp.sh)
}

function tls13(){
apt-get install -y git autoconf libtool
git clone https://github.com/wolfssl/wolfssl.git
cd wolfssl/
./autogen.sh
./configure --enable-sha512
make
make install
ldconfig
./configure --enable-stunnel --enable-tls13
make
make install
ldconfig
service stunnel4 restart
cd /root
}

clash-man () {
source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/CLASH/ClashForAndroidGLOBAL.sh)
}

fixssh () {
local portserv
echo -e ""
echo -e " ESTO RECONFIGURA TU OPENSSH A CUSTOM "
echo -e ""
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
echo -e " Digita N/n PARA RETORNAR"
read -p "   [S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
sshfix="/etc/ssh/sshd_config"
msg -bar3 && echo -e " INGRESA TU PUERTO OpenSSH "
read -p " Defauld ( 22 ) : " -e -i '22' portserv
sed -i "/Port /d" ${sshfix}
sed -i "1i Port ${portserv}" $sshfix
msg -bar3 
echo " OpenSSH ALTERADO A -> ${portserv}"
echo -ne " \033[1;31m[ ! ] DETENIENDO DROPBEAR -> 22" | pv -qL 40
service dropbear stop > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear stop > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar3 
echo -ne " \033[1;31m[ ! ] REINICIANDO OpenSSH" | pv -qL 40
sudo apt-get install --reinstall openssh-server &/dev/null 
service sshd restart > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
[[ -e /etc/init.d/ssh ]] && /etc/init.d/ssh restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar3 
echo -ne " \033[1;31m[ ! ] RESTAURANDO PUERTOS DROPBEAR" | pv -qL 40
service dropbear restart > /dev/null 2>&1
[[ -e /etc/init.d/dropbear ]] && /etc/init.d/dropbear restart > /dev/null 2>&1 && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
msg -bar3 
echo -e "REINICIANDO VPS"
sleep 0.5s
echo -e " Mejor Reiniciamos los Servicios!!! 
			Si eso dio error
   Dijita manualmente en consola \033[0;32m(  sudo reboot  ) "
exit 0
fi
}

xswap () {
source <(curl -sSL ${_link}26jjoywy0rgc29y/swapfile.sh) #https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/swap.sh)
}

mpro () {
msg -bar3 
echo -e " MOSTRANDO 25 PROCESOS ACTIVOS EN VPS"
msg -bar3
#ps aux --width 30 --sort -rss | head
ps -Ao user,uid,comm,pid,pcpu,pmem --sort=-pcpu | head -n 25
read -p "Ingresa nombre de proceso a Destruir, ( no Dropbear, no SSH ) : " df
[ -z "$df" ] && df="kswapd0"
pidkill='ps x | grep -v grep | grep $df'
killall $df > /dev/null 2>&1 
#pidkill='ps x | grep -v grep | grep $df'
ps aux | grep -v grep | grep $df
echo "Proceso Liberado Exitosamente"
killall kswapd0 > /dev/null 2>&1
killall tcpdump > /dev/null 2>&1
killall ksoftirqd > /dev/null 2>&1
killall menu_inst > /dev/null 2>&1
killall menu > /dev/null 2>&1 
}

function goinst(){
echo -e "A continuacion se instalara el paquete GO Lang"
msg -bar3
echo -e "     \033[41m-- SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr) --"
msg -bar3
fun_bar "apt install golang -y" 
fun_bar "apt install golang-go -y" 
cd $HOME
echo "DESACIENDO DIRECTORIOS EXISTENTES" && rm -rf /usr/local/go 1>/dev/null 2>/dev/null &
echo "Buscando pauqte mas Actual" && sudo curl -O https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz  # Descargar el archivo. Cambie el nombre del archivo si necesita otra versión de Go o otra arquitectura# https://golang.org/dl/go1.17.3.linux-amd64.tar.gz
echo -ne "Descomprimiendo Ultimo paquete Descargado"
sudo tar -xvf go1.9.linux-amd64.tar.gz > /dev/null && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
sudo mv go /usr/local  # Desplazar los binarios hacia /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile  # Se actualiza su perfil bash para que Go este en el PATH
sleep 0.5s
echo -e "Reiniciando Fuente de Terminal..."
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
rm -f go1.9.linux-amd64.tar.*
source ~/.profile
}

ssrmenu() {
source <(curl -sSL ${_link}c2efu7ul4cvg0j7/trojan-nao.sh)
}

btorrent () {
source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/Extras/blockT.sh)
}

chora () {
source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/Extras/zh.sh)
}

crea_pay () {
echo -e "A continuacion se instalara los Paquetes Necesarios"
echo -e "Sea Paciente mientas completamos el Proceso "
echo -e "Deseas Continuar?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "Instalando..."
cd
fun_bar "" 
apt update -y && apt upgrade -y 1>/dev/null 2>/dev/null &
pkg install git  -y 1>/dev/null 2>/dev/null &
apt install git  -y 1>/dev/null 2>/dev/null &
cd /bin/ejecutar/
[[ -e /bin/ejecutar/Irparpaya-a/real-host-v2.sh ]] && rm -rf /bin/ejecutar/Irparpaya-a
git clone https://github.com/HackeRStrategy/Irparpaya-a && fun_bar && echo "Clonando del SITIO OFICIAL DEVELOPER" || echo "Fallo al Clonar"
cd Irparpaya-a && echo "Procedimiento Completado Exitosamente"
sleep 1s
bash real-host-v2.sh
fi

}

function removerbadvpn(){
badvpn stop
killall badvpn-udpgw
rm -f /bin/badvpn > /dev/null
rm -f /usr/bin/badvpn-udpgw > /dev/null
rm -f /bin/badvpn-udpgw > /dev/null
rm -rf /bin/badvpn > /dev/null
rm -rf /usr/bin/badvpn-udpgw > /dev/null
rm -rf /bin/badvpn-udpgw > /dev/null
sed -i '/badvpn/d' /bin/autoboot
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removetrojan(){
killall trojan > /dev/null
[[ -d /usr/local/etc/trojan ]] && rm -rf /usr/local/etc/trojan > /dev/null
[[ -d /etc/etc/adm-lite/trojancert ]] && rm -rf /etc/etc/adm-lite/trojancert > /dev/null
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerfail2ban(){
apt-get purge fail2ban -y
apt-get remove fail2ban -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerstunnel(){
service stunnel4 stop 1>/dev/null 2>/dev/null &
killall stunnel4 1>/dev/null 2>/dev/null &
apt-get -y purge stunnel4 1>/dev/null 2>/dev/null &
apt-get -y remove stunnel4 1>/dev/null 2>/dev/null &
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerwebmin(){
apt-get purge webmin -y
apt-get remove webmin -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerpython(){
killall python
pkill python
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removershadowsocks(){
wget --no-check-certificate -O libev.sh https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/shadowsocks.sh > /dev/null 2>&1
chmod +x libev.sh 
./libev.sh uninstall 
rm -rf libev.sh 
cd /root
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerdropbear(){
service dropbear stop
apt-get purge dropbear -y
apt-get remove dropbear -y
service dropbear stop
/etc/init.d/dropbear stop
killall dropbear
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removeropenvpn(){
apt-get purge openvpn -y
apt-get remove openvpn -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerlibs32(){
apt-get purge ia32-libs -y
apt-get remove ia32-libs -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removernginx(){
apt-get purge nginx -y
apt-get remove nginx -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removersquid(){
apt-get purge squid -y
apt-get remove squid -y
apt-get purge squid3 -y
apt-get remove squid3 -y
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removerv2ui(){
systemctl stop v2-ui
systemctl disable v2-ui
rm /etc/systemd/system/v2-ui.service -f
systemctl daemon-reload
systemctl reset-failed
rm /etc/v2-ui/ -rf
rm /usr/local/v2-ui/ -rf
killall v2-ui  &> /dev/null 2>&1
[[ -e /usr/bin/v2-ui ]] && rm -f /usr/bin/v2-ui
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function removertro(){
killall trojan &> /dev/null 2>&1
[[ -e /usr/local/etc/trojan/config.json ]] && rm -f /usr/local/etc/trojan 
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
}
function mtraff(){
[[ -e /root/name ]] && {
[[ -z $(less /root/name) ]] || figlet -p -f smslant < /root/name | lolcat 
}|| echo -e "\033[1;44;44m   ${cor[5]}=====>>►► 🐲 ChumoGH 💥 Plus 🐲 ◄◄<<=====     \033[0m"
echo -e "\033[1;37m  【  ★ Reseller : $(cat < /bin/ejecutar/menu_credito) 2024 ★  】\033[0m"
msg -bar3
vnstat
echo -e "${cor[2]}  ⇜ Comsumo de INTERNET TOTAL EN VPS ⇝ ⇅"
msg -bar3
echo -e "\033[1;36m  ↯↯↯ TRAFICO TOTAL DE BAJADA ↯↯↯ "
echo -e "\033[1;37m Ethernet ↡ ${cor[2]} --> ${cor[1]} " $(ifconfig | grep 'TX packets'| sed 's/\s\+/,/g' | cut -d , -f7-8) "${cor[2]} <--\033[1;37m Ethernet ⇧ "
msg -bar3
echo -e "\033[1;36m  ⇈ TRAFICO TOTAL DE SUBIDA ⇈ "
echo -e "\033[1;37m ↡ Local Loopback ${cor[2]} --> ${cor[1]} " $(ifconfig | grep 'RX packets'| sed 's/\s\+/,/g' | cut -d , -f7-8) "${cor[2]} <--\033[1;37m ⇧ Local Loopback "
msg -bar3
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR \033[0m"
read -p " "
}
function configssh(){
msg -bar3
echo -e "\033[1;37m › Configuracion SSH\033[0m"
cat /etc/ssh/sshd_config
msg -bar3
}
function configdropbear(){
msg -bar3
echo -e "\033[1;37m › Configuracion Dropbear\033[0m"
echo -e "\033[1;37m › /etc/default/dropbear\033[0m"
cat /etc/default/dropbear
msg -bar3
}
function configstunnel(){
msg -bar3
echo -e "\033[1;37m › Configuracion Stunnel\033[0m"
echo -e "\033[1;37m › /etc/stunnel/stunnel.conf\033[0m"
cat /etc/stunnel/stunnel.conf
msg -bar3
}
function configsquid(){
msg -bar3
echo -e "\033[1;37m › Configuracion Squid\033[0m"
cat /etc/squid/squid.conf
msg -bar3
}
function configproxy(){
msg -bar3
echo -e "\033[1;37m › Configuracion Proxy Python\033[0m"
echo -e "\033[1;37m › /root/proxy.py\033[0m"
cat /root/proxy.py
msg -bar3
}
function configsocks5(){
msg -bar3
echo -e "\033[1;37m › Configuracion Socks5\033[0m"
echo -e "\033[1;37m › /etc/danted.conf\033[0m"
cat /etc/danted.conf
msg -bar3
}
function configsockd(){
msg -bar3
echo -e "\033[1;37m › Configuracion Sockd\033[0m"
echo -e "\033[1;37m › /home/dante/danted.conf\033[0m"
cat /home/dante/danted.conf
msg -bar3
}
function configopenvpn(){
msg -bar3
echo -e "\033[1;37m › Configuracion Openvpn\033[0m"
echo -e "\033[1;37m › /etc/openvpn/server.conf\033[0m"
cat /etc/openvpn/server.conf
msg -bar3
}
function configv2ui(){
msg -bar3
echo -e "\033[1;37m › Configuracion V2-UI\033[0m"
echo -e "\033[1;37m › /usr/local/v2-ui/bin/config.json\033[0m"
cat /usr/local/v2-ui/bin/config.json
msg -bar3
}
function configshadow(){
if [[ $1 == "" ]]
then
msg -bar3
echo -e "\033[1;37m › Configuracion Shadowsocks\033[0m"
echo -e "\033[1;37mSeleccione una opcion:    Para Salir Ctrl + C${cor[5]}
[\033[1;30m1${cor[5]}] LIBEV                 ›   ${cor[5]}
[\033[1;30m2${cor[5]}] ROCKET                ›   ${cor[5]}
[\033[1;30m0${cor[5]}] < REGRESAR                 ${cor[5]}"
read -p ": " opcao
else
opcao=$1
fi
case $opcao in
1)
configlibev;;
2)
configrocket;;
0)
killall menu > /dev/null 2>&1 ;;
esac
}
function configlibev(){
msg -bar3
echo -e "\033[1;37m › Configuracion Shadowsocks Libev\033[0m"
echo -e "\033[1;37m › /etc/shadowsocks-libev/config.json\033[0m"
cat /etc/shadowsocks-libev/config.json
msg -bar3
}
function configrocket(){
msg -bar3
echo -e "\033[1;37m › Configuracion Shadowsocks Rocket\033[0m"
echo -e "\033[1;37m › /etc/shadowsocks-r/config.json\033[0m"
cat /etc/shadowsocks-r/config.json
msg -bar3
}
##
update_pak () {
echo -ne " \033[1;31m[ ! ] apt-get update"
apt-get update -y > /dev/null 2>&1 && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne " \033[1;31m[ ! ] apt-get upgrade"
apt-get upgrade -y > /dev/null 2>&1 && echo -e "${cor[2]} [OK]" || echo -e "\033[1;31m [FAIL]"
return
}

reiniciar_ser () {
echo 3 > /proc/sys/vm/drop_caches 1>/dev/null 2>/dev/null &
sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null &
swapoff -a && swapon -a 1>/dev/null 2>/dev/null &
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
_sleepColor 2 
source <(curl -sSL https://www.dropbox.com/s/x6fp9f14ob1i5ez/gnula.sh) --menu
return 0
}

reiniciar_vps () {
sleep 0.5s
echo -e "${cor[2]} [OK]"
(
sudo reboot
) > /dev/null 2>&1
return
}

host_name () {
unset name
while [[ ${name} = "" ]]; do
echo -ne "\033[1;37m Nuevo nombre del host : " && read name
tput cuu1 && tput dl1
done
hostnamectl set-hostname $name 
echo $name > name
if [ $(hostnamectl status | head -1  | awk '{print $3}') = "${name}" ]; then 
echo -e "${cor[5]} Host alterado corretamente !, reiniciar VPS"
else
echo -e "${cor[5]} Host no modificado!"
fi
return
}

_sleepColor(){
local time=$1
local accion=$2
start_animation
[[ -z ${accion} ]] && {
[[ -z ${time} ]] && sleep 2s || sleep ${time}
} || ${accion} &>/dev/null
stop_animation
echo
tput cuu1 >&2 && tput dl1 >&2
}

cambiopass () {
msg -bar3
echo -e ""
echo -e "${cor[3]} Esta herramienta cambia la contraseña de su servidor vps"
echo -e "${cor[3]} Esta contraseña es utilizada como usuario root"
echo -ne "${cor[2]} Desea Seguir? [S/N]: "; read x
[[ $x = @(n|N) ]] && fun_bar && return
#Inicia Procedimentos
echo -e "${cor[0]} Escriba su nueva contraseña"
read  -p " Nuevo passwd: " pass
(echo $pass; echo $pass)|passwd 2>/dev/null
sleep 1s
_sleepColor '2' ""
echo -e "${cor[3]} Contraseña cambiada con exito!"
echo -e "${cor[2]} Su contraseña ahora es : ${cor[4]}$pass"
return
}

rootpass () {
source <(curl -sSL  ${_link}hl9vyo8mf94z0h5/root-pass.sh)
}

apa_nginx() {

apt purge apache2 -y 
# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -q -O /etc/nginx/nginx.conf "${_link}0maqn1hpfzxsm43/nginx.conf"
[[ ! -d /var/www/html ]] && mkdir -p /var/www/html
[[ ! -e /var/www/html/index.html ]] && echo "<pre>Setup by @ChumoGH</pre>" > /var/www/html/index.html
wget --no-cache -O /etc/nginx/conf.d/vps.conf "${_link}msm14fz2pwnluvg/vps.conf"
/etc/init.d/nginx restart

}

translate() {
[[ ! -e /etc/ADMcgh/bin/idioma ]] && idioma_destino='es' || idioma_destino=$(cat /etc/ADMcgh/bin/idioma)
  if [ -z "$1" ]; then
    return 1
  fi

  idioma_origen="es" 
  palabra_traducida=$(trans -s "$idioma_origen" -t "$idioma_destino" -show-original n "$1")
  palabra_traducida=$(trans -s "$idioma_origen" -t "$idioma_destino" -show-original n "$1" |  tail -1)

  echo "${palabra_traducida}"
}



verifi_fun () {
echo -e "ESPERE PORFAVOR "
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || apt-get install at -y &>/dev/null
clear&&clear
[[ -e /root/name ]] && {
[[ -z $(less /root/name) ]] || figlet -p -f smslant < /root/name | lolcat 
} || tittle
msg -bar3 
echo -e ""
echo -e "${cor[3]}       Esta herramienta es Experimental en el vps"
echo -e "${cor[3]} Esta Accion Limita el Sobrepaso de USUARIOS del Limiter"
msg -bar3 
echo -ne  "Desea Seguir? [S/N]: "; read x
[[ $x = @(n|N) ]] && msg -bar3 && return
echo -e ""
echo -ne " VERIFICANDO SISTEMA......"
rm -f /bin/killssh
if wget https://www.dropbox.com/scl/fi/cx7t2bt22fm0gx6uxq5da/killSSH.sh?rlkey=4h8pbxug705gv7pvv2e40jjnf &>/dev/null -O /etc/ADMcgh/bin/killssh &>/dev/null ; then
echo -e "${cor[2]} \033[1;32m DONE \n" && msg -bar3 
chmod +x /etc/ADMcgh/bin/killssh
[[ ! -e /bin/killssh ]] && ln -s /etc/ADMcgh/bin/killssh /bin/killssh
msg -bar3
[[ -e /etc/systemd/system/killadm.service ]] && {
killall kill_drop.sh &>/dev/null
systemctl stop killadm &>/dev/null
systemctl disable killadm &>/dev/null
systemctl daemon-reload &>/dev/null
rm -f /etc/systemd/system/killadm.service &>/dev/null
[[ -d /etc/ADMcgh/limit ]] && rm -rf /etc/ADMcgh/limit
rm -rf /bin/killssh &>/dev/null
echo -e "     ${aLerT}ALERTA DE NOTIFICACION ${aLerT}"
echo -ne " LIMITADOR KILL MULTILOGIN DESACTIVADO"
msg -bar3
} || {
[[ ! -d /etc/ADMcgh/limit ]] && mkdir /etc/ADMcgh/limit
print_center -verm2 'LIMITADOR SSH /DROPBEAR!!!\n DEFINA EL TIEMPO PARA EL LIMITADOR \n '
msg -bar3
echo -ne " LIMITAR EN SEGUNDOS : "; read _timeK
[[ -z ${_timeK} ]] && _timeK='60'
msg -bar3
echo "${_timeK}" > /etc/ADMcgh/limit/interval
print_center -verm2 'DESBLOQUEO AUTOMATIO!!!\n DEFINA EL TIEMPO DE DESBLOQUEO AUTOMATICO \n PARA USUARIOS LIMITADOS Y BLOQUEADOS \n (PRESIONA ENTER PARA DESBLOQUEO MANUAL)'
msg -bar3
echo -ne " UNLOCK EN SEGUNDOS : "; read _timeuUL
[[ -z ${_timeuUL} ]] && _timeuUL='0'
echo "${_timeuUL}" > /etc/ADMcgh/limit/unlock
msg -bar3
/bin/killssh && echo -e " EJECUCION EXTOSA"
msg -bar3
echo -e "[Unit]
Description=KillLogin Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$(which bash) /bin/killssh
Restart=always
RestartSec=${_timeK}s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/killadm.service
systemctl daemon-reload &>/dev/null
systemctl enable killadm &>/dev/null && echo -e "     ${rUlq} AVISO DE NOTIFICACION ${rUlq} " 
systemctl restart killadm &>/dev/null && echo -e " \033[1;32m LIMITADOR KILL MULTILOGIN ACTIVADO" || echo -e "  \033[1;31m ERROR AL INICIAR LIMITADOR"
msg -bar3
}
else
echo -e "${cor[2]} \033[1;31m FAIL \n" && msg -bar3 
sleep 2s
return
fi
read -p " PRESIONA ENTER PARA CONTINUAR" && clear
}

pamcrack () {
echo -e "Liberar passwd para VURTL"
echo -ne "Desea Seguir? [S/N]: "; read x
[[ $x = @(n|N) ]] && fun_bar && return
echo -e ""
_sleepColor '' "service ssh restart"
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password
_sleepColor '' "service ssh restart"
echo -e ""
echo -e " \033[1;31m[ ! ]${cor[5]}Configuraciones VURTL aplicadas"  | pv -qL 25
#msg -bar3
return
}

RSLL (){
echo -e " Escriba un nombre para el Redireccionador SSL"
read -p ": " nombressl
echo -e "${cor[5]} Selecione un Puerto De Redirecionamento Interna"
echo -ne "\033[1;37m"
echo -e " Ingresa el Puerto Local de tu VPS (Port a Redireccionar) "
read -p " Local-Port: " portserv
echo -e "${cor[5]} Digite el Puerto SSL, que Va a USAR:"
echo " Ingresa Puerto SSl/TLS a USAR (Recomendado 110-442-444)  "
read -p " Listen-SSL: " portssl
apt install stunnel4 -y
if lsof -Pi :$portssl -sTCP:LISTEN -t >/dev/null ; then
echo "Ya esta en uso ese puerto"
else
echo "[$nombressl] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf
echo "accept = $portssl " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf
sleep 1
echo -e "${cor[1]} ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL" | pv -qL 25
echo -e "${cor[1]} ##############################"
service stunnel4 restart 1>/dev/null 2>/dev/null &
sleep 1
fi
}

menu_item(){
  local opciones=("$@")
  local i=1
  msg -bar3
  #echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;43m[ REGRESAR ]\e[0m")"
  for item in "${opciones[@]}"; do
    echo -e "\033[0;35m [\033[0;36m${i}\033[0;35m]\033[0;33m ${flech} ${cor[3]}${item}"
    ((i++))
  done
  msg -bar3
  echo -e " \033[0;35m[\033[0;36m0\033[0;35m]\033[0;33m ${flech} $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
  msg -bar3
}

_herramientas_extra() {
while :
do
[[ $(cat /etc/crontab | grep 'bash /bin/') ]] && _opti="\033[0;31m [\033[0;32mON\033[0;31m]" || _opti="\033[0;31m [OFF]"
[[ -e /etc/systemd/system/killadm.service ]] && lmt="\033[0;31m [\033[0;32mON\033[0;31m] " || lmt="\033[0;31m [OFF]"
clear
msg -bar3
echo -e "${cor[2]}  ☯  MENU DE HERRAMIENTAS BETA ( EXPERIMENTALES)  ☯ "
menu_item "MENU DE REINICIO/REMOVER PROTOCOLOS" "OPTIMIZACIONES AUTOMATICAS ${_opti}" "HABILITAR CLAVE/ACCESO ROOT." "#- Soporte TLS 1.3# \033[0;33m( #EXPERIMENTAL )" "Memoria SWAP Particion \033[0;33m( #BETA )" "\033[1;35mKILL MULTILOGIN \033[0;33m(#BETA)  $lmt" "\033[1;36mFIX SSH -> DROPBEAR ( PORTA :${cor[1]} 22\033[1;36m ) \033[0;32m(#OFICIAL)" "Script TROJAN (directo) \033[0;32m(#OFICIAL)" "\033[1;36mFIX CONTRASEÑA ROOT EN AMAZON & GG CLOUD" "Mostrar Trafico Total de VPS \033[0;32m(#OFICIAL)" "CONFIGURAR ZONA HORARIA  \033[0;32m(#OFICIAL)" "Instalar Go Lang \033[0;32m(#OFICIAL)" "Creador de Payloads By \033[1;31m@RealStrategy  \033[0;33m(#BETA)" "TCP Aceleración (BBR/Plus) \033[0;33m(#BETA)" "FUNCIONES TESTE  \033[0;33m(#BETA) "
selection=$(selection_fun 20)
case ${selection} in
	0)clear&&clear && break;;
	1)
	clear
		menu_item "REINICIAR SERVICIOS \033[0;32m(#OFICIAL)" "Desinstalacion de SERVICIOS \033[0;32m(#OFICIAL)" "Mostrar Config de SERVICIOS \033[0;32m(#OFICIAL)" "Mostrar SERVICIOS Con mas Consumo \033[0;32m(#OFICIAL)"
		selection=$(selection_fun 4)
		case ${selection} in
		0)return 1;;
		1)reiniciar_ser;;
		2)
		clear
		while :
		do
		msg -bar3
		echo -e "\033[1;37mSeleccione una opcion a desinstalar:    Para Salir Ctrl + C${cor[5]}"
		menu_item "BADVPN " "FAIL2BAN " "STUNNEL4 $stunel" "WEBMIN " "PYTHON" "SHADOWSOCKS" "DROPBEAR" "OPENVPN" "LIBRERIAS 32BITS" "NGINX " "SQUID" "V2RAY" "V2-UI WEB $v2ui" "TROJAN Go $tojanss"
		selection=$(selection_fun 15)
		case ${selection} in
		0)clear&&clear && break;;
		1)removerbadvpn;;
		2)removerfail2ban;;
		3)removerstunnel;;
		4)removerwebmin;;
		5)removerpython;;
		6)removershadowsocks;;
		7)removerdropbear;;
		8)removeropenvpn;;
		9)removerlibs32;;
		10)removernginx;;
		11)removersquid;;
		12)removerv2ray;;
		13)removerv2ui;;
		14)removertro;;
		15)removetrojan;;
		esac
		done
		;;
		3)
		while :
		do
		clear&&clear
		msg -bar3
		echo -e "\033[1;37m      【    Escoje la Config a Mostrar    】\033[0m"
		menu_item "SSH                 ›   ${cor[2]}$xssh " "DROPBEAR            ›   ${cor[2]}$xdropbear" "STUNNEL4            ›   ${cor[2]}$xstunnel" "SQUID               ›   ${cor[2]}$xsquid" "PROXY PYTHON        ›   ${cor[2]}$xpython " "SHADOWSOCKS         ››  " "SOCKS5              ›   ${cor[2]}$xsocks5 " "SOCKD               ›   ${cor[2]}$xsocksd " "OPENVPN             ›   ${cor[2]}$xopenvpn "
		selection=$(selection_fun 9)
		case ${selection} in
		0) break ;;		
		1)configssh;;
		2)configdropbear;;
		3)configstunnel;;
		4)configsquid;;
		5)configproxy;;
		6)configshadow;;
		7)configsocks5;;
		8)configsockd;;
		9)configopenvpn;;
		esac
		done ;;
		4)
		mpro
		;;
		esac
	;;
	2)autoop;;
	3)cambiopass;;
	4)tls13;;
	5)xswap	;;
	6)verifi_fun;;
	7)fixssh;;
	8)ssrmenu;;
	9)rootpass;;
	10)mtraff;;
	#11)RSLL;;
	11)chora;;
	12)goinst;;
	13)crea_pay;;
	14)bbr;;
	15)fun_teste;;
	#12)wget -q -O /tmp/dnsNN.sh ${_link}g2kjp93v2l050a9/dnsNN.sh; chmod +x /tmp/dnsNN.sh;bash /tmp/dnsNN.sh;;
	#13)sfix;;
	#14)chora;;
	#15)goinst;;
	#16)crea_pay;;
	#17)bbr;;
	#18)clash-man;;
	#20)fun_teste;;
	esac
done
}
#FUNCIONES
#[[ $1 = 'start_menu' ]] && 
start_menu
#[[ $1 = '--troj.sh' ]] && troj.sh
