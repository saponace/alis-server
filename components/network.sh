#-------------------------------------------------
# Enable networking and install/configure networking related programs
#-------------------------------------------------


# Enable dhcpcd
enable_networking(){
    echo "Enabling networking ..."
    sudo dhcpcd
    while [ "$var1" != "end" ]
    do
        pingtime=$(ping -w 1 google.com | grep ttl)
        if [ "$pingtime" = "" ]
        then
            sleep 2
        else
            break
        fi
    done
    echo "Done !"
}

# Install Networkmanager packages
install_networkmanager(){
    # To access network state without root privileges
        ${INSTALL} wpa_supplicant
    # Network manager
        ${INSTALL} networkmanager
    # NetworkManager tray icon
        ${INSTALL} network-manager-applet gnome-keyring gnome-icon-theme
}

# Configure Networkmanager
configure_networkmanager(){
    # Enable network manager
        sudo systemctl enable NetworkManager.service
    # Disable ipv6 in dhcpcd.conf
        su -c "echo -e 'noipv6rs\nnoipv6' >> /etc/dhcpcd.conf"
}


enable_networking
install_networkmanager
configure_networkmanager
