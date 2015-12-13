#!/bin/bash

username=$1
home_dir=/home/${username}
deploy_files_script_path="./deploy-files.sh"
install_packages_script_path="./install-packages.sh"

usage(){
	echo "Usage: $0 username"
}

all() {
    # Enabling networking
        sudo dhcpcd
    ${install_packages_script_path} ${username}
    set_default_shell
    set_cron_jobs
    configure_networkmanager
    create_config_files
    set_misc
    set_gtk_theme
    ${deploy_files_script_path} ${username}
}

set_default_shell(){
    # for the user
        chsh -s /bin/zsh ${username}
    # For root
        sudo chsh -s /bin/zsh root
}

set_cron_jobs(){
    sudo systemctl enable cronie.service
    # Root cron jobs
        # Display notification or suspend when low battery (every minute)
            echo "*/1 * * * * env DISPLAY=:0 /bin/battery-level -n" > /tmp/root-crontab.txt
            sudo crontab -u root /tmp/root-crontab.txt
    # User cron jobs
        # Set a random wallpaper every 15 minutes
            echo "*/15 * * * * env DISPLAY=:0.0 /bin/set-random-wallpaper" > /tmp/user-crontab.txt
            sudo crontab -u ${username} /tmp/user-crontab.txt
}

configure_networkmanager(){
    sudo systemctl enable NetworkManager.service
    # Disable ipv6 in dhcpcd.conf
        sudo echo -e "noipv6rs\nnoipv6" >> /etc/dhcpcd.conf
}

create_config_files(){
    # Create empty config files for MPD (compulsory to make MPD wrk properly)
        mkdir -p ~/.config/mpd/playlists
        touch ~/.config/mpd/{database,log,pid,state,sticker.sql}
    # Create ranger dotfiles
        ranger --copy-config=all
    # Make transmission detect config file
        transmission-remote-cli --create-config
}

set_misc(){
    # set locale (not sure if useful)
        sudo localectl set-keymap fr-latin9
    # Start login manager on startup
        sudo systemctl enable slim.service
}

set_gtk_theme() {
    sudo echo -e "gtk-icon-theme-name = \"Arc-Darker\"\ngtk-theme-name = \"Arc-Darker\"\ngtk-font-name = \"Inconsolata-g 8\"" > /usr/share/gtk-2.0/gtkrc
    sudo echo -e "[Settings]\ngtk-icon-theme-name = Arc-Darker\ngtk-theme-name = Arc-Darker\ngtk-font-name = Inconsolata-g 8" > /usr/share/gtk-3.0/settings.ini
}



if [ $# -ne 1 ]
then
	usage
	exit 1
else
	all
fi
