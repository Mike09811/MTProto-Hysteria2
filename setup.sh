#!/bin/bash
set -e
echo Deploy
if [ "$EUID" -ne 0 ]; then echo run as root; exit 1; fi
command -v docker || { curl -fsSL https://get.docker.com | sh; }
BD=$(cd "$(dirname "$0")" && pwd)
mkdir -p $BD/certs $BD/mtproxy-data $BD/hy2-config
read -p "Domain: " DOMAIN
read -p "Hy2 pass: " HYPASS
SEC=$(head -c 16 /dev/urandom | xxd -p)
echo "Secret: $SEC"
certbot certonly --standalone -d $DOMAIN -n --agree-tos --register-unsafely-without-email
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem $BD/certs/
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $BD/certs/
echo $SEC > $BD/mtproxy-data/secret
cd $BD && docker compose up -d
echo Done
