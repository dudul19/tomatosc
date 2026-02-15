#!/bin/bash

NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
REPO="https://raw.githubusercontent.com/dudul19/tomatosc/main/"

cd /etc/systemd/system/
rm -rf kyt.service
cd

#install
cd /usr/bin
rm -rf kyt
rm kyt.*
rm -rf bot
rm bot.*
apt update && apt upgrade
apt install neofetch -y
apt install python3 python3-pip git
cd /usr/bin
wget ${REPO}Bot/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget ${REPO}Bot/kyt.zip
unzip kyt.zip
pip3 install -r kyt/requirements.txt

#isi data
clear
echo "☉———————————————————————————————————☉"
echo "           • ADD BOT PANEL •          "
echo "☉———————————————————————————————————☉"
echo "  • Bot Token   : @BotFather"
echo "  • Telegram ID : @MissRose_bot"
echo "☉———————————————————————————————————☉"
echo ""
read -e -p "  Bot Token : " bottoken
read -e -p "  Telegram ID :" admin

echo BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
echo "#bot# $bottoken $admin" >/etc/bot/.bot.db
clear

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

systemctl start kyt 
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt.sh

clear
echo "☉————————————————————————————☉"
echo "          • BOT DATA •         "
echo "☉————————————————————————————☉"
echo " Bot Token      : $bottoken"
echo " Administrator  : $admin"
echo " Domain         : $domain"
echo "☉————————————————————————————☉"
echo ""
echo "Installations complete, type /menu on your bot"
read -n 1 -s -r -p "Press any key to back"
menu