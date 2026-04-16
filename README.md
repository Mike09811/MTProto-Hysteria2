# MTProto-Hysteria2

Telegram MTProxy + Hysteria2 结合代理，QUIC 隧道抗检测。

## 架构

```
Telegram -> Hy2客户端(本地) -> QUIC隧道(UDP:443) -> Hy2服务端(VPS) -> MTProxy -> Telegram
```

对外只暴露 UDP:443，MTProxy 完全隐藏在 Hy2 隧道后面。

## 一键安装

bash <(curl -fsSL https://raw.githubusercontent.com/Mike09811/MTProto-Hysteria2/main/setup.sh)

## 客户端

1. 安装 Hysteria2
2. 编辑 hy2-client-config.yaml 填入服务器信息
3. 运行 hysteria -c hy2-client-config.yaml
4. Telegram 设置 MTProxy: 127.0.0.1:8443

## 要求

- VPS + 域名 + 443/udp 端口开放
