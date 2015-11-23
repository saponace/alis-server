#!/bin/bash

hostname=$1
username=$2
uefi_part=$3
root_part=$4



# Set the hostname
    echo  ${hostname} > /etc/hostname


# Set le locales and the keymap
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
    locale-gen
    echo "KEYMAP=fr-latin1.map.gz" > /etc/vconsole.conf


# Set the clock
    hwclock --systohc --localtime


# Create ramdisk
    mkinitcpio -p linux


# Configure boot manager
    pacman -S efibootmgr
    mount ${uefi_part} /boot
    bootctl --path=/boot install

    echo -e "timeout=3\ndefault=arch" > /boot/loader/loader.conf
    root_part_uuid=$(blkid ${root_part} | cut -f2 -d\")
    echo -e "title  arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=UUID=$root_part_uuid rw" > /boot/loader/entries/arch.conf


# Set root password
    echo Enter root password:
    passwd root


# add the user to wheel group (sudoers)
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
