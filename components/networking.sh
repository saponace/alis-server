#-------------------------------------------------
# Configure networking
#-------------------------------------------------



# Utils package. Notably includes `hostname` tool
    install_package inetutils

# Link system resolv.cponf to systemd's resolv.conf
    sudo rm /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
    sudo systemctl start systemd-resolved  # Required to keep being able to resolve domain names after this point




# Configure static local IP address for first ethernet interface
    network_config_file="/etc/systemd/network/10-static-interface.network"

    if [ -z network_interface ]
    then
        sudo systemctl start systemd-networkd
        network_interface=$(networkctl list --no-legend | grep ether | head -1 | awk -F' ' '{print $2}')
        echo "Networking configured for interface ${network_interface}. If you want to use another interface, edit ${network_config_file}"
    fi

    sudo su -c "echo '[Match]
Name=${network_interface}
[Network]
Address=${static_ip_address}
Gateway=${lan_gateway_ip_address}
DNS=${dns_server_ip_address}
' > ${network_config_file}"

# Prevent systemd-resolved from binding to port 53 (or else, it prevents pihole from starting)
    sudo su -c "echo 'DNSStubListener=no' >> /etc/systemd/resolved.conf"

# Enabble networking and resolving daemons
    sudo systemctl enable systemd-networkd
    sudo systemctl enable systemd-resolved
