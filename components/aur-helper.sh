#-------------------------------------------------
# Install an AUR helper
# Here, yaourt
#-------------------------------------------------


# Yaourt
    sudo su -c "echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
    sudo pacman -Syu --noconfirm yaourt

# Yaourt packages tab completion
    ${INSTALL} aurtab

