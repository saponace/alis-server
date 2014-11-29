#
#file: init-all.sh
#date: Sun Nov 23 02:31:11 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash

usage(){
	echo "Usage: $0 ..."
}



intallYaourt(){
    echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
    pacman -Sy yaourt
}


insatllPackages(){

}

sudo chsh -s /bin/zsh saponace                           # change default shell to ZSH



installSpf13(){
    sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}




if [ $# -ne ... ]
then
	usage
	exit 1
fi


