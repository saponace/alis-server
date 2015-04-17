#
#file: copy.sh.sh
#date: Sun Nov 23 00:40:25 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash


usage(){
    echo "Usage: $0 deploy|backup username"
}

username=$2
usernameHome=(/home/$username)


deploy(){
    if [ retval != 0 ]
    then
        cp .vimrc.local $usernameHome
        cp .vimrc.bundles.local $usernameHome
        cp .Xresources $usernameHome
        cp .zshrc $usernameHome
        cp -r .zsh $usernameHome
        cp -r awesome $usernameHome/.config
        cp ranger.conf $usernameHome/.config/ranger/
        cp mpd.conf $usernameHome/.config/mpd/
        cp .tmux.conf $usernameHome
        cp transmission-remote-cli.cfg $usernameHome/.config/transmission-remote-cli/settings.cfg
        cp .xinitrc $usernameHome

        sudo cp slim.conf /etc/
        sudo cp -r slim-minimal/ /usr/share/slim/themes/ 
    fi
    echo "successfully deployed files"
}



backup(){
        cp $usernameHome/.vimrc.local .
        cp $usernameHome/.vimrc.bundles.local .
        cp $usernameHome/.Xresources .
        cp $usernameHome/.zshrc .
        cp -r $usernameHome/.zsh .
        cp -r $usernameHome/.config/awesome .
        cp $usernameHome/.config/ranger/rc.conf ranger.conf
        cp $usernameHome/.config/mpd/mpd.conf .
        cp $usernameHome/.tmux.conf .
        cp $usernameHome/.config/transmission-remote-cli/settings.cfg transmission-remote-cli.cfg
        cp $usernameHome/.xinitrc .

        cp /etc/slim.conf slim.conf
        #cp -r /usr/share/slim/themes/slim-minimal/ slim-minimal/ 

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

