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
    ./deploy-files.sh $username
    rootEnv
}




initSettings (){
    # set locale (not sure if usefull)
        sudo localectl set-keymap fr-latin9
    # Change default shell to ZSH
        chsh -s /bin/zsh $username
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
    # cron job to alert when low battery and power consumption optimization
        batteryManagement
    # Sound server
        $PA pulseaudio pulseaudio-alsa pavucontrol
    # Use pulseaudio with bluetooth
        $PA pulseaudio-bluetooth bluez bluez-utils bluez-firmware
    # Rfkill, to turn on and off wireless interfaces
        $PA rfkill
    # FingerPrint scanner drivers
        $PA fprintd
    # Mount distant directory over ssh
        $PA sshfs
}



installCasual(){
    # Sets a random wallpaper from reddit periodically with cron
        randomWallpaperCronJob
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
        $PA evince
    # fonts
        installFonts
    # Screenshot and image manipulation, used by interactive screenshot
        $PA scrot
    # Image modifier, usel to lock the screen
        $PA imagemagick
    # Music
        installMusic
    # NTFS filesystems management
        $PA ntfs-3g
    # Theme for gtk
        $PA gtk-theme-arc
}



installDev(){
    # utils
        $PA zsh wget openssh svn rsync
    # Vim and spf13
         installSpf13
    # texlive-most (LaTeX compiler)
        $PA texlive-most
    # Terminal multiplexer
        $PA tmux
    # Java Developpement Kit
        $PA jdk7-openjdk openjdk7-doc
        $PA jdk8-openjdk openjdk8-doc
    # Build tools
        $PA gdb maven
    # IDEs
        $PA intellij-idea-ultimate-edition
        $PA clion
        $PA android-studio
}


batteryManagement (){
        $PA acpi pm-utils
    # low battery warning cron script management
        $PA cronie
        echo "*/1 * * * * env DISPLAY=:0 /bin/battery-level -n" > /tmp/root-crontab.txt
        crontab -u root /tmp/root-crontab.txt
        systemctl enable cronie.service
}


randomWallpaperCronJob (){
    echo "*/15 * * * * env DISPLAY=:0.0 /bin/set-random-wallpaper" > /tmp/user-crontab.txt
    crontab -u $username /tmp/user-crontab.txt
}


installPackages(){
    installYaourt
    installCore
    installCasual
    installDev
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
    $PA transmission-remote-gtk
    $PA transmission-remote-cli
    transmission-remote-cli --create-config # Detect config file
}


installSpf13 (){
   $PA vim 
   sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}




if [ $# -ne 1 ]
then
	usage
	exit 1
else
	all
fi


