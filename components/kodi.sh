#-------------------------------------------------
# InstallKodi media center
#-------------------------------------------------


# Install the package
    ${INSTALL} kodi-rbp-git

# Enable RPC
    kodi_config_file_path="/var/lib/kodi/.kodi/userdata/guisettings.xml"
    sudo sed -i 's|<esallinterfaces default="true">false</esallinterfaces>|<esallinterfaces>true</esallinterfaces>|g' ${kodi_config_file_path}
    sudo sed -i 's|<webserver default="true">false</webserver>|<webserver>true</webserver>|g' ${kodi_config_file_path}


# Whitelist kodi RPC port on the firewall
    ufw allow 8080
