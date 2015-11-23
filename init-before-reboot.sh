#!/bin/bash

hostname=($1)
username=($2)
uefipart=($3)
rootpart=($4)

echo  $hostname > /etc/hostname
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
locale-gen
echo "KEYMAP=fr-latin1.map.gz" > /etc/vconsole.conf
hwclock --systohc --localtime
mkinitcpio -p linux

# Boot manager
    pacman -S efibootmgr
    mount $uefipart /boot
    bootctl --path=/boot install

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

