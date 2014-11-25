#
#file: copy.sh.sh
#date: Sun Nov 23 00:40:25 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash




gitStatus(){
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    BASE=$(git merge-base @ @{u})

    if [ $LOCAL = $REMOTE ]; then
        retval = 0
    elif [ $LOCAL = $BASE ]; then
        echo "Local copy of repo too old, need to pull."
        retval = 1
    elif [ $REMOTE = $BASE ]; then
        echo "Local modification commited, need to push"
        retval = 2
    else
        echo "Diverged"
        retval = 3
    fi
}



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
        cp -r .i3 $HOME
        cp .xinitrc $HOME

        #cp slim.conf /etc/
        #cp -r slim-minimal/ /usr/share/slim/themes/ 
    fi
    echo "successfully deployed files"
}

backup(){
        cp $HOME/.vimrc.local .
        cp $HOME/.vimrc.bundles.local .
        cp $HOME/.Xdefaults .
        cp $HOME/.zshrc .
        cp -r $HOME/.i3 .
        cp $HOME/.xinitrc .

        cp /etc/slim.conf slim.conf
        #cp -r /usr/share/slim/themes/slim-minimal/ slim-minimal/ 
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

