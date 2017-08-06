#-------------------------------------------------
# Configure web server
#-------------------------------------------------


# Web Server
${INSTALL} nginx

# Whitelist HTTP and HTTPS ports on the firewall
    sudo ufw allow 80
    sudo ufw allow 443

# certbot - Let's encrypt client
    ${INSTALL} certbot-nginx
    # Custom service
        sudo systemctl enable certbot.timer
