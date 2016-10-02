#-------------------------------------------------
# Link all the dotfiles from their respective location in the system to the copy of this repo
#-------------------------------------------------


pushd `dirname $0` > /dev/null
this_script_dir=`pwd -P`
popd > /dev/null

username_home="/home/${USER}"
root_home="/root"

files_to_deploy_dir=${this_script_dir}"/../files-to-deploy"
homedir_dotfiles=${files_to_deploy_dir}"/config-files/homedir"
other_config_files_dir=${files_to_deploy_dir}"/config-files/other"
scripts_dir=${files_to_deploy_dir}"/scripts"

link_command='ln -snf'

# Allows copying dotfiles
    shopt -s dotglob



# $HOME/.config
mkdir -p ${username_home}/.config
sudo mkdir -p ${root_home}/.config
files_to_link=${homedir_dotfiles}/.config/*;
for config in ${files_to_link}; do
    target_user=${username_home}/.config/$( basename $config )
    target_root=${root_home}/.config/$( basename $config )
    ${link_command} ${config} ${target_user}
    sudo ${link_command} ${config} ${target_root}
done

# $HOME
files_to_link=$(find ${homedir_dotfiles} -mindepth 1 -maxdepth 1 -not -name ".config")
for config in ${files_to_link}; do
    target_user=${username_home}/$( basename $config )
    target_root=${root_home}/.config/$( basename $config )
    ${link_command} ${config} ${target_user}
    sudo ${link_command} ${config} ${target_root}
done


# Other configuration files
    # Slim, login manager
        sudo ${link_command} ${other_config_files_dir}/slim/slim.conf /etc/
        sudo mkdir -p /usr/share/slim/themes/
        sudo ${link_command} ${other_config_files_dir}/slim/slim-minimal/ /usr/share/slim/themes/
    # Gtk2 and gtk3 theme
        sudo mkdir -p /usr/share/gtk-3.0/
        sudo ${link_command} ${other_config_files_dir}/gtk-theme/settings.ini /usr/share/gtk-3.0/

# Scripts
    sudo ${link_command} ${scripts_dir}/* /bin/
