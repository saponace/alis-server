
# Follow these steps to install a new arch linux system

### Set the keyboard layout to French
```
# loadkeys fr
```

### Create partitions
Create partitions boot, swap and root (with fdisk for instance).


### Remount archiso with more space to be able to download and install git
mount -o remount,size=2G /run/archiso/cowspace

### Clone this repo
git clone https://github.com/saponace/alis.git

### Install the new system
```
# cd alis
# ./install-core.sh $hostname $username $boot_partition $swap_partition $root_partition
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
# cd alis
# ./configure-system.sh
```
