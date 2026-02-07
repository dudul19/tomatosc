#!/bin/bash

# Memuat informasi yang diperlukan
NS=$(cat /etc/xray/dns)
PUB=$(cat /etc/slowdns/server.pub)
domain=$(cat /etc/xray/domain)
REPO="https://raw.githubusercontent.com/dudul19/tomatosc/main/"
LICENSE="https://raw.githubusercontent.com/dudul19/license/main/tomato"

# Definisi warna (Dikosongkan agar menjadi plain text)
grenbo=""
NC=""

# Pindah ke direktori systemd untuk membersihkan layanan sebelumnya
cd /etc/systemd/system/
rm -rf kyt.service
cd

# Instalasi paket yang diperlukan
cd /usr/bin
rm -rf kyt
rm -rf bot
apt update && apt upgrade -y
apt install python3 python3-pip git -y

# Unduh dan siapkan bot
cd /usr/bin
wget ${REPO}Bot/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip

# Unduh dan siapkan kyt
clear
cd
wget ${REPO}Bot/kyt.zip
unzip kyt.zip
cp -r kyt /usr/bin/
cd /usr/bin
pip3 install -r kyt/requirements.txt

# Unduh dan siapkan skrip 2fa.py
wget ${REPO}Bot/2fa.py -O /usr/bin/2fa.py
chmod +x /usr/bin/2fa.py

# Minta pengguna untuk memasukkan Token Bot dan ID Admin
echo "=========================================="
echo "             CREATE BOT PANEL             "
echo "=========================================="
echo "Create Telegram Bot and Get Token"
echo "[*] Bot Token : @BotFather"
echo "[*] Telegram ID : @MissRose_bot, type /info"
echo "=========================================="

# Membaca input pengguna untuk Token Bot dan ID Admin
read -e -p "[*] Masukkan Token Bot Anda : " bottoken
read -e -p "[*] Masukkan ID Telegram Anda :" admin

# Simpan detail bot dan admin ke var.txt
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt

# Bersihkan database sebelumnya
rm /etc/bot/.bot.db
echo "#bot# ${bottoken} ${admin}" >> /etc/bot/.bot.db
clear

# Buat layanan systemd untuk kyt
cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

# Mulai dan aktifkan layanan
systemctl start kyt 
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt*

# Pesan penyelesaian
clear
echo "==============================="
echo "         Your Bot Data         "
echo "==============================="
echo "Bot Token      : $bottoken"
echo "Administrator  : $admin"
echo "Domain         : $domain"
echo "==============================="
echo "Installation Complete"
echo "Type /menu on your Bot"
echo " "
read -p "Press [ Enter ] to back on menu"
menu