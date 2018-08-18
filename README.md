
# Follow these steps to install a new arch linux server

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
# ./install.sh
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
# ./configure-system.sh
```

### Reboot
```
# reboot
```

### Note
All the configs are stored in the editable file ./alis-erver.config
