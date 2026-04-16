#!/bin/bash
cd /opt/mtproto-hy2

cat > docker-compose.yml << 'EOF'
version: "3.8"

services:
  mtproxy:
    image: telegrammessenger/proxy:latest
    container_name: mtproxy
    restart: always
    ports:
      - "127.0.0.1:8443:443"
    volumes:
      - ./mtproxy-data:/data
    environment:
      - SECRET=${SECRET}
    network_mode: host

  hysteria2:
    image: tobyxdd/hysteria:v2
    container_name: hysteria2
    restart: always
    ports:
      - "443:443/udp"
    volumes:
      - ./hy2-config:/etc/hysteria
      - ./certs:/certs
    command: ["server", "-c", "/etc/hysteria/config.yaml"]
    depends_on:
      - mtproxy
    network_mode: host
EOF

docker compose down
export SECRET=a69bdd6da811f43ea4b1be5822fddb0d
docker compose up -d
docker compose ps
docker compose logs --tail 20
