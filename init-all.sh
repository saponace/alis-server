#
#file: init-all.sh
#date: Sun Nov 23 02:31:11 CET 2014
#author: saponace </var/mail/saponace>
#description:
#

#!/bin/bash

PA = pacman -S

usage(){
	echo "Usage: $0 ..."
}


all(){
    installYaourt()
    installSpf13()
    installApache()
    installNetworkManager()
    installPackages()
    sudo chsh -s /bin/zsh saponace                           # change default shell to ZSH
}


intallYaourt(){
    echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
    pacman -Sy yaourt
}


installSpf13(){
}
sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack


installApache(){
    pacman -S apache
    pacman -S php php-apache
    pacman -S mysql
    # Allow the use of PHP in apache
    echo -e "# Use for PHP 5.x:\nLoadModule php5_module       modules/libphp5.so\n" >> /etc/httpd/conf/httpd.conf
    ehco -e "AddHandler php5-script php\nInclude conf/extra/php5_module.conf" >> /etc/http/conf/httpd.conf
    sed -i "s/mpm_event/mpm_prefork/g" /etc/httpd/conf/httpd.conf
}


# Network manager
installNetworkManager(){
    pacman -S networkmanager 
    systemctl enable NetworkManager
    pacman -S network-manager-applet gnome-keyring gnome-icon-theme
    #(si marche pas, désactiver ipv6 dans dhcpcp)
}




insatllPackages(){
    PA jdk7-openjdk    # Java
}








if [ $# -ne ... ]
then
	usage
	exit 1
fi


