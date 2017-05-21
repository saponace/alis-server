#-------------------------------------------------
# Configure web server
#-------------------------------------------------


${INSTALL} nginx

# Enable nginx
    sudo systemctl enable nginx

# Whitelist HTTP and HTTPS ports on the firewall
    sudo ufw allow 80
    sudo ufw allow 443
