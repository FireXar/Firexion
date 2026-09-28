# Author: Jrohy
# github: https://github.com/Jrohy/multi-v2ray

function chekKEY {
    return 0
}

[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/karl1999x/ChumoGH/main/styles/styles.cpp)

apt install jq -y
BEIJING_UPDATE_TIME=3
BEGIN_PATH=$(pwd)
INSTALL_WAY=0
HELP=0
REMOVE=0
CHINESE=0
BASE_SOURCE_PATH="https://multi.netlify.app"
UTIL_PATH="/etc/v2ray_util/util.cfg"
UTIL_CFG="$BASE_SOURCE_PATH/v2ray_util/util_core/util.cfg"
BASH_COMPLETION_SHELL="$BASE_SOURCE_PATH/v2ray"
CLEAN_IPTABLES_SHELL="$BASE_SOURCE_PATH/v2ray_util/global_setting/clean_iptables.sh"
#Centos 临时取消别名
[[ -f /etc/redhat-release && -z $(echo $SHELL|grep zsh) ]] && unalias -a
[[ -z $(echo $SHELL|grep zsh) ]] && ENV_FILE=".bashrc" || ENV_FILE=".zshrc"
#######color code########
RED="31m"
GREEN="32m"
YELLOW="33m"
BLUE="36m"
FUCHSIA="35m"

colorEcho(){
    COLOR=$1
    echo -e "\033[${COLOR}${@:2}\033[0m"
}

#######get params#########
while [[ $# > 0 ]];do
    key="$1"
    case $key in
        --remove)
        REMOVE=1
        ;;
        -h|--help)
        HELP=1
        ;;
        -k|--keep)
        INSTALL_WAY=1
        colorEcho ${BLUE} "keep config to update\n"
        ;;
        --zh)
        CHINESE=0
        colorEcho ${BLUE} "VERSION CHINA..\n"
        ;;
        *)
                # unknown option
        ;;
    esac
    shift # past argument or value
done
#############################

help(){
    echo "bash v2ray.sh [-h|--help] [-k|--keep] [--remove]"
    echo "  -h, --help           Show help"
    echo "  -k, --keep           keep the config.json to update"
    echo "      --remove         remove v2ray,xray && multi-v2ray"
    echo "                       no params to new install"
    return 0
}

removeV2Ray() {
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
    rm -rf /etc/profile.d/iptables.sh >/dev/null 2>&1
    rm -rf /root/.iptables >/dev/null 2>&1

    #删除v2ray定时更新任务
    crontab -l|sed '/SHELL=/d;/v2ray/d'|sed '/SHELL=/d;/xray/d' > crontab.txt
    crontab crontab.txt >/dev/null 2>&1
    rm -f crontab.txt >/dev/null 2>&1

    if [[ ${PACKAGE_MANAGER} == 'dnf' || ${PACKAGE_MANAGER} == 'yum' ]];then
        systemctl restart crond >/dev/null 2>&1
    else
        systemctl restart cron >/dev/null 2>&1
    fi

    #删除multi-v2ray环境变量
    sed -i '/v2ray/d' ~/$ENV_FILE
    sed -i '/xray/d' ~/$ENV_FILE
    source ~/$ENV_FILE

    RC_SERVICE=`systemctl status rc-local|grep loaded|egrep -o "[A-Za-z/]+/rc-local.service"`

    RC_FILE=`cat $RC_SERVICE|grep ExecStart|awk '{print $1}'|cut -d = -f2`

    sed -i '/iptables/d' ~/$RC_FILE

    colorEcho ${GREEN} "uninstall success!"
}

