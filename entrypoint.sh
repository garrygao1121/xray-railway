#!/bin/sh
set -eu
if [ -z "${UUID:-}" ]; then echo "ERROR: UUID env var is required" >&2; exit 1; fi
WS_PATH="${WS_PATH:-/vless}"
PORT="${PORT:-8080}"
cat > /etc/xray/config.json <<'JSON'
{
"inbounds": [{"port": __PORT__, "listen": "0.0.0.0", "protocol": "vless", "settings": {"clients": [{"id": "__UUID__"}], "decryption": "none"}, "streamSettings": {"network": "ws", "wsSettings": {"path": "__WS_PATH__"}}}],
"outbounds": [{"protocol": "freedom", "tag": "direct"}]
}
JSON
sed -i "s/__PORT__/${PORT}/; s/__UUID__/${UUID}/; s#__WS_PATH__#${WS_PATH}#" /etc/xray/config.json
exec /usr/local/bin/xray run -config /etc/xray/config.json
