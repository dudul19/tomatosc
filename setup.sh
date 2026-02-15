#!/bin/bash

# loading moon
function loading_moon() {
    local pid=$1
    local delay=0.1
    local moons=("🌑" "🌒" "🌓" "🌔" "🌕" "🌖" "🌗" "🌘")
    local i=0
    tput civis
    while ps -p "$pid" > /dev/null; do
        printf "\r  Loading... : %s" "${moons[i]}"
        i=$(( (i + 1) % 8 ))
        sleep $delay
    done
    tput cnorm
    printf "\r   \r"
}

# exe loading
loading_exe() {
    eval "$@" > /dev/null 2>&1 &
    local pid=$!
    loading_moon $pid
}

function update_upgrade() {
    apt upgrade -y
    apt update -y
    apt install -y
    apt install curl -y 
    apt install wondershaper -y
    apt install neofetch -y
    apt install jq curl -y
}
clear
echo "☉—————————————————————————————————————————————☉"
echo "    Tomato Autoscript By t.me/dudulrealnofek    "
echo "☉—————————————————————————————————————————————☉"
echo ""
echo "  Checking   : Environtment & Server"
loading_exe "update_upgrade"
clear 

# Variabel Data
TIME=$(date '+%d %b %Y')
ipsaya=$(wget -qO- ipinfo.io/ip)
TIMES="10"
CHATID="1476710905"
KEY="8217480105:AAGBhga3kOviy2Hfm2CnQhnvBP9FkYOjouo"
URL="https://api.telegram.org/bot$KEY/sendMessage"
REPO="https://raw.githubusercontent.com/dudul19/tomatosc/main/"
LICENSE="https://raw.githubusercontent.com/dudul19/license/main/tomato"
export IP=$(curl -sS icanhazip.com)
clear
echo ""
echo "☉———————————————————————————————————————————————————————☉"
echo "       • WELCOME TO TOMATO AUTOSCRIPT INSTALLER •         "
echo "☉———————————————————————————————————————————————————————☉"
echo "       This script will install a VPN on your server      "
echo "  SSH | Vmess | Vless | Trojan | Noobz | ZIVPN | OpenVPN  "
echo "        Installer Version: Tomat Merah 1.0 - LTS          "
echo "             Developer: t.me/dudulrealnofek               "
echo "☉———————————————————————————————————————————————————————☉"
echo "                 • SYSTEM INFORMATION •                   "
sleep 3

# Cek Arsitektur
if [[ $(uname -m | awk '{print $1}') == "x86_64" ]]; then
    echo "  [ OK ] Your Architecture Is Supported ( $(uname -m) )"
else
    echo "  [ ERROR ] Your Architecture Is Not Supported ( $(uname -m) )"
    exit 1
fi

# Cek OS
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
    echo "  [ OK ] Your OS Is Supported ( $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    echo "  [ OK ] Your OS Is Supported ( $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
else
    echo "  [ ERROR ] Your OS Is Not Supported ( $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
    exit 1
fi

# Validasi IP
if [[ $ipsaya == "" ]]; then
    echo "  [ ERROR ] IP Address ( Not Detected )"
else
    echo "  [ OK ] IP Address ( $ipsaya )"
fi

echo "☉————————————————————————————————————————————————————————☉"
echo ""
read -p "  Press [enter] to start installation "
clear
echo "  Checking User & License"
sleep 3

data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip=${LICENSE}
function checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne 
  else
    clear
    echo -e "☉————————————————————————————————————————————————————————☉"
    echo -e "                • 404 LICENSE NOT FOUND •                 "
    echo -e "☉————————————————————————————————————————————————————————☉"
    echo -e "                   PERMISSION DENIED !                    "
    echo -e "          Your VPS $ipsaya has been Banned                "
    echo -e "    You must buy access permissions for this scripts      "
    echo -e "          Price: Rp 10.000 ($ 1) /month for 1 IP          " 
    echo -e "             Buy Access: t.me/dudulrealnofek              "
    echo -e "☉————————————————————————————————————————————————————————☉"
    exit
  fi
}
checking_sc

# Validasi Root & Virt
if [ "${EUID}" -ne 0 ]; then
    echo "You need to run this script as root"
    exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
    echo "OpenVZ is not supported"
    exit 1
fi

# Inisialisasi IP
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
rm -f /usr/bin/user

