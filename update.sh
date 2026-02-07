#!/bin/bash

# Bersihkan layar dan direktori lama
clear
cd /usr/local/
rm -rf sbin
rm -rf /usr/bin/enc
cd
mkdir /usr/local/sbin

# Ambil Tanggal Server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# Fungsi Warna Legacy (Disederhanakan tanpa kode warna)
red() { echo -e "${*}"; }

clear

# Fungsi Loading Bar (Plain Text Style)
function load() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    
    tput civis
    echo -ne "Please Wait Loading - [ "
    while true; do
        for ((i = 0; i < 5; i++)); do
            echo -ne "# " # Bar pagar biasa
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "Please Wait Loading - ["
    done
    echo -e "] - OK !"
    tput cnorm
}

# Fungsi Update Resource
res1() {
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
}

# Eksekusi Netfilter
netfilter-persistent
clear

# Tampilan Banner Plain Text
echo -e "☉———————————————————————————————————————☉"
echo -e "          UPDATE TOMATO AUTOSCRIPT        "
echo -e "☉———————————————————————————————————————☉"
echo -e "      Updating Service & Script...        "
res1 >/dev/null 2>&1
load
echo -e "☉———————————————————————————————————————☉"
echo -e ""
read -n 1 -s -r -p "Press any key to go back"
menu