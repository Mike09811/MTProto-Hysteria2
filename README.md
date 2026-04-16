# MTProto-Hysteria2

[English](#english) | [中文](#中文)

---

## English

MTProxy + Hysteria2 combined proxy for Telegram. Anti-detection via QUIC.

### Architecture

Telegram -> Hy2Client(local) -> QUIC(UDP443) -> Hy2Server -> MTProxy -> TG

Only UDP:443 exposed. MTProxy completely hidden.

### Deploy

chmod +x setup.sh and sudo ./setup.sh

### Client

1. Install Hysteria2
2. Edit hy2-client-config.yaml
3. Run: hysteria -c hy2-client-config.yaml
4. Telegram MTProxy: 127.0.0.1:8443

### Requirements

VPS + domain + port 443/udp open

---

## 中文

MTProxy+Hysteria2 结合代理

### 部署

sudo ./setup.sh

### 客户端

1. 安装 Hysteria2
2. 编辑 hy2-client-config.yaml
3. 运行 hysteria
4. Telegram 设置 MTProxy 127.0.0.1:8443
