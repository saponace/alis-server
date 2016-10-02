#-------------------------------------------------
# Install an AUR helper
# Here, yaourt
#-------------------------------------------------


su -c "echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
sudo pacman -Syu yaourt
