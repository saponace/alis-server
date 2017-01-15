#-------------------------------------------------
# Configure web server
#-------------------------------------------------


${INSTALL} nginx

# Whitelist HTTP and HTTPS ports on the firewall
    ufw allow 80
    ufw allow 403
