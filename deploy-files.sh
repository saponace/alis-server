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

cp $otherConfigFilesDir/slim/slim.conf /etc/
mkdir -p /usr/share/slim/themes/ && cp -R $otherConfigFilesDir/slim/slim-minimal/ /usr/share/slim/themes/ 
mkdir -p /usr/share/gtk-3.0/ && cp -R $otherConfigFilesDir/gtk-theme/settings.ini /usr/share/gtk-3.0/

cp scripts/* /bin/
