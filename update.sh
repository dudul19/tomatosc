#!/bin/bash

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
clear

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

loading_exe() {
    eval "$@" > /dev/null 2>&1 &
    local pid=$!
    loading_moon $pid
}

function update_script() {
    cd /usr/local/
    rm -rf sbin
    rm -rf /usr/bin/enc
    cd
    mkdir /usr/local/sbin
    wget https://raw.githubusercontent.com/dudul19/tomatosc/main/Cdy/menu.zip
    wget -q -O /usr/bin/enc "https://raw.githubusercontent.com/dudul19/tomatosc/main/Enc/encrypt"
    chmod +x /usr/bin/enc
    7z x menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
    rm -rf *.sh*
    rm -rf /usr/local/sbin/*~
    rm -rf /usr/local/sbin/gz*
    rm -rf /usr/local/sbin/*.bak
    netfilter-persistent
}

clear
echo "☉—————————————————————————————————————————————☉"
echo "    Tomato Autoscript By t.me/dudulrealnofek    "
echo "☉—————————————————————————————————————————————☉"
echo ""
echo "  Progress   : 7%"
echo "  Step 1/1   : Updating Script Latest Version"
loading_exe "update_script"
clear 
sleep 2
echo "☉—————————————————————————————————————————————☉"
echo "    Tomato Autoscript By t.me/dudulrealnofek    "
echo "☉—————————————————————————————————————————————☉"
echo ""
echo "  Progress   : 100%"
echo "  Loading... : Success"
echo ""
read -n 1 -s -r -p "Press any key to go back"
welcome
