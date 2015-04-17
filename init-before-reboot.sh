#!/bin/bash

hostname=($1)

echo  $hostname > /etc/hostname
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
locale-gen
hwclock --systohc --localtime
systemctl enable dhcpcd.service
mkinitcpio -p linux
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

