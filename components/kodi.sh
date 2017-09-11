#-------------------------------------------------
# Install Kodi media center
#-------------------------------------------------


# Install the package
    ${INSTALL} kodi-rbp-git

# Whitelist kodi RPC port on the firewall
# Disabled since all traffic goes trough nginx reverse proxy
    # sudo ufw allow 8080

# Link config directory
    create_directory_symlink  ${kodi_persistant_config_dir} "/var/lib/kodi/.kodi"
