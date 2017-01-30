#-------------------------------------------------
# Configure networking
#-------------------------------------------------


# Link system resolv.cponf to systemd's resolv.conf
    sudo rm /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Configure static address
sudo su -c "echo '[Match]
Name=${network_interface_name}
[Network]
Address=${static_ip_address}
Gateway=${lan_gateway_ip_address}
DNS=${dns_server_ip_address}
' >> /etc/systemd/network/10-static-interface.network"

# Enabble networking and resolving daemons
    sudo systemctl enable systemd-networkd
    sudo systemctl start systemd-networkd
    sudo systemctl enable systemd-resolved
    sudo systemctl start systemd-resolved


# Activate Wake On Lan
    ${INSTALL} wol-systemd
    sudo systemctl enable wol@${network_interface_name}.service