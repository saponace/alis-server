#-------------------------------------------------
# Install an AUR helper
# Here, yaourt
#-------------------------------------------------


# Yaourt
    sudo pacman -S wget
    mkdir /tmp/build
    cd /tmp/build && wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
    tar -vzxf yaourt.tar.gz
    cd yaourt
    makepkg -s
    sudo pacman -U *tar.xz

# Yaourt packages tab completion
    ${INSTALL} aurtab

