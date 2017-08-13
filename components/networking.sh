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


# Configure VPN
    ${INSTALL} openvpn
    # Auto generate OpenVPN config files for VPN Private Internet Access (pia)
        ${INSTALL} fakeroot  # Is required by pia to install, but not listed as a dependency
        ${INSTALL} private-internet-access-vpn
        # Write credentials in a file
            vpn_credentials_file="/etc/private-internet-access/login.conf"
            sudo su -c "echo ${vpn_login} > ${vpn_credentials_file}"
            sudo su -c "echo ${vpn_password} >> ${vpn_credentials_file}"
            sudo chown root:root ${vpn_credentials_file}
            sudo chmod 0600 ${vpn_credentials_file}
        # Create OpenVPN config files for pia
            sudo pia -a
        # Reaload systemd unit files, so that OpenVPN can detect files generated by pia
            sudo systemctl daemon-reload
    # Enable OpenVPN, the config file is one of the config files generated by pia
        sudo systemctl enable openvpn-client@France

