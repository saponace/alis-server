#-------------------------------------------------
# Configure web server
#-------------------------------------------------


# Web Server
    ${INSTALL} nginx
    # Link nginx config file
        create_link ${ADDITIONAL_CONFIG_FILES_DIR}/other/nginx.conf /etc/nginx/

# Whitelist HTTP and HTTPS ports on the firewall
    sudo ufw allow 80
    sudo ufw allow 443

# certbot - Let's encrypt client
    ${INSTALL} certbot-nginx
    # Custom service to renew certificate
    create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/certbot.service" "/etc/systemd/system/"
    create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/certbot.timer" "/etc/systemd/system/"
    sudo systemctl enable certbot.timer
    # Link config directory
        create_directory_symlink  ${letsencrypt_persistant_config_dir} "/etc/letsencrypt"
