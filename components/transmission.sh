#-------------------------------------------------
# Install transmission
#-------------------------------------------------

${INSTALL} transmission-cli

# Whitelist transmission RPC port on the firewall
    sudo ufw allow 9091

# Copy config file (I copy the file here because I can't manage to make transmission see the file when it's linked
    target_file="/var/lib/transmission/.config/transmission-daemon/settings.json"
    sudo cp -f "${ADDITIONAL_CONFIG_FILES_DIR}/other/transmission-daemon/settings.json" ${target_file}
    sudo chown transmission:transmission ${target_file}
