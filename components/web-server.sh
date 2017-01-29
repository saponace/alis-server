#-------------------------------------------------
# Configure web server
#-------------------------------------------------


${INSTALL} nginx

# Whitelist HTTP and HTTPS ports on the firewall
    sudo ufw allow 80
    sudo ufw allow 403
