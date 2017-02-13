
# Follow these steps to install a new alarm (Arch Linux for ARM) system

After burning the image to the raspberry pi sd card, log in as root and:

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
The system will reboot into the fresh install.

### Note
All the configs are stored in the editable file ./alis-erver.config
