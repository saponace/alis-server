# Follow these steps to install a new arch linux server

### Install git and clone this repo
```
# pacman -Syy git
# git clone --recursive https://github.com/saponace/alis-server
```

### Install the new system
```
# cd alis-server
# ./install.sh
```
The system will reboot


### Configure the new system
Log in as the user, and
```
# cd alis-server
# ./configure-system.sh
```
The system will reboot into the fresh install.

You can then call the following script to start the server:
```
/bin/startup
```
Once the services have started, you can manually configure the services that requires manual configuration. Follow
instructions detailed [here](documentation/services-and-setup-instructions.md).


### Note
- All configs are stored in the editable file ./alis-erver.config
- The first execution of the startup script is (very) slow because it will download all required docker images from the
  internet
- There will be config files generated in /mnt. If it is the first install, you might want to copy these files to the
  device that will be mounted to /mnt. If it is a reinstall, you can delete these files
- Further documentation (technical and functionnal) can be found [here](documentation/)
