
# Follow these steps to install a new arch linux system

### Set the keyboard layout to French
```
# loadkeys fr
```

### Create partitions
Create partitions grub (1MB, type:ef02), swap, root (with fdisk for instance).


### Remount archiso with more space to be able to download and install git
```
# mount -o remount,size=2G /run/archiso/cowspace
```

### Install git and clone this repo
```
# pacman -Syy git
# git clone --recursive https://github.com/saponace/alis-server.git
```

### Install the new system
```
# cd alis-server
# ./install.sh $hostname $username $disk_device $swap_partition_number $root_partition_number
```
Example:
```
# ./install.sh tartiflette saponace /dev/sda 2 3
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
# cd alis-server
# ./configure-system.sh $authorized_keys_filepath
```
Where $authorized_keys_filepath is the path to an authorized_keys ssh file to deploy to the server

