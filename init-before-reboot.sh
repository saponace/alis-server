#!/bin/bash

hostname=($1)
username=($2)
uefipart=($3)
rootpart=($4)

echo  $hostname > /etc/hostname
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
locale-gen
localectl set-keymap fr-latin1.map.gz
hwclock --systohc --localtime
#systemctl enable dhcpcd.service
mkinitcpio -p linux

# Boot manager
    pacman -S efibootmgr
    #umount /sys/firmware/efi/efivars
    #mount -t efivarfs efivarfs /sys/firmware/efi/efivars
    mount $uefipart /boot
    bootctl --path=/boot install
    #mkdir /boottemp
    #cp boot/{vmlinuz-linux,initramfs-linux.img} boottemp
    #mv boottemp/* boot/
    #rm -rf /boottemp
    echo -e "timeout=3\ndefault=arch" > /boot/loader/loader.conf
    rootpart_uuid=$(blkid $rootpart | cut -f2 -d\")
    echo -e "title  arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=UUID=$rootpart_uuid rw" > /boot/loader/entries/arch.conf



echo enter root password:
passwd root

# add the user to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash $username
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
echo enter $username password:
passwd $username