closeSELinux() {
    #禁用SELinux
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

checkSys() {
    #检查是否为Root
    [ $(id -u) != "0" ] && { colorEcho ${RED} "Error: Porfavor ejecute este SCRIP como root"; exit 1; }

    if [[ `command -v apt-get` ]];then
        PACKAGE_MANAGER='apt-get'
    elif [[ `command -v dnf` ]];then
        PACKAGE_MANAGER='dnf'
    elif [[ `command -v yum` ]];then
        PACKAGE_MANAGER='yum'
    else
        colorEcho $RED "Sistema No Soportado!"
        exit 1
    fi
}

#安装依赖
installDependent(){
    if [[ ${PACKAGE_MANAGER} == 'dnf' || ${PACKAGE_MANAGER} == 'yum' ]];then
        ${PACKAGE_MANAGER} install socat crontabs bash-completion which -y
    else
        ${PACKAGE_MANAGER} update
        ${PACKAGE_MANAGER} install socat cron bash-completion ntpdate gawk -y
    fi

    #install python3 & pip
    source <(curl -sL https://python3.netlify.app/install.sh)
}

updateProject() {
	if [[ ! $(type pip 2>/dev/null) ]]; then
		print_center -ama 'Falta en la dependencia pip\nNo se puede continuar con la instalacion'
		enter
		return 1
	fi
    pip3 install -U v2ray_util
    if [[ -e $UTIL_PATH ]];then
        [[ -z $(cat $UTIL_PATH|grep lang) ]] && echo "lang=en" >> $UTIL_PATH
    else
        mkdir -p /etc/v2ray_util
        curl $UTIL_CFG > $UTIL_PATH
    fi
    rm -f /usr/local/bin/v2ray >/dev/null 2>&1
    ln -s $(which v2ray-util) /usr/local/bin/v2ray
    rm -f /usr/local/bin/xray >/dev/null 2>&1
    ln -s $(which v2ray-util) /usr/local/bin/xray
    [[ -e /etc/bash_completion.d/v2ray.bash ]] && rm -f /etc/bash_completion.d/v2ray.bash
    [[ -e /usr/share/bash-completion/completions/v2ray.bash ]] && rm -f /usr/share/bash-completion/completions/v2ray.bash
    curl $BASH_COMPLETION_SHELL > /usr/share/bash-completion/completions/v2ray
    curl $BASH_COMPLETION_SHELL > /usr/share/bash-completion/completions/xray
    if [[ -z $(echo $SHELL|grep zsh) ]];then
        source /usr/share/bash-completion/completions/v2ray
        source /usr/share/bash-completion/completions/xray
    fi
    # bash <(curl -L -s https://multi.netlify.app/go.sh)
    bash <(curl -L -s https://raw.githubusercontent.com/ChumoGH/ADMcgh/main/Plugins/V2ray/go.sh) --version v4.45.2
    #[[ ${INSTALL_WAY} == 0 ]] && bash <(curl -L -s https://multi.netlify.app/go.sh) "--version" "v4.45.2"
}

#时间同步
timeSync() {
    if [[ ${INSTALL_WAY} == 0 ]];then
        echo -e "${Info} Sincronizando tiempo!.. ${Font}"
        if [[ `command -v ntpdate` ]];then
            ntpdate pool.ntp.org
        elif [[ `command -v chronyc` ]];then
            chronyc -a makestep
        fi

        if [[ $? -eq 0 ]];then 
            echo -e "${OK} Tiempo Sync Exitosamente ${Font}"
            echo -e "${OK} Ahora: `date -R`${Font}"
        fi
    fi
}

profileInit() {

    #清理v2ray模块环境变量
    [[ $(grep v2ray ~/$ENV_FILE) ]] && sed -i '/v2ray/d' ~/$ENV_FILE && source ~/$ENV_FILE

    #解决Python3中文显示问题
    [[ -z $(grep PYTHONIOENCODING=utf-8 ~/$ENV_FILE) ]] && echo "export PYTHONIOENCODING=utf-8" >> ~/$ENV_FILE && source ~/$ENV_FILE

    #全新安装的新配置
    [[ ${INSTALL_WAY} == 0 ]] && v2ray new || v2ray new

    echo ""
}

installFinish() {
#if [[ ${INSTALL_WAY} == 0 ]]; then
clear&&clear
#v2ray new
#v2ray info
#echo -e "porfavor dijite 'v2ray' para administrar v2ray\n"
#fi
	config='/etc/v2ray/config.json'
    tmp='/etc/v2ray/temp.json'
    #jq 'del(.inbounds[].streamSettings.kcpSettings[])' < $config >> $tmp
    #rm -rf /etc/v2ray/config.json
    #jq '.inbounds[].streamSettings += {"network":"ws","wsSettings":{"path": "/ADMcgh/","headers": {"Host": "ejemplo.com"}}}' < $tmp >> $config
    chmod 777 $config
    msg -bar
    if [[ $(v2ray restart|grep success) ]]; then
    	[[ $(which v2ray) ]] && v2ray info
    	msg -bar
        echo -e "\033[1;32mINSTALACION FINALIZADA"
    else
    	[[ $(which v2ray) ]] && v2ray info
    	msg -bar
        print_center -verm2 "INSTALACION FINALIZADA"
        echo -e "\033[1;31m "  'Pero fallo el reinicio del servicio v2ray'
	echo -e " LEA DETALLADAMENTE LOS MENSAJES "
	echo -e ""
    fi
	cd ${BEGIN_PATH}
    [[ ${INSTALL_WAY} == 0 ]] && WAY="install" || WAY="update"
    colorEcho  ${GREEN} "multi-v2ray ${WAY} success!\n"
    echo -e  "Por favor verifique el log"
	#chekKEY &> /dev/null 2>&1
    #回到原点
}


main() {

    [[ ${HELP} == 1 ]] && help && return

    [[ ${REMOVE} == 1 ]] && colorEcho ${BLUE} " REMOVE BY @ChumoGH " && removeV2Ray && return

    [[ ${INSTALL_WAY} == 0 ]] && colorEcho ${BLUE} " INSTALACION NUEVA NATIVA By @ChumoGH\n"

    checkSys

    installDependent

    closeSELinux

    timeSync

    updateProject

    profileInit

    installFinish
}

main