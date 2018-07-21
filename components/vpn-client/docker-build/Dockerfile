FROM alpine
LABEL "Maintainer"="Scott Hansen <firecat4153@gmail.com>"

# Install openvpn
RUN apk --no-cache --no-progress add curl wget unzip openvpn && \
    printf '#!/usr/bin/env sh\n/usr/local/bin/port_forward.sh &\n' > /usr/local/bin/up.sh && \
    chmod +x /usr/local/bin/up.sh && \
    wget https://www.privateinternetaccess.com/openvpn/openvpn.zip -P tmp/ && \
    mkdir /config && \
    unzip /tmp/openvpn.zip -d /config && \
    sed -i 's/auth-user-pass.*/auth-user-pass credentials/' /config/*.ovpn && \
    rm -rf /tmp/*

ENV REGION="France"

COPY port_forward.sh /usr/local/bin/port_forward.sh

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -L 'https://api.ipify.org'

VOLUME ["/config/credentials"]

ENTRYPOINT  openvpn \
            --cd /config \
            --config /config/${REGION}.ovpn \
            --inactive 3600 \
            --keepalive 10 60 \
            --route-delay 2 \
            --route-up "/sbin/ip route del default" \
            --script-security 2 \
            --up /usr/local/bin/up.sh \
            --up-delay
