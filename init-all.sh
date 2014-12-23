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


all() {
    initSettings
    installPackages
    rootEnv
}




initSettings (){
    #  change default shell to ZSH
    sudo chsh -s /bin/zsh saponace

    # add saponace to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash saponace
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    
    # use zsh as default shell
    chsh -s /bin/zsh saponace

    # set locale (not sure if usefull)
    export LC_ALL=en_US.UTF-8
    export LANG="$LC_ALL"
}



installCore(){
    # X server
    PA xorg-server xorg-server-utils xorg-xinit xter xorg-xclock xorg-twm
    # graphic drivers
    PA mesa xf86-video-vesa xf86-video-ati
    # touchpad drivers
    PA xf86-input-synaptics
    # login manager
    PA slim
    # display manager and app launcher
    PA i3 dmenu
    # sound server
    PA alsa-utils
    # manpager
    PA most
    # access X clipboard
    PA xclip
    # keybindings
    PA wkeybindings
    # file explorer
    PA ranger
    # web navigator and flash extension
    PA chromium chromium-pepper-flash
    # dejavu font
    PA ttf-dejavu
    # Inconsolata font
    PA ttf-inconsolata
}



instllCasual(){
    #Network manager
    installNetworkManager
    # Yaourt package manager
    installYaourt
    # pimp
    PA unzip
    # VLC media player
    PA vlc
}



installDev(){
    # utils
    PA zsh wget openssh svn rsync
    # Vim and spf13
    installSpf13
    # texlive-most
    PA texlive-most
    # Java
    PA jdk7-openjdk
    # LAMP (apache server)
    installlLamp
}



installPackages (){
    installCore
    installCasual
    installDev
}



rootEnv (){
    cd /root
    # .zshrc
    ln -s /home/saponace/.zshrc .zshrc
    # .vimrc
    ln -s /home/saponace/.vimrc .vimrc
    ln -s /home/saponace/.vim/ .vim
    ln -s /home/saponace/.vimrc.local .vimrc.local
    ln -s /home/saponace/.vimrc.bundles .vimrc.bundles
    ln -s /home/saponace/.vimrc.bundles.local .vimrc.bundles.local
    ln -s /home/saponace/.vimrc.before .vimrc.before
    # use zsh as default shell
    chsh -s /bin/zsh root
}





installNetworkManager(){
    PA wpa_supplicant
    PA networkmanager 
    systemctl enable NetworkManager
    PA network-manager-applet gnome-keyring gnome-icon-theme
    #(si marche pas, désactiver ipv6 dans dhcpcp)
}



intallYaourt (){
    echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
    PA yaourt
}



installSpf13 (){
   PA vim 
   sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}



installlLamp (){
    PA apache
    PA php-apache
    PA mysql
    PA phpmyadmin php-mcrypt

    # Allow the use of PHP in apache
    echo -e "# Use for PHP 5.x:\nLoadModule php5_module       modules/libphp5.so\n" >> /etc/httpd/conf/httpd.conf
    echo -e "AddHandler php5-script php\nInclude conf/extra/php5_module.conf" >> /etc/http/conf/httpd.conf
    sed -i "s/mpm_event/mpm_prefork/g" /etc/httpd/conf/httpd.conf

    # Combine php and mysql
    sed -i "s/#extension=pdo_mysql.so/extension=pdo_mysql.so/g" /etc/php/php.ini
    sed -i "s/#extension=mcrypt.so/extension=mcrypt.so/g" /etc/php/php.ini

    # phpmyadmin
    sed -i "s#open_basedir = /#open_basedir = /etc/webapps/:/g" /etc/php/php.ini
    echo -e 'Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"\n<Directory "/usr/share/webapps/phpMyAdmin/">\n' /etc/httpd/conf/extra/httpd-phpmyadmin.conf

    echo -e "DirectoryIndex index.html index.php\nAllowOverride All\n Options FollowSymlinks\n" /etc/httpd/conf/extra/httpd-phpmyadmin.conf

    echo -e "Require all granted\n</Directory>" /etc/httpd/conf/extra/httpd-phpmyadmin.conf
    echo -e "Include conf /extra/httpd-phpmyadmin.conf" >> /etc/httpd/conf/httpd.conf
}




if [ $# -ne ... ]
then
	usage
	exit 1
fi


