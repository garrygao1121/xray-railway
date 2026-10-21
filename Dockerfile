FROM alpine:3.21
RUN apk add --no-cache ca-certificates curl unzip \
 && mkdir -p /usr/local/bin /etc/xray \
 && VER="$(curl -fsSL https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep -o '"tag_name": *"[^"]*"' | head -n1 | cut -d'"' -f4)" \
 && echo "Installing Xray ${VER}" \
 && curl -fsSL -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${VER}/Xray-linux-64.zip" \
 && unzip -o /tmp/xray.zip -d /usr/local/bin xray \
 && chmod +x /usr/local/bin/xray \
 && rm -f /tmp/xray.zip \
 && /usr/local/bin/xray version
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]