# Cek Lisensi
username=$(curl ${LICENSE} | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
expx=$(curl ${LICENSE} | grep $MYIP | awk '{print $3}')
echo "$expx" >/usr/bin/e
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear

# Cek Expired
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo "Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff $Exp $DATE"
Info="(Active)"
Error="(Expired)"
today=$(date -d "0 days" +"%Y-%m-%d")
Exp1=$(curl ${LICENSE} | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi

clear
start=$(date +%s)

secs_to_human() {
    echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}

# --- UI Functions (Plain Text) ---
function print_ok() {
    echo "[ OK ] $1"
}
function print_error() {
    echo "[ ERROR ] $1"
}

function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi
}

mkdir -p /etc/xray >/dev/null 2>&1
curl -s ifconfig.me >/etc/xray/ipvps >/dev/null 2>&1
touch /etc/xray/domain >/dev/null 2>&1
mkdir -p /var/log/xray >/dev/null 2>&1
chown www-data.www-data /var/log/xray >/dev/null 2>&1
chmod +x /var/log/xray >/dev/null 2>&1
touch /var/log/xray/access.log >/dev/null 2>&1
touch /var/log/xray/error.log >/dev/null 2>&1
mkdir -p /var/lib/kyt >/dev/null 2>&1

# RAM & System Info
while IFS=":" read -r a b; do
    case $a in
    "MemTotal") ((mem_used += ${b/kB})); mem_total="${b/kB}" ;;
    "Shmem") ((mem_used += ${b/kB})) ;;
    "MemFree" | "Buffers" | "Cached" | "SReclaimable")
        mem_used="$((mem_used -= ${b/kB}))"
        ;;
    esac
