#!/bin/bash

# Link all the dotfiles from their respective location in the system to the copy of this repo

if [ $# -ne 1 ]
then
    echo "Usage: $0 username"
    exit 1
fi


pushd `dirname $0` > /dev/null
this_script_dir=`pwd -P`
popd > /dev/null

username=$1
username_home="/home/${username}"
homedir_dotfiles=${this_script_dir}/"config-files/homedir"
other_config_files_dir=${this_script_dir}/"config-files/other"
scripts_dir=${this_script_dir}/scripts
link_command='ln -snf'



# Allows copying dotfiles
    shopt -s dotglob




# $HOME/.config
mkdir -p ${username_home}/.config
files_to_link=${homedir_dotfiles}/.config/*;
for config in ${files_to_link}; do
    target_user=${username_home}/.config/$( basename $config )
    target_root=/root/.config/$( basename $config )
    ${link_command} ${config} ${target_user}
    ${link_command} ${config} ${target_root}
done

# $HOME
files_to_link=$(find ${homedir_dotfiles} -mindepth 1 -maxdepth 1 -not -name ".config")
for config in ${files_to_link}; do
    target_user=${username_home}/$( basename $config )
    target_root=/root/$( basename $config )
    ${link_command} ${config} ${target_user}
    ${link_command} ${config} ${target_root}
done



# Other configuration files
    # Slim, login manager
        ${link_command} ${other_config_files_dir}/slim/slim.conf /etc/
        mkdir -p /usr/share/slim/themes/
        ${link_command} ${other_config_files_dir}/slim/slim-minimal/ /usr/share/slim/themes/
    # Gtk2 and gtk3 theme
        mkdir -p /usr/share/gtk-3.0/
        ${link_command} ${other_config_files_dir}/gtk-theme/settings.ini /usr/share/gtk-3.0/

# Scripts
    ${link_command} ${scripts_dir}/* /bin/
