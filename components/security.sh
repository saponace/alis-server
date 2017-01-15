#-------------------------------------------------
# Configure security settings
# Has to be called before any component calling ufw
#-------------------------------------------------


# Install firewall
    ${INSTALL} ufw
# Enable the firewall
   ufw enable
   systemctl enable ufw.service
