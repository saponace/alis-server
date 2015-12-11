#!/bin/bash


if [ $# -ne 1 ]
then
    echo "Usage: $0 username"
    exit 1
fi

username=$1
username_home="/home/${username}"
homedir_dotfiles="config-files/homedir/"
other_config_files_dir="config-files/other"




# Allows copying dotfiles
    shopt -s dotglob


# Dotfiles
    # User homedir dotfiles
        cp -R ${homedir_dotfiles}/* ${username_home}
    # Other configuration files
        # Slim, login manager
            cp ${other_config_files_dir}/slim/slim.conf /etc/
            mkdir -p /usr/share/slim/themes/
            cp -R ${other_config_files_dir}/slim/slim-minimal/ /usr/share/slim/themes/
        # Gtk2 and gtk3 theme
            mkdir -p /usr/share/gtk-3.0/
            cp -R ${other_config_files_dir}/gtk-theme/settings.ini /usr/share/gtk-3.0/
    # Link root dotfiles to user dotfiles
        # .zshrc
            ln -s /home/${username}/.zshrc /root/.zshrc
        # .vimrc
            ln -s ${username_home}/.vimrc /root/.vimrc
            ln -s ${username_home}/.vimrc.local /root/.vimrc.local
            ln -s ${username_home}/.vimrc.bundles /root/.vimrc.bundles
            ln -s ${username_home}/.vimrc.bundles.local /root/.vimrc.bundles.local
            ln -s ${username_home}/.vimrc.before /root/.vimrc.before
            ln -s ${username_home}/.vim /root/.vim

# Scripts
    cp scripts/* /bin/
