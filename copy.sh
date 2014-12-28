#
#file: copy.sh.sh
#date: Sun Nov 23 00:40:25 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash


usage(){
    echo "Usage: $0 deploy|backup"
}



deploy(){
    if [ retval != 0 ]
    then
        cp .vimrc.local $HOME
        cp .vimrc.bundles.local $HOME
        cp .Xdefaults $HOME
        cp .zshrc $HOME
        cp -r .zsh $HOME
        cp -r .i3 $HOME
        cp mc/ini $HOME/.config/mc/
        cp .tmux.conf $HOME
        cp transmission-remote-cli/settings.cfg $HOME/.config/transmission-remote-cli/
        cp .xinitrc $HOME
        cp .xbindkeysrc $HOME
        cp .i3status.conf $HOME

        #cp slim.conf /etc/
        #cp -r slim-minimal/ /usr/share/slim/themes/ 
        cp mc/gotar.ini /usr/share/mc/skins/ 
    fi
    echo "successfully deployed files"
}



backup(){
        cp $HOME/.vimrc.local .
        cp $HOME/.vimrc.bundles.local .
        cp $HOME/.Xdefaults .
        cp $HOME/.zshrc .
        cp -r $HOME/.zsh .
        cp -r $HOME/.i3 .
        #cp $HOME/.config/mc/ini mc/
        cp $HOME/.tmux.conf .
        cp $HOME/.config/transmission-remote-cli/settings.cfg transmission-remote-cli/
        cp $HOME/.xinitrc .
        cp $HOME/.xbindkeysrc . 
        cp $HOME/.i3status.conf .

        cp /etc/slim.conf slim.conf
        #cp -r /usr/share/slim/themes/slim-minimal/ slim-minimal/ 
        cp /usr/share/mc/skins/gotar.ini mc/ 

    echo "successfully backed files in this folder"
}



if [ $# -ne 1 ]
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

