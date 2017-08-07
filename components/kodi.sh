#-------------------------------------------------
# Install Kodi media center
#-------------------------------------------------


# Install the package
    ${INSTALL} kodi-rbp-git

# Whitelist kodi RPC port on the firewall
    sudo ufw allow 8080


# Create config files scafold by starting the application, and then stop it
    sudo systemctl start kodi
    sleep 20
    sudo systemctl stop kodi

    # Link config directory
        create_directory_symlink  ${kodi_persistant_config_dir} "/var/lib/kodi/.kodi"
