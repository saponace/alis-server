loadkeys i386/azerty/fr-latin9.map.gz
cfdisk -> label type: dos


puis faire toutes les partitions
    -> /dev/sda5 : root
    -> /dev/sda6 : home
    -> /dev/sda7 : swap

mkfs.ext4 /dev/sd5
mkfs.ext4 /dev/sd6
mkswap /dev/sd7
mkdir /mnt/home
mount /dev/sda5 /mnt
mount /dev/sda6 /mnt/home
swapon /dev/sda7

pacstrap /mnt base base-devel


genfstab -p -L /mnt >> /mnt/etc/fstab

arch-chroot /mnt


vim /etc/locale.gen
    -> uncomment fr_FR... lines
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --localtime
echo  $hostname > /etc/hostname
systemctl enable dhcpcd.service
mkinitcpio -p linux
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
exit
