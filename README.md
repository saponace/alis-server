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
The system will reboot into a fresh install.

Systemd service `server-apps-suite` handles startup of all components. It is enabled

Once the services have started, you can manually configure the services that requires manual configuration. Follow
instructions detailed [here](documentation/services-and-setup-instructions.md).


### Notes
- All configs are stored in the editable file ./alis-server.config
- There will be config files generated in /mnt. If it is the first install, you might want to copy these files to the
  device that will be mounted to /mnt. If it is a reinstall, you can delete these files
- Further documentation (technical and functionnal) can be found [here](documentation/)
