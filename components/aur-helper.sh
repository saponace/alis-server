#-------------------------------------------------
# Install an AUR helper
# Here, yaourt
#-------------------------------------------------


# Yaourt
    su -c "echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
    ${INSTALL_PACMAN} yaourt

# Yaourt packages tab completion
    ${INSTALL} aurtab

