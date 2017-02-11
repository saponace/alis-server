
# Follow these steps to install a new arch linux system

### Log in as root

### Set the keyboard layout to French
```
# loadkeys fr
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
