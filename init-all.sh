#
#file: init-all.sh
#date: Sun Nov 23 02:31:11 CET 2014
#author: saponace </var/mail/saponace>
#description: Initialize a proper arch environment
#


#!/bin/bash

PA="yaourt -S --noconfirm"
username=($1)


homedir=(/home/$username)

usage(){
	echo "Usage: $0 username"
}


all() {
    installPackages
    initSettings
    ./copy.sh deploy $username
     rootEnv
}




initSettings (){
    # set locale (not sure if usefull)
        sudo localectl set-keymap fr-latin9
        export LC_ALL=en_US.UTF-8
        export LANG="$LC_ALL"
    # Change default shell to ZSH
        chsh -s /bin/zsh $username
    # Change the default soundcard
        sudo echo -e "pcm.\!default {\ntype hw\ncard 1\n}\n\nctl.\!default {\ntype hw\ncard 1\n}" > /etc/asound.conf
}



installCore(){
    # X server
        $PA xorg-server xorg-server-utils xorg-xinit xterm xorg-xclock xorg-twm
    # graphic drivers
        $PA mesa xf86-video-vesa xf86-video-ati
    # touchpad drivers
        $PA xf86-input-synaptics
    # login manager
        $PA slim
        systemctl enable slim.service
    # display manager
        $PA awesome
    # Lock screen
        $PA i3lock
    # sound server
        $PA alsa-utils
    # manpager
        $PA most
    # access X clipboard
        $PA xclip
    # file explorer
        installRanger
    # web navigator and flash extension
        $PA google-chrome
    # XrandR, multi-monitor 
        $PA xrandr arandr
    # cron job to alert when low battery
        installLowBatteryWarningCron
}



installCasual(){
    # Network manager
        installNetworkManager
    # Unzip
        $PA unzip
    # VLC media player
        $PA vlc
    # torrent client
        installTransmission
    # automounting media disks
        $PA udiskie
    # image viewer
        $PA feh
    # PDF viewer
        $PA apvlv
    # fonts
        installFonts
    # Redshift
        installRedshift
    # Screenshot and image manipulation, used by interactive screenshot
        $PA scrot
    # Music
        installMusic
    # Image modifier, usel to lock the screen
        $PA imagemagick
}



installDev(){
    # utils
        $PA zsh wget openssh svn rsync
    # Vim and spf13
         installSpf13
    # texlive-most
        $PA texlive-most
    # Java
        $PA jdk7-openjdk
    # LAMP (apache server)
        installlLamp
    # Terminal multiplexer
        $PA tmux
        $PA tmuxinator
    # Figlet, ASCII art -- Ultra pimp
        $PA figlet
    # gdb
        $PA gdb
    # Eclipse, IDE
        $PA eclipse
}


installLowBatteryWarningCron (){
    # cron script management
        $PA acpi
        $PA cronie
        echo "*/1 * * * * env DISPLAY=:0 /home/$username/config/low-battery-warning-cron.sh" > /tmp/cron-jobs.txt
        crontab -u $username /tmp/cron-jobs.txt
        systemctl enable cronie
}


installPackages(){
    installYaourt
    installCore
    installCasual
    installDev
    #installOptional
}



rootEnv (){
    # .zshrc
        sudo ln -s /home/$username/.zshrc /root/.zshrc
    # .vimrc
        sudo ln -s /home/$username/.vimrc /root/.vimrc
        sudo ln -s /home/$username/.vim /root/.vim
        sudo ln -s /home/$username/.vimrc.local /root/.vimrc.local
        sudo ln -s /home/$username/.vimrc.bundles /root/.vimrc.bundles
        sudo ln -s /home/$username/.vimrc.bundles.local /root/.vimrc.bundles.local
        sudo ln -s /home/$username/.vimrc.before /root/.vimrc.before
    # use zsh as default shell
        sudo chsh -s /bin/zsh root
}



installfonts (){
    # dejavu font
    $PA ttf-dejavu

    # Inconsolata-g font
    cd /tmp/
    mkdir Inconsolata-g && cd Inconsolata-g
    wget http://www.fantascienza.net/leonardo/ar/inconsolatag/inconsolata-g_font.zip
    unzip inconsolata-g_font.zip
    mv Inconsolata-g.ttf /usr/share/fonts/TTF/
    fc-cache -fv
}



installNetworkManager (){
    $PA wpa_supplicant
    $PA networkmanager 
    systemctl enable NetworkManager
    $PA network-manager-applet gnome-keyring gnome-icon-theme
    # Disable ipv6 in dhcpcd.conf
    echo -e "noipv6rs\nnoipv6" >> /etc/dhcpcd.conf 
}

installRedshift (){
    $PA redshift
    echo -e "[redshift]\ntemp-day=5700\ntemp-night=3600" > /home/$username/.config/redshift.conf
    echo -e "\ngamma=0.8\nadjustment-method=randr\nlocation-provider=manual" > /home/$username/.config/redshift.conf
    echo -e "\n\n[manual]\nlat=45\nlon=0.5" > /home/$username/.config/redshift.conf
}


installMusic (){
    # Music server
        $PA mpd
    # MPD client
        $PA ncmpcpp
    # Config dir
        mkdir $homedir/.config/mpd
    # Config files
        mkdir -p $homedir/.config/mpd/playlists
        touch $hoemdir/.config/mpd/{database,log,pid,state,sticker.sql}
}

installRanger (){
    $PA ranger
    $PA libcaca              # ASCII image preview
    $PA highlight            # Syntax highlight in preview
    $PA poppler              # PDF preview
    $PA mediaonfo            # Audio and video files info in preiew
    $PA atool                # Reading inside archives
    ranger -copy-config=all # Create dotfiles in $HOME/.config/ranger
}


installYaourt (){
    echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf >/dev/null
    sudo pacman -Syu yaourt 
    # ncurses yaourt gui
    $PA pcurses 
}


installTransmission(){
    $PA transmission-remote-cli
    transmission-remote-cli --create-config # Detect config file
}


installSpf13 (){
   $PA vim 
   sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}



installlLamp (){
    $PA apache
    $PA php-apache
    $PA mysql
    $PA phpmyadmin php-mcrypt

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




if [ $# -ne 1 ]
then
	usage
	exit 1
else
	all
fi


