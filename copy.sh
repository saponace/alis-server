#
#file: copy.sh.sh
#date: Sun Nov 23 00:40:25 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash


function cpparents {
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
        cpparents .vimrc.local $usernameHome
        cpparents .vimrc.bundles.local $usernameHome
        cpparents .Xresources $usernameHome
        cpparents .zshrc $usernameHome
        cpparents .zsh $usernameHome
        cpparents awesome $usernameHome/.config
        cpparents ranger.conf $usernameHome/.config/ranger/rc.conf
        cpparents mpd.conf $usernameHome/.config/mpd/
        cpparents .tmux.conf $usernameHome
        cpparents transmission-remote-cli.cfg $usernameHome/.config/transmission-remote-cli/settings.cfg
        cpparents .xinitrc $usernameHome

        sudo cp slim.conf /etc/
        sudo mkdir -p /usr/share/slim/themes/ && sudo cp -R slim-minimal/ /usr/share/slim/themes/ 
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
    #cpparents /usr/share/slim/themes/slim-minimal/ slim-minimal/ 

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

