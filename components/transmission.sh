#-------------------------------------------------
# Install transmission
#-------------------------------------------------

${INSTALL} transmission-cli

# Whitelist transmission RPC port on the firewall
    sudo ufw allow 9091

# Link config file
    config_dir="${ADDITIONAL_CONFIG_FILES_DIR}/other/transmission-daemon"
    create_link ${config_dir} /var/lib/transmission/.config/
    sudo chown -R transmission:transmission ${config_dir}
