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


# Configure VPN (auto generate OpenVPN config files for VPN Private Internet Access)
    ${INSTALL} openvpn
    ${INSTALL} private-internet-access-vpn
    # Write credentials in a file
        vpn_credentials_file="etc/private-internet-access/login.conf"
        sudo echo ${vpn_login} > ${vpn_credentials_file}
        sudo echo ${vpn_password} >> ${vpn_credentials_file}
        sudo chown root:root ${vpn_credentials_file}
        sudo chmod 600 ${vpn_credentials_file}
    # Create OpenVPN config files
        sudo pia -a
    # Enable OpenVPN
    # TODO: enable OpenVPN
