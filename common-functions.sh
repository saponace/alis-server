#-------------------------------------------------
# Common functions
#-------------------------------------------------

# Create a symlink of a directory
# $1: The source directory
# $2: The symlink to create
function create_directory_symlink (){
    source_dir=$1
    symlink=$2

    symlink_parent=$(dirname ${symlink})

    # Permissions on a symlink are most probably not revelant. Needs to be checked
    # permission_backup_file=$(mktemp)
    # clone_permission_and_ownership ${symlink} ${permission_backup_file}

    sudo mkdir -p ${source_dir}
    sudo rm -rf ${symlink}
    sudo ln -s ${source_dir} ${symlink_parent}
    if [ $(basename "${symlink}") != $(basename "${source_dir}") ];
    then
        sudo mv "${symlink_parent}/$(basename ${source_dir})" "${symlink}"
    fi
}
