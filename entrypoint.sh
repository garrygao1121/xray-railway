#!/bin/sh
set -eu
if [ -z "${UUID:-}" ]; then echo "ERROR: UUID env var is required" >&2; exit 1; fi
WS_PATH="${WS_PATH:-/vless}"
PORT="${PORT:-8080}"
printf '%s' '{"log":{"loglevel":"warning"},"inbounds":[{"port":'"$PORT"',"listen":"0.0.0.0","protocol":"vless","settings":{"clients":[{"id":"'"$UUID"'"}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"'"$WS_PATH"'"}}}],"outbounds":[{"protocol":"freedom","tag":"direct"}]}' > /etc/xray/config.json
exec /usr/local/bin/xray run -config /etc/xray/config.json
