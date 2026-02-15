#!/bin/bash

rm -f ${0}
REPOS="https://raw.githubusercontent.com/dudul19/tomatosc/main/"

ns_domain_cloudflare() {
    DOMAIN="tomatovpn.my.id"
    DOMAIN_PATH=$(cat /etc/xray/domain)
	echo "☉———————————————————————————————————☉"
	echo "          • YOUR SUB DOMAIN •         "
	echo "☉———————————————————————————————————☉" 
    read -p "  Subdomain : " SUB
    if [ -z $SUB ]; then
    exit
    else
    SUB_DOMAIN=${SUB}."tomatovpn.my.id"
    NS_DOMAIN=dns.${SUB_DOMAIN}
    CF_ID=akmalcoeg19@gmail.com
        CF_KEY=2643e6e6ee9afb73bdc4f4d8742da31938c1c
    set -euo pipefail
    IP=$(wget -qO- ipinfo.io/ip)
    echo "Updating DNS NS for ${NS_DOMAIN}..."
    ZONE=$(
        curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
        -H "X-Auth-Email: ${CF_ID}" \
        -H "X-Auth-Key: ${CF_KEY}" \
        -H "Content-Type: application/json" | jq -r .result[0].id
    )

    RECORD=$(
        curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
        -H "X-Auth-Email: ${CF_ID}" \
        -H "X-Auth-Key: ${CF_KEY}" \
        -H "Content-Type: application/json" | jq -r .result[0].id
    )

    if [[ "${#RECORD}" -le 10 ]]; then
        RECORD=$(
            curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
            -H "X-Auth-Email: ${CF_ID}" \
            -H "X-Auth-Key: ${CF_KEY}" \
            -H "Content-Type: application/json" \
            --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DOMAIN_PATH}'","proxied":false}' | jq -r .result.id
        )
    fi

    RESULT=$(
        curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
        -H "X-Auth-Email: ${CF_ID}" \
        -H "X-Auth-Key: ${CF_KEY}" \
        -H "Content-Type: application/json" \
        --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DOMAIN_PATH}'","proxied":false}'
    )
    echo $NS_DOMAIN >/etc/xray/dns
    fi
}

setup_dnstt() {
    cd
    mkdir -p /etc/slowdns
    cd /etc/slowdns
    wget -O dnstt-server "${REPOS}slowdns/dnstt-server" >/dev/null 2>&1
    chmod +x dnstt-server >/dev/null 2>&1
    wget -O dnstt-client "${REPOS}slowdns/dnstt-client" >/dev/null 2>&1
    chmod +x dnstt-client >/dev/null 2>&1
    ./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
    chmod +x *
    cd
    wget -O /etc/systemd/system/client.service "${REPOS}slowdns/client" >/dev/null 2>&1
    wget -O /etc/systemd/system/server.service "${REPOS}slowdns/server" >/dev/null 2>&1
    sed -i "s/xxxx/$NS_DOMAIN/g" /etc/systemd/system/client.service 
    sed -i "s/xxxx/$NS_DOMAIN/g" /etc/systemd/system/server.service 
    systemctl daemon-reload
    systemctl restart server
    systemctl restart client
    systemctl enable server
    systemctl enable client
}

clear
ns_domain_cloudflare
setup_dnstt