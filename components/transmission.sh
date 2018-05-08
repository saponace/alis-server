#-------------------------------------------------
# Install transmission
#-------------------------------------------------

${INSTALL} transmission-cli

# Whitelist transmission RPC port on the firewall
# Disabled since all traffic goes trough nginx reverse proxy
    # sudo ufw allow 9091

# Copy config file (I copy the file here because I can't manage to make transmission see the file when it's linked
    target_dir="/var/lib/transmission/.config/transmission-daemon"
    target_file=${target_dir}"/settings.json"
    sudo mkdir -p  ${target_dir}
    sudo cp -f "${ADDITIONAL_CONFIG_FILES_DIR}/other/transmission-daemon/settings.json" ${target_file}
    sudo chown transmission:transmission ${target_file}
