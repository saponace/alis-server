
# Follow these steps to install a new arch linux

### Set the keyboard layout to French
```
# loadkeys fr
```

### Create partitions
Create partitions (at least root and swap)
Format theses partions (mkfs.ext4 and mkswap)

If no boot partition already exist, also create a boot partition of type EFI FILESYSTEM and `mkfs.vfat -F 32` this partition.


### Mount the partitions
Mount at /mnt and swapon, (do not forget to mount the boot partition on /mnt/boot, create directories if needed)


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
# cd dotfiles
# ./install-core.sh $hostname $username $boot_partition $linux_root_partition
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
Log in as the user, and
```
# cd dotfiles
# ./configure-system.sh
```
