#-------------------------------------------------
# Automated media download
#-------------------------------------------------


# Sonarr: automated TV shows download
    ${INSTALL} sonarr

# Sonarr: automated TV shows download
    ${INSTALL} radarr

# Jackett: tracker proxy for sonarr and radarr
    ${INSTALL} jackett
    jackett_config_dir="/usr/share/Jackett/.config/Jackett"

# Whitelist web UIs ports on the firewall
# Disabled since all traffic goes trough nginx reverse proxy
    # sudo ufw allow 8989  # Sonarr
    # sudo ufw allow 7878  # Radarr
    # sudo ufw allow 9117  # Jackett

# Add systemd services users to "video" group
    sudo usermod -a -G video sonarr
    sudo usermod -a -G video radarr

# Link persistant config directories
    create_directory_symlink  ${sonarr_persistant_config_dir} "/var/lib/sonarr"
    create_directory_symlink  ${radarr_persistant_config_dir} "/var/lib/radarr"
    create_directory_symlink  ${jackett_persistant_config_dir} "${jackett_config_dir}"

# Create Jackett dynamic config dir
    sudo mkdir "${jackett_config_dir}/.mono"
    sudo chown jackett:jackett "${jackett_config_dir}/.mono/"
