#!/bin/bash

hostname=($1)
username=($2)

echo  $hostname > /etc/hostname
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
locale-gen
localectl set-keymap fr-latin1.map.gz
hwclock --systohc --localtime
systemctl enable dhcpcd.service
mkinitcpio -p linux
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo enter root password:
passwd root

# add the user to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash $username
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    echo enter $username password:
    passwd $username

