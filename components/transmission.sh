#-------------------------------------------------
# Install transmission
#-------------------------------------------------

${INSTALL} transmission-cli

# Disable transmission daemon service
    update-rc.d transmission-daemon disable
# Whitelist transmission RPC port on the firewall
    sudo ufw allow 9091

# Make transmission detect config file
    transmission-remote-cli --create-config
