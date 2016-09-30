#!/usr/bin/env bash

PA="yaourt -S --noconfirm"


usage(){
	echo "No arguments should be given to this script"
}

all(){
    install_core
    install_yaourt
    install_x_related
    install_windows_manager
    install_hardware_drivers
    install_misc
    install_terminal_related
    install_terminal_utils
    install_display_utils
    install_dev
    install_battery_management_utils
    install_fonts
    install_network_manager
    install_sound_related
    install_ranger_and_optional_dependencies
    install_virtualbox
    install_thinkpad_specific
}

install_core(){
    ${PA} linux-headers
}

install_yaourt(){
    su -c "echo -e $'[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
    sudo pacman -Syu yaourt
}

install_x_related(){
    # X server
        ${PA} xorg-server xorg-server-utils xorg-xinit
    # Login manager
        ${PA} slim
    # Notifications daemon
        ${PA} dunst
    # Lock screen
        ${PA} i3lock
    # Access X clipboard
        ${PA} xclip
    # Multi-monitor management
        ${PA} xrandr arandr
    # Color shifter, reduce blue emission
        ${PA} redshift
    # Dark gtk2 and gtk3 theme
        ${PA} gtk-theme-arc
}

install_windows_manager(){
    # windows manager
        ${PA} i3
    # Application launcher (rofi is a program launcher and window selector. Calls dmenu to start programs)
        ${PA} rofi dmenu
    # Status bar
        ${PA} i3blocks
    # i3blocks dependencies
        # Proc stats, for mpstat, proc stats
            ${PA} sysstat
        # Fontawesome for the icons in the status bar
            ${PA} otf-font-awesome
}

install_hardware_drivers(){
    # graphic drivers
        ${PA} mesa xf86-video-vesa
    # touchpad drivers
        ${PA} xf86-input-synaptics
    # Brightness control (backlight)
        ${PA} light
}

install_misc(){
    # web navigator and flash extension
        ${PA} google-chrome
    # Mount distant directories over ssh
        ${PA} sshfs
    # Cron job "server"
        ${PA} cronie
    # VLC media player
        ${PA} vlc
    # auto-mounting media disks daemon
        ${PA} udiskie
    # NTFS filesystems management
        ${PA} ntfs-3g
    # Backup utility
        ${PA} borgbackup
    # Transmission (torrenting) daemon.(and CLI and web-UI)
        ${PA} transmission-daemon-
}

install_terminal_related(){
    # Terminal emulator
        ${PA} xterm
    # Shell
        ${PA} zsh
    # Terminal multiplexer
        ${PA} tmux
}

install_terminal_utils(){
    # Rfkill, to turn on and off wireless interfaces
        ${PA} rfkill
    # Text editor
        ${PA} vim
        # Neovim
            ${PA} neovim
            ${PA} python-neovim
    # Downloads from the web
        ${PA} wget
    # ssh client and server
        ${PA} ssh
    # Unzip
        ${PA} unzip
}

install_display_utils(){
    # Screenshot and image manipulation, used by interactive screenshot
        ${PA} scrot
    # image viewer
        ${PA} feh
    # Image modifier, used to lock the screen
        ${PA} imagemagick
    # PDF viewer
        ${PA} evince
}

install_dev(){
    # texlive-most (LaTeX compiler)
        ${PA} texlive-most
    # Java Development Kit
        ${PA} jdk7-openjdk openjdk7-doc
        ${PA} jdk8-openjdk openjdk8-doc
    # C debug tools
        ${PA} gdb
    # Java build tools
        ${PA} maven
    # IDEs
        ${PA} intellij-idea-ultimate-edition
    # Ctags, tags index generating. Use by nvim plugin Tagbar
        ${PA} tagbar
}

install_battery_management_utils(){
    # Battery state indicator
        ${PA} acpi
    # Suspend tool
        ${PA} pm-utils
    # Chnage behavior of components depending on AC state
        ${PA} laptop-mode-tools
}

install_fonts(){
    ${PA} ttf-dejavu
    ${PA} inconsolata-g
}

install_network_manager(){
    # To access network state without root privileges
        ${PA} wpa_supplicant
    # Network manager
        ${PA} networkmanager
    # NetworkManager tray icon
        ${PA} network-manager-applet gnome-keyring gnome-icon-theme
}

install_sound_related(){
    # Sound server
        ${PA} pulseaudio pulseaudio-alsa alsa-utils pavucontrol pasystray
    # Use bluetooth with pulseaudio
        ${PA} pulseaudio-bluetooth bluez bluez-utils bluez-firmware
    # Jack2, other sound server
        ${PA} jack2
    # Jack2 GUI
        ${PA} qjackctl
    # Jack sink for pulseaudio
        ${PA} pulseaudio-jack

}

install_ranger_and_optional_dependencies(){
    # File explorer
        ${PA} ranger
    # ASCII image preview
        ${PA} libcaca
    # Syntax highlight in preview
        ${PA} highlight
    # Audio and video files informations
        ${PA} mediainfo
    # See archives content
        ${PA} atool
}

install_virtualbox(){
    # Virtualbox
        ${PA} virtualbox
    # Required modules
        ${PA} virtualbox-host-dkms
}

install_thinkpad_specific(){
    # Start and stop charging batteries at given values (preserve batteries health on the long term)
        ${PA} tp-battery-mode
    # FingerPrint scanner drivers
        ${PA} fprintd
}


if [ $# -ne 0 ]
then
	usage
	exit 1
else
	all
fi
