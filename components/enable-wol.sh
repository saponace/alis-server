#-------------------------------------------------
# Enable Wake On Lan functionnality
#-------------------------------------------------


${INSTALL} wol-systemd
sudo systemctl enable wol@${network_interface_name}.service
