#!/bin/bash
set -e
echo "MTProxy+Hy2 Deploy"
if [ "$EUID" -ne 0 ]; then echo "run as root"; exit 1; fi
command -v docker > /dev/null || { curl -fsSL https://get.docker.com | sh; }
apt-get install -y certbot git 2>/dev/null || yum install -y certbot git 2>/dev/null || true
BD=/opt/mtproto-hy2
rm -rf $BD
git clone https://github.com/Mike09811/MTProto-Hysteria2.git $BD
cd $BD
mkdir -p $BD/certs $BD/mtproxy-data $BD/hy2-config
read -p "Domain: " DOMAIN
read -p "Hy2 pass: " HYPASS
SEC=$(openssl rand -hex 16)
echo "Secret: $SEC"
certbot certonly --standalone -d $DOMAIN -n --agree-tos --register-unsafely-without-email
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem certs/
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem certs/
