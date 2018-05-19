#-------------------------------------------------
# Configure VPN
#-------------------------------------------------


# ${INSTALL} openvpn
# Auto generate OpenVPN config files for VPN Private Internet Access (pia)
    # ${INSTALL} pia-tools
    sudo su -c "echo '${vpn_login}\n${vpn_password}' | pia-tools --setup"


# # # Block non-VPN traffic. Works in conjunction with ufw
# #     sudo pia-tools --disallow
# # Enable OpenVPN, the config file is one of the config files generated by pia-tools
#     sudo systemctl enable pia@France
# # Update openVPN config files
#     sudo systemctl start pia-tools-update.timer
# # Custom service to stop transmission when connection to the VPN is lost
#     create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/pia-tools-check.service" "/etc/systemd/system/"
#     create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/pia-tools-check.timer" "/etc/systemd/system/"
#     sudo systemctl enable pia-tools-check.timer

# # Link pia-tools config file
#     create_link ${ADDITIONAL_CONFIG_FILES_DIR}/other/pia-tools.conf /etc/
