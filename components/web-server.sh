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
    # Custom service to renew certificate
        sudo su -c "echo '[Unit]
Description=Lets Encrypt renewal
[Service]
Type=oneshot
ExecStart=/usr/bin/certbot renew --quiet --agree-tos
ExecStartPost=/bin/systemctl reload nginx.service' > /etc/systemd/system/certbot.service"
        sudo su -c "echo '[Unit]
Description=Twice daily renewal of Lets Encrypts certificates
[Timer]
OnCalendar=0/12:00:00
RandomizedDelaySec=1h
Persistent=true
[Install]
WantedBy=timers.target' > /etc/systemd/system/certbot.timer"
        sudo systemctl enable certbot.timer
    # Link config directory
        create_directory_symlink  ${letsencrypt_persistant_config_dir} "/etc/letsencrypt"