done </proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=$(date -d "0 days" +"%d-%m-%Y - %X")
export OS_Name=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g')
export Kernel=$(uname -r)
export Arch=$(uname -m)
export IP=$(curl -s https://ipinfo.io/ip/)

# --- Core Functions ---
function first_setup() {
    timedatectl set-timezone Asia/Jakarta
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        sudo apt update -y
        apt-get install --no-install-recommends software-properties-common
        add-apt-repository ppa:vbernat/haproxy-2.0 -y
        apt-get -y install haproxy=2.0.\*
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        curl https://haproxy.debian.net/bernat.debian.org.gpg |
            gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
        echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
            http://haproxy.debian.net buster-backports-1.8 main \
            >/etc/apt/sources.list.d/haproxy.list
        sudo apt-get update
        apt-get -y install haproxy=1.8.\*
    else
        echo " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g'))"
        exit 1
    fi
    clear
}

function nginx_install() {
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        sudo apt-get install nginx -y
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        apt -y install nginx
    else
        echo " Your OS Is Not Supported ( $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
    fi
}

function base_package() {
    apt install at -y
    apt install zip pwgen openssl netcat socat cron bash-completion -y
    apt install figlet -y
    apt update -y
    apt upgrade -y
    apt dist-upgrade -y
    systemctl enable chronyd
    systemctl restart chronyd
    systemctl enable chrony
    systemctl restart chrony
    chronyc sourcestats -v
    chronyc tracking -v
    apt install ntpdate -y
    ntpdate pool.ntp.org
    apt install sudo -y
    sudo apt-get clean all
    sudo apt-get autoremove -y
    sudo apt-get install -y debconf-utils
    sudo apt-get remove --purge exim4 -y
    sudo apt-get remove --purge ufw firewalld -y
    sudo apt-get install -y --no-install-recommends software-properties-common
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    clear
}

function pasang_domain() {
    clear
    echo ""
    echo "☉———————————————————————————————————☉"
    echo "         • POINTING DOMAIN •          "
    echo "☉———————————————————————————————————☉"
    echo "  Please Select a Domain Type Below   "
    echo "  [01] • Your Domain                  "
    echo "  [02] • Random Domain                "
    echo "☉———————————————————————————————————☉"
    echo ""
    read -p "Please select an options [1-2 or any (random)] : " host
    echo ""
    if [[ $host == "1" ]]; then
        clear
        echo ""
        echo "☉———————————————————————————————————☉"
        echo "         • CHANGES DOMAIN •           "
        echo "☉———————————————————————————————————☉"
        read -p "  Your Domain     : " host1
        read -p "  Client Name     : " nama
        echo "IP=" >>/var/lib/kyt/ipvps.conf
        echo $host1 >/etc/xray/domain
        echo $host1 >/root/domain
        echo $nama >>/etc/xray/username
        echo ""
    elif [[ $host == "2" ]]; then
        wget ${REPO}Fls/cf.sh && chmod +x cf.sh >/dev/null 2>&1
        ./cf.sh 
        rm -f /root/cf.sh
    else
        print_install "Random Subdomain is Used"
        pasang_domain
    fi
    clear
}

function ins_restart() {
    /etc/init.d/nginx restart
    /etc/init.d/openvpn restart
    /etc/init.d/ssh restart
    /etc/init.d/dropbear restart
    /etc/init.d/fail2ban restart
    /etc/init.d/vnstat restart
    systemctl restart haproxy
    /etc/init.d/cron restart
    systemctl daemon-reload
    systemctl start netfilter-persistent
    systemctl enable --now nginx
    systemctl enable --now xray
    systemctl enable --now rc-local
    systemctl enable --now dropbear
    systemctl enable --now openvpn
    systemctl enable --now cron
    systemctl enable --now haproxy
    systemctl enable --now netfilter-persistent
    systemctl enable --now ws
    systemctl enable --now fail2ban
    systemctl enable --now udp-custom
    systemctl enable --NOW noobzvpns
    history -c
    echo "unset HISTFILE" >>/etc/profile
    cd
    rm -f /root/openvpn
    rm -f /root/key.pem
    rm -f /root/cert.pem
    clear
}

function restart_system() {   
    USRSC=$(wget -qO- "${LICENSE}" | grep -w "${ipsaya}" | awk '{print $2}')
    EXPSC=$(wget -qO- "${LICENSE}" | grep -w "${ipsaya}" | awk '{print $3}')
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    TEXT="
☉—————————————————☉
• INSTALL SUCCESS •
☉—————————————————☉
Client  : ${USRSC}
Domain  : ${domain}
Date    : ${TIME}
Time    : ${TIMEZONE}
IP VPS  : ${ipsaya}
Expired : ${EXPSC}
☉—————————————————☉
 Tomato Autoscript
"'&reply_markup={"inline_keyboard":[[{"text":"Developer","url":"https://t.me/dudulrealnofek"}]]}'

    curl -s --max-time "${TIMES}" -d "chat_id=${CHATID}&disable_web_page_preview=1&text=${TEXT}&parse_mode=html" "${URL}" >/dev/null
    clear
}

function pasang_ssl() {
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    clear
}

function make_folder_xray() {
    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/bot/.bot.db
    mkdir -p /etc/bot
    mkdir -p /etc/xray
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /etc/ssh
    mkdir -p /usr/bin/xray/
    mkdir -p /var/log/xray/
    mkdir -p /var/www/html
    mkdir -p /etc/kyt/files/vmess/ip
    mkdir -p /etc/kyt/files/vless/ip
    mkdir -p /etc/kyt/files/trojan/ip
    mkdir -p /etc/kyt/files/ssh/ip
    mkdir -p /etc/files/vmess
    mkdir -p /etc/files/vless
    mkdir -p /etc/files/trojan
    mkdir -p /etc/files/ssh
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    touch /etc/bot/.bot.db
    echo "& plughin Account" >>/etc/vmess/.vmess.db
    echo "& plughin Account" >>/etc/vless/.vless.db
    echo "& plughin Account" >>/etc/trojan/.trojan.db
    echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
    echo "& plughin Account" >>/etc/ssh/.ssh.db
    clear
}

function install_xray() {
    domainSock_dir="/run/xray"
    ! [ -d $domainSock_dir ] && mkdir $domainSock_dir
    chown www-data.www-data $domainSock_dir
    latest_version="v24.11.11"
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
    wget -O /etc/xray/config.json "${REPO}Cfg/config.json" >/dev/null 2>&1
    wget -O /etc/systemd/system/runn.service "${REPO}Fls/runn.service" >/dev/null 2>&1
    domain=$(cat /etc/xray/domain)
    IPVS=$(cat /etc/xray/ipvps)
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    wget -O /etc/haproxy/haproxy.cfg "${REPO}Cfg/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${REPO}Cfg/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    curl ${REPO}Cfg/nginx.conf >/etc/nginx/nginx.conf
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
    chmod +x /etc/systemd/system/runn.service
    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target
[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
filesNPROC=10000
filesNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF
    clear
}

function ssh() {
    wget -O /etc/pam.d/common-password "${REPO}Fls/password"
    chmod +x /etc/pam.d/common-password
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
    cd
    cat >/etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
    cat >/etc/rc.local <<-END
exit 0
END
    chmod +x /etc/rc.local
    systemctl enable rc-local
    systemctl start rc-local.service
    echo 1 >/proc/sys/net/ipv6/conf/all/disable_ipv6
    sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
    clear
}

function udp_mini() {
    wget ${REPO}Fls/limit.sh && chmod +x limit.sh && ./limit.sh
    cd
    wget -q -O /usr/bin/limit-ip "${REPO}Fls/limit-ip"
    chmod +x /usr/bin/*
    cd /usr/bin
    sed -i 's/\r//' limit-ip
    cd
    clear
    cat >/etc/systemd/system/vmip.service <<EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/files-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl restart vmip
    systemctl enable vmip
    cat >/etc/systemd/system/vlip.service <<EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/files-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl restart vlip
    systemctl enable vlip
    cat >/etc/systemd/system/trip.service <<EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/files-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl restart trip
    systemctl enable trip
    mkdir -p /usr/local/kyt/
    wget -q -O /usr/local/kyt/udp-mini "${REPO}Fls/udp-mini"
    chmod +x /usr/local/kyt/udp-mini
    wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}Fls/udp-mini-1.service"
    wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}Fls/udp-mini-2.service"
    wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}Fls/udp-mini-3.service"
    systemctl disable udp-mini-1
    systemctl stop udp-mini-1
    systemctl enable udp-mini-1
    systemctl start udp-mini-1
    systemctl disable udp-mini-2
    systemctl stop udp-mini-2
    systemctl enable udp-mini-2
    systemctl start udp-mini-2
    systemctl disable udp-mini-3
    systemctl stop udp-mini-3
    systemctl enable udp-mini-3
    systemctl start udp-mini-3
    clear
}

function ssh_slow() {
    wget -q -O /tmp/nameserver "${REPO}Fls/nameserver" >/dev/null 2>&1
    chmod +x /tmp/nameserver
    bash /tmp/nameserver | tee /root/install.log
    clear
}

function ins_SSHD() {
    wget -q -O /etc/ssh/sshd_config "${REPO}Fls/sshd" >/dev/null 2>&1
    chmod 700 /etc/ssh/sshd_config
    /etc/init.d/ssh restart
    systemctl restart ssh
    /etc/init.d/ssh status
    clear
}

function ins_dropbear() {
    apt-get install dropbear -y >/dev/null 2>&1
    wget -q -O /etc/default/dropbear "${REPO}Cfg/dropbear.conf"
    chmod +x /etc/default/dropbear
    /etc/init.d/dropbear restart
    /etc/init.d/dropbear status
    clear
}

function ins_vnstat() {
    apt -y install vnstat >/dev/null 2>&1
    /etc/init.d/vnstat restart
    apt -y install libsqlite3-dev >/dev/null 2>&1
    wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
    tar zxvf vnstat-2.6.tar.gz
    cd vnstat-2.6
    ./configure --prefix=/usr --sysconfdir=/etc && make && make install
    cd
    vnstat -u -i $NET
    sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
    chown vnstat:vnstat /var/lib/vnstat -R
    systemctl enable vnstat
    /etc/init.d/vnstat restart
    /etc/init.d/vnstat status
    rm -f /root/vnstat-2.6.tar.gz
    rm -rf /root/vnstat-2.6
    clear
}

function ins_openvpn() {
    wget ${REPO}Fls/openvpn && chmod +x openvpn && ./openvpn
    /etc/init.d/openvpn restart
    clear
}

function ins_backup() {
    apt install rclone -y
    printf "q\n" | rclone config
    wget -O /root/.config/rclone/rclone.conf "${REPO}Cfg/rclone.conf"
    cd /bin
    git clone https://github.com/LunaticBackend/wondershaper.git
    cd wondershaper
    sudo make install
    cd
    rm -rf wondershaper
    echo >/home/files
    apt install msmtp-mta ca-certificates bsd-mailx -y
    cat <<EOF >>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77
logfile ~/.msmtp.log
EOF
    chown -R www-data:www-data /etc/msmtprc
    wget -q -O /etc/ipserver "${REPO}Fls/ipserver" && bash /etc/ipserver
    clear
}

function ins_swab() {
    gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    dd if=/dev/zero of=/swapfile bs=1024 count=1048576
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
    chronyd -q 'server 0.id.pool.ntp.org iburst'
    chronyc sourcestats -v
    chronyc tracking -v
    wget ${REPO}Fls/bbr.sh && chmod +x bbr.sh && ./bbr.sh
    clear
}

function ins_Fail2ban() {
    if [ -d '/usr/local/ddos' ]; then
        echo "Please un-install the previous version first"
        exit 0
    else
        mkdir /usr/local/ddos
    fi
    clear
    echo "Banner /etc/banner.txt" >>/etc/ssh/sshd_config
    sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/banner.txt"@g' /etc/default/dropbear
    wget -O /etc/banner.txt "${REPO}Bnr/banner.txt"
    clear
}

function ins_epro() {
    wget -O /usr/bin/ws "${REPO}Fls/ws" >/dev/null 2>&1
    wget -O /usr/bin/tun.conf "${REPO}Cfg/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${REPO}Fls/ws.service" >/dev/null 2>&1
    chmod +x /etc/systemd/system/ws.service
    chmod +x /usr/bin/ws
    chmod 644 /usr/bin/tun.conf
    systemctl disable ws
    systemctl stop ws
    systemctl enable ws
    systemctl start ws
    systemctl restart ws
    wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
    wget -O /usr/sbin/ftvpn "${REPO}Fls/ftvpn" >/dev/null 2>&1
    chmod +x /usr/sbin/ftvpn
    iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
    iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
    iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
    iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
    iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
    iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
    iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
    iptables-save >/etc/iptables.up.rules
    iptables-restore -t </etc/iptables.up.rules
    netfilter-persistent save
    netfilter-persistent reload
    cd
    apt autoclean -y >/dev/null 2>&1
    apt autoremove -y >/dev/null 2>&1
    echo "change to time GMT+7"
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    clear
}

function ins_noobz() {
    cd  
    git clone https://github.com/rifstore/noobzvpn.git
    cd noobzvpn/
    chmod +x install.sh
    ./install.sh
    echo start service noobzvpns
    systemctl start noobzvpns &>/dev/null
    echo enable service noobzvpns
    systemctl enable noobzvpns &>/dev/null
    clear
}

function ins_zivpn(){
    wget -q ${REPO}Fls/zivpn
    chmod +x zivpn
    ./zivpn
    git clone https://github.com/rifstore/noobzvpn.git
    cd noobzvpn/
    chmod +x install.sh
    ./install.sh
    systemctl start noobzvpns &>/dev/null
    systemctl enable noobzvpns &>/dev/null
    clear
}

function menu() {
    wget ${REPO}Cdy/menu.zip
    wget -q -O /usr/bin/enc "${REPO}Enc/encrypt"
    chmod +x /usr/bin/enc
    7z x menu.zip
    chmod +x menu/*
    enc menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
    rm -rf /usr/local/sbin/*~
    rm -rf /usr/local/sbin/gz*
    rm -rf /usr/local/sbin/*.bak
    rm -rf /usr/local/sbin/m-noobz
    wget ${REPO}Cfg/m-noobz
    cp m-noobz /usr/local/sbin
    rm m-noobz*
    chmod +x /usr/local/sbin/m-noobz
    clear
}

function profile() {
    cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
welcome
EOF
    cat >/etc/cron.d/log_clear <<-END
        8 0 * * * root /usr/local/bin/log_clear
    END

    cat >/usr/local/bin/log_clear <<-END
    #!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Sucsesfully clear & restart On $tanggal Time $waktu." >> /root/log-clear.txt
systemctl restart udp-custom.service
END
    chmod +x /usr/local/bin/log_clear

    cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
    cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END
    chmod 644 /root/.profile
    cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
5 0 * * * root /sbin/reboot
END
    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    cat >/home/daily_reboot <<-END
5
END
    cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF
    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    cat >/etc/rc.local <<EOF
#!/bin/bash
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
    chmod +x /etc/rc.local
    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
    clear
}

function enable_services() {
    systemctl daemon-reload
    systemctl start netfilter-persistent
    systemctl enable --now rc-local
    systemctl enable --now cron
    systemctl enable --now netfilter-persistent
    systemctl restart nginx
    systemctl restart xray
    systemctl restart cron
    systemctl restart haproxy
    systemctl restart zivpn
    clear
}

# loading banner
function task_banner() {
    clear
    echo "☉—————————————————————————————————————————————☉"
    echo "    Tomato Autoscript By t.me/dudulrealnofek    "
    echo "☉—————————————————————————————————————————————☉"
    echo ""
}
function task_1() {
    task_banner
    echo "  Progress   : 4%"
    echo "  Step 1/23  : Setup Timezone & Haproxy"
    loading_exe "first_setup"  
}
function task_2() {
    task_banner
    echo "  Progress   : 8%"
    echo "  Step 2/23  : Setup Nginx"
    loading_exe "nginx_install"   
}
function task_3() {
    task_banner
    echo "  Progress   : 12%"
    echo "  Step 3/23  : Setup Base Packages"  
    loading_exe "base_package" 
}
function task_4() {
    task_banner
    echo "  Progress   : 16%"
    echo "  Step 4/23  : Setup Xray Folder" 
    loading_exe "make_folder_xray" 
}
function task_5() {
    task_banner
    echo "  Progress   : 20%"
    echo "  Step 5/23  : Setup SSL For Domain" 
    loading_exe "pasang_ssl" 
}
function task_6() {
    task_banner
    echo "  Progress   : 24%"
    echo "  Step 6/23  : Setup Xray Core Stable"
    loading_exe "install_xray" 
}
function task_7() {
    task_banner
    echo "  Progress   : 28%"
    echo "  Step 7/23  : Setup SSH Password"
    loading_exe "ssh" 
}
function task_8() {
    task_banner
    echo "  Progress   : 32%"
    echo "  Step 8/23  : Setup Quota Limitter"
    loading_exe "udp_mini" 
}
function task_9() {
    task_banner
    echo "  Progress   : 36%"
    echo "  Step 9/23  : Setup Slow DNS"
    loading_exe "ssh_slow" 
}
function task_10() {
    task_banner
    echo "  Progress   : 40%"
    echo "  Step 10/23 : Setup SSHD Configuration"
    loading_exe "ins_SSHD" 
}
function task_11() {
    task_banner
    echo "  Progress   : 44%"
    echo "  Step 11/23 : Setup Dropbear"
    loading_exe "ins_dropbear" 
}
function task_12() {
    task_banner
    echo "  Progress   : 48%"
    echo "  Step 12/23 : Setup Vnstat Monitoring"
    loading_exe "ins_vnstat" 
}
function task_13() {
    task_banner
    echo "  Progress   : 52%"
    echo "  Step 13/23 : Setup Open VPN"
    loading_exe "ins_openvpn" 
}
function task_14() {
    task_banner
    echo "  Progress   : 56%"
    echo "  Step 14/23 : Setup Backup & Restore"
    loading_exe "ins_backup" 
}
function task_15() {
    task_banner
    echo "  Progress   : 60%"
    echo "  Step 15/23 : Setup Swab Storage"
    loading_exe "ins_swab" 
}
function task_16() {
    task_banner
    echo "  Progress   : 64%"
    echo "  Step 16/23 : Setup Fail2ban"
    loading_exe "ins_Fail2ban" 
}
function task_17() {
    task_banner
    echo "  Progress   : 68%"
    echo "  Step 17/23 : Setup UDP ZiVPN & Noobz"
    loading_exe "ins_zivpn" 
}
function task_18() {
    task_banner
    echo "  Progress   : 72%"
    echo "  Step 18/23 : Setup ePro Websocket Proxy"
    loading_exe "ins_epro" 
}
function task_19() {
    task_banner
    echo "  Progress   : 78%"
    echo "  Step 19/24 : Setup Restart Service"
    loading_exe "ins_restart" 
}
function task_20() {
    task_banner
    echo "  Progress   : 84%"
    echo "  Step 20/23 : Setup Menu Packages"
    loading_exe "menu" 
}
function task_21() {
    task_banner
    echo "  Progress   : 90%"
    echo "  Step 21/23 : Setup Profile"
    loading_exe "profile" 
}
function task_22() {
    task_banner
    echo "  Progress   : 94%"
    echo "  Step 22/23 : Setup Enable Services"
    loading_exe "enable_services" 
}
function task_23() {
    task_banner
    echo "  Progress   : 100%"
    echo "  Step 23/23 : Restarting System"
    loading_exe "restart_system" 
}

function instal() {
    task_1
    task_2
    task_3
    task_4
    pasang_domain
    task_5
    task_6
    task_7
    task_8
    task_9
    task_10
    task_11 
    task_12
    task_13
    task_14
    task_15
    task_16
    task_17
    task_18
    task_19
    task_20
    task_21
    task_22
    task_23
}

instal
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username
clear
echo "☉———————————————————————————————————————————————————————☉"
echo "        • INSTALLATION TOMATO AUTOSCRIPT SUCCESS •        "
echo "☉———————————————————————————————————————————————————————☉"
echo "               Thanks for using our service               "
echo "             Enjoy VPN services on your server            "
echo "                   Happy Tunneling :)                     "
echo "             Developer: t.me/dudulrealnofek               "
echo "☉———————————————————————————————————————————————————————☉"
echo "          Your server will be reboot on 5 sec....         "
sleep 6
reboot