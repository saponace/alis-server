#-------------------------------------------------
# Install and configure virtualbox
#-------------------------------------------------


# Install virtualbox
    ${INSTALL} virtualbox
# Install required modules for virtualbox
    ${INSTALL} virtualbox-host-dkms
# Enable virtualbox driver module
    sudo modprobe vboxdrv
