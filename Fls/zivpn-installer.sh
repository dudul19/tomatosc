#!/bin/bash

PASSWORDS="tomato" 
systemctl stop zivpn.service 1> /dev/null 2> /dev/null

wget https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64 -O /usr/local/bin/zivpn 1> /dev/null 2> /dev/null
chmod +x /usr/local/bin/zivpn
mkdir -p /etc/zivpn 1> /dev/null 2> /dev/null
wget https://raw.githubusercontent.com/dudul19/tomatosc/main/Fls/config.json -O /etc/zivpn/config.json 1> /dev/null 2> /dev/null

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=California/L=Los Angeles/O=Example Corp/OU=IT Department/CN=zivpn" -keyout "/etc/zivpn/zivpn.key" -out "/etc/zivpn/zivpn.crt"
sysctl -w net.core.rmem_max=16777216 1> /dev/null 2> /dev/null
sysctl -w net.core.wmem_max=16777216 1> /dev/null 2> /dev/null

cat <<EOF > /etc/systemd/system/zivpn.service
[Unit]
Description=zivpn VPN Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/etc/zivpn
ExecStart=/usr/local/bin/zivpn server -c /etc/zivpn/config.json
Restart=always
RestartSec=3
Environment=ZIVPN_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

IFS=',' read -r -a config_array <<< "$PASSWORDS"
if [ ${#config_array[@]} -eq 1 ]; then
    new_config_str="\"config\": [\"${config_array[0]}\"]"
else
    formatted_pass=$(printf "\"%s\"," "${config_array[@]}" | sed 's/,$//')
    new_config_str="\"config\": [$formatted_pass]"
fi

sed -i -E "s/\"config\": ?\[[[:space:]]*\"zi\"[[:space:]]*\]/${new_config_str}/g" /etc/zivpn/config.json
systemctl daemon-reload
systemctl enable zivpn.service
systemctl start zivpn.service

INTERFACE=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
iptables -t nat -A PREROUTING -i $INTERFACE -p udp --dport 6000:19999 -j DNAT --to-destination :5667
ufw allow 6000:19999/udp 1> /dev/null 2> /dev/null
ufw allow 5667/udp 1> /dev/null 2> /dev/null

rm zi.* 1> /dev/null 2> /dev/null
sleep 2