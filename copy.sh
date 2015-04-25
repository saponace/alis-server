#
#file: copy.sh.sh
#date: Sun Nov 23 00:40:25 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash


function cp-parents {
  if [ ! -d "$2" ]; then
	mkdir -p "$2"
  fi
  cp -R "$1" "$2"
}


usage(){
    echo "Usage: $0 deploy|backup username"
}

username=$2
usernameHome=(/home/$username)


deploy(){
    if [ retval != 0 ]
    then
        cp-parents .vimrc.local $usernameHome
        cp-parents .vimrc.bundles.local $usernameHome
        cp-parents .Xresources $usernameHome
        cp-parents .zshrc $usernameHome
        cp-parents .zsh $usernameHome
        cp-parents awesome $usernameHome/.config
        cp-parents ranger.conf $usernameHome/.config/ranger/
        cp-parents mpd.conf $usernameHome/.config/mpd/
        cp-parents .tmux.conf $usernameHome
        cp-parents transmission-remote-cli.cfg $usernameHome/.config/transmission-remote-cli/settings.cfg
        cp-parents .xinitrc $usernameHome

        sudo cp slim.conf /etc/
        #sudo mkdir -p /usr/share/slim/themes/ && sudo cp -R slim-minimal/ /usr/share/slim/themes/ 
    fi
    echo "successfully deployed files"
}



backup(){
        cp-parents $usernameHome/.vimrc.local .
        cp-parents $usernameHome/.vimrc.bundles.local .
        cp-parents $usernameHome/.Xresources .
        cp-parents $usernameHome/.zshrc .
        cp-parents $usernameHome/.zsh .
        cp-parents $usernameHome/.config/awesome .
        cp-parents $usernameHome/.config/ranger/rc.conf ranger.conf
        cp-parents $usernameHome/.config/mpd/mpd.conf .
        cp-parents $usernameHome/.tmux.conf .
        cp-parents $usernameHome/.config/transmission-remote-cli/settings.cfg transmission-remote-cli.cfg
        cp-parents $usernameHome/.xinitrc .

        cp-parents /etc/slim.conf slim.conf
        #cp-parents /usr/share/slim/themes/slim-minimal/ slim-minimal/ 

    echo "successfully backed files in this folder"
}



if [ $# -ne 2 ]
then
    usage
    exit 1
fi

case $1 in
    "deploy")
        deploy
        ;;
    "backup")
        backup;
        ;;
    *)
        usage
        exit 1
        ;;
esac

