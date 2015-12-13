
# Follow these steps to install a new arch linux

### Set the keyboard layout to French
```
# loadkeys fr
```

### Create partitions
Create partitions (at least root and swap)
If no boot partition already exist, also create a boot partition of type EFI FILESYSTEM and `mkfs.vfat -F 32` this partition.  
Format theses partions (mkfs.ext4 and mkswap)


### Mount the partitions
Mount at /mnt and swapon, (do not forget to mount /boot in /mnt/boot, create directories if needed)


### Prepare the new system before chrooting
 ```
    # pacstrap /mnt base base-devel
    # genfstab -p -L /mnt >> /mnt/etc/fstab
```

### Chroot into the new system
```
# arch-chroot /mnt
```


### Install the new system
```
# vi /etc/locale.gen
```
Uncomment the locales you are interested in. Then: 

```
# pacman -Syu git
# git clone https://github.com/saponace/dotfiles.git
# install-core.sh $hostname $username $boot_partition $linux_root_partition
        (where $boot_partition and $linux_root_partition are formed like /dev/sdaX)
```

### Reboot
```
# exit
```
Umount and swapoff partitions
```
# reboot
```

### Configure the new system
Log as root, and
```
# cd /home/$user/dotfiles
# ./configure-system.sh $username
```
