#-------------------------------------------------
# Link all the dotfiles from their respective location in the system to the copy of this repo
#-------------------------------------------------


pushd `dirname $0` > /dev/null
this_script_dir=`pwd -P`
popd > /dev/null

username_home="/home/${username}"
root_home="/root"

files_to_deploy_dir=${this_script_dir}"/../files-to-deploy"
homedir_dotfiles=${files_to_deploy_dir}"/config-files/homedir"
additional_config_files_dir=${files_to_deploy_dir}"/additional-config-files"

link_command='ln -snf'

# Allows copying dotfiles
    shopt -s dotglob


# Link config files located under $HOME ($HOME/ and $HOME/.config)
# $1: Dotfiles source dir (where the dotfiles will be linked from)
function link_homedir_files(){
    # $HOME/.config
    mkdir -p ${username_home}/.config
    sudo mkdir -p ${root_home}/.config
    files_to_link=$1/.config/*;
    for config in ${files_to_link}; do
        target_user=${username_home}/.config/$( basename $config )
        target_root=${root_home}/.config/$( basename $config )
        ${link_command} ${config} ${target_user}
        sudo ${link_command} ${config} ${target_root}
    done

    # $HOME
    files_to_link=$(find $1 -mindepth 1 -maxdepth 1 -not -name ".config")
    for config in ${files_to_link}; do
        target_user=${username_home}/$( basename $config )
        target_root=${root_home}/$( basename $config )
        ${link_command} ${config} ${target_user}
        sudo ${link_command} ${config} ${target_root}
    done
}



# Generic config files
    link_homedir_files "${homedir_dotfiles}"
# Server specific config files
    link_homedir_files "${additional_config_files_dir}/homedir"


# Other configuration files
    # Nginx
        sudo mkdir -p /etc/nginx/
        sudo ${link_command} ${additional_config_files_dir}/other/nginx.conf /etc/nginx
    # Interfaces
        sudo mkdir -p /etc/network/
        sudo ${link_command} ${additional_config_files_dir}/other/interfaces /etc/network
