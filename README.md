# MTProto-Hysteria2

MTProxy + Hysteria2 combined proxy for Telegram.

## Architecture

```
Telegram -> Hy2 Client (local:8443) -> QUIC tunnel -> Hy2 Server -> MTProxy -> Telegram
```

## Deploy

```bash
chmod +x setup.sh && sudo ./setup.sh
```

## Client

1. Install hysteria2
2. Edit hy2-client-config.yaml
3. Run: hysteria -c hy2-client-config.yaml
4. Telegram MTProxy: 127.0.0.1:8443

## Requirements

- VPS + domain + port 443/udp open
