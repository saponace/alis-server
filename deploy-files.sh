#!/bin/bash

username=$1
usernameHome=(/home/$username)
otherConfigFilesDir="config-files/other"


if [ $# -ne 1 ]
then
    echo "Usage: $0 username"
    exit 1
fi



shopt -s dotglob #To be able to copy dotfiles

cp -R config-files/homedir/* $usernameHome
sudo cp $otherConfigFilesDir/slim.conf /etc/
sudo mkdir -p /usr/share/slim/themes/ && sudo cp -R $otherConfigFilesDir/slim-minimal/ /usr/share/slim/themes/ 

sudo cp scrpits/* /bin/
