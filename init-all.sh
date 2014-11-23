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

}


insatllPackages(){

}

 # Oh My ZSH, ZSH config and plugin pack
installOhMyZsh(){
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh  # clone Oh my ZSH git repo
    sudo cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc   # copy .zshrc template file 
    sudo chsh -s /bin/zsh saponace                           # change default shell to ZSH
}



installWithCurl(){
    sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}




if [ $# -ne ... ]
then
	usage
	exit 1
fi


