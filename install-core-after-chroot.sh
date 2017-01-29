#!/bin/bash

source ./alis-server.config


# Set the hostname
    echo  ${hostname} > /etc/hostname

# Set le locales and the keymap
    # Configure locales
        echo -e "\nfr_FR.UTF-8 UTF-8\nfr_FR ISO-8859-1\nfr_FR@euro ISO-8859-15\n" >> /etc/locale.gen
        echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" >> /etc/locale.gen
        locale-gen
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
    echo "KEYMAP=fr-latin1.map.gz" > /etc/vconsole.conf

# Set the clock
    hwclock --systohc --localtime


# Create ramdisk
    # Configure mkinitcpio
    mkinitcpio -p linux


# Install and configure boot manager
    pacman -S grub
    grub-install --target=i386-pc ${root_device}
    grub-mkconfig -o /boot/grub/grub.cfg


# Set root password
    echo Enter root password:
    passwd root


# Create the user and add him to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash ${username}
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    # Set user password
        echo Enter ${username} password:
        passwd ${username}


# Move the git repo into the user's home directory
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    mv ${git_repo_path} /home/${username}
    chown -R ${username}:${username} /home/${username}/

