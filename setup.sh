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
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem $BD/certs/
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $BD/certs/
sed -i "s|CHANGE_ME_HY2_PASSWORD|$HYPASS|g" $BD/hy2-config/config.yaml
sed -i "s|SECRET_COUNT=1|SECRET_COUNT=1\n      - SECRET=$SEC|g" $BD/docker-compose.yml
cd $BD
docker compose up -d
echo "===== Setup Complete ====="
echo "Domain: $DOMAIN"
echo "Hy2 Password: $HYPASS"
echo "MTProto Secret: $SEC"
echo "Telegram Proxy: 127.0.0.1:8443"
echo "MTProto Link: tg://proxy?server=127.0.0.1&port=8443&secret=$SEC"
