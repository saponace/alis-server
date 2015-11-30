#!/bin/bash

PA="yaourt -S --noconfirm"
username=$1


home_dir=/home/${username}

usage(){
	echo "Usage: $0 username"
}


all() {
    install_packages
    init_settings
    ./deploy-files.sh ${username}
    root_env
}




init_settings (){
    # set locale (not sure if useful)
        sudo localectl set-keymap fr-latin9
    # Change default shell to ZSH
        chsh -s /bin/zsh ${username}
}



install_core(){
    # X server
        ${PA} xorg-server xorg-server-utils xorg-xinit xterm xorg-xclock xorg-twm
    # graphic drivers
        ${PA} mesa xf86-video-vesa xf86-video-ati
    # touchpad drivers
        ${PA} xf86-input-synaptics
    # login manager
        ${PA} slim
        systemctl enable slim.service
    # windows manager and dependencies
        ${PA} i3
        ${PA} dmenu
    # For mpstat, proc stats
        ${PA} sysstat
    # Fontawesome for the icons in the status bar
        ${PA} i3blocks otf-font-awesome
    # Notifications daemon
        ${PA} dunst
    # Lock screen
        ${PA} i3lock
    # sound server
        ${PA} alsa-utils
    # manpager
        ${PA} most
    # access X clipboard
        ${PA} xclip
    # file explorer
        install_ranger
    # web navigator and flash extension
        ${PA} google-chrome
    # XrandR, multi-monitor 
        ${PA} xrandr arandr
    # cron job to alert when low battery and power consumption optimization
        battery_management
    # Sound server
        ${PA} pulseaudio pulseaudio-alsa pavucontrol
    # Use pulseaudio with bluetooth
        ${PA} pulseaudio-bluetooth bluez bluez-utils bluez-firmware
    # Rfkill, to turn on and off wireless interfaces
        ${PA} rfkill
    # FingerPrint scanner drivers
        ${PA} fprintd
    # Mount distant directory over ssh
        ${PA} sshfs
}



install_casual(){
    # Sets a random wallpaper from reddit periodically with cron
        random_wallpaper_cron_job
    # Network manager
        install_network_manager
    # Unzip
        ${PA} unzip
    # VLC media player
        ${PA} vlc
    # torrent client
        install_transmission
    # auto-mounting media disks
        ${PA} udiskie
    # image viewer
        ${PA} feh
    # PDF viewer
        ${PA} evince
    # fonts
        installFonts
    # Screenshot and image manipulation, used by interactive screenshot
        ${PA} scrot
    # Image modifier, used to lock the screen
        ${PA} imagemagick
    # Music
        install_music
    # NTFS filesystems management
        ${PA} ntfs-3g
    # Theme for gtk
    install_gtk_theme_arc
}


install_gtk_theme_arc(){
    ${PA} gtk-theme-arc
    echo -e "gtk-icon-theme-name = \"Arc-Darker\"\ngtk-theme-name = \"Arc-Darker\"\ngtk-font-name = \"Inconsolata-g 8\"" > /usr/share/gtk-2.0/gtkrc
    echo -e "[Settings]\ngtk-icon-theme-name = Arc-Darker\ngtk-theme-name = Arc-Darker\ngtk-font-name = Inconsolata-g 8" > /usr/share/gtk-3.0/settings.ini
}



install_dev(){
    # utils
        ${PA} zsh wget openssh svn rsync
    # Vim and spf13
         install_spf13
    # texlive-most (LaTeX compiler)
        ${PA} texlive-most
    # Terminal multiplexer
        ${PA} tmux
    # Java Development Kit
        ${PA} jdk7-openjdk openjdk7-doc
        ${PA} jdk8-openjdk openjdk8-doc
    # Build tools
        ${PA} gdb maven
    # IDEs
        ${PA} intellij-idea-ultimate-edition
        ${PA} clion
        ${PA} android-studio
}


battery_management (){
        ${PA} acpi pm-utils
    # low battery warning cron script management
        ${PA} cronie
        echo "*/1 * * * * env DISPLAY=:0 /bin/battery-level -n" > /tmp/root-crontab.txt
        crontab -u root /tmp/root-crontab.txt
        systemctl enable cronie.service
}


random_wallpaper_cron_job (){
    echo "*/15 * * * * env DISPLAY=:0.0 /bin/set-random-wallpaper" > /tmp/user-crontab.txt
    crontab -u ${username} /tmp/user-crontab.txt
}


install_packages(){
    install_yaourt
    install_core
    install_casual
    install_dev
}



root_env (){
    # .zshrc
        sudo ln -s /home/${username}/.zshrc /root/.zshrc
    # .vimrc
        sudo ln -s /home/${username}/.vimrc /root/.vimrc
        sudo ln -s /home/${username}/.vim /root/.vim
        sudo ln -s /home/${username}/.vimrc.local /root/.vimrc.local
        sudo ln -s /home/${username}/.vimrc.bundles /root/.vimrc.bundles
        sudo ln -s /home/${username}/.vimrc.bundles.local /root/.vimrc.bundles.local
        sudo ln -s /home/${username}/.vimrc.before /root/.vimrc.before
    # use zsh as default shell
        sudo chsh -s /bin/zsh root
}



install_fonts (){
    # dejavu font
    ${PA} ttf-dejavu

    # Inconsolata-g font
#    cd /tmp/
#    mkdir Inconsolata-g && cd Inconsolata-g
#    wget http://www.fantascienza.net/leonardo/ar/inconsolatag/inconsolata-g_font.zip
#    unzip inconsolata-g_font.zip
#    mv Inconsolata-g.ttf /usr/share/fonts/TTF/
#    fc-cache -fv
    ${PA} inconsolata-g
}



install_network_manager (){
    ${PA} wpa_supplicant
    ${PA} networkmanager
    systemctl enable NetworkManager
    ${PA} network-manager-applet gnome-keyring gnome-icon-theme
    # Disable ipv6 in dhcpcd.conf
    echo -e "noipv6rs\nnoipv6" >> /etc/dhcpcd.conf 
}


install_music (){
    # Music server
        ${PA} mpd
    # MPD client
        ${PA} ncmpcpp
    # Config dir
        mkdir ${home_dir}/.config/mpd
    # Config files
        mkdir -p ${home_dir}/.config/mpd/playlists
#        touch $homedir/.config/mpd/{database,log,pid,state,sticker.sql}
}

install_ranger (){
    ${PA} ranger
    ${PA} libcaca              # ASCII image preview
    ${PA} highlight            # Syntax highlight in preview
    ${PA} poppler              # PDF preview
    ${PA} mediaonfo            # Audio and video files info in preiew
    ${PA} atool                # Reading inside archives
    su -u ${user} ranger -copy-config=all # Create dotfiles in $HOME/.config/ranger
}


install_yaourt (){
    echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
    sudo pacman -Syu yaourt 
    # ncurses yaourt gui
    ${PA} pcurses
}


install_transmission(){
    ${PA} transmission-remote-gtk
    ${PA} transmission-remote-cli
    sudo -u ${user} transmission-remote-cli --create-config # Detect config file
}


install_spf13 (){
   ${PA} vim
   sudo curl http://j.mp/spf13-vim3 -L -o - | sh       # spf13, config and plugin pack
}




if [ $# -ne 1 ]
then
	usage
	exit 1
else
	all
fi
