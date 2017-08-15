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

    sudo mkdir -p ${source_dir}
    sudo mkdir -p ${symlink}
    clone_permission_and_ownership ${symlink} ${source_dir}
    sudo rm -rf ${symlink}
    sudo ln -s ${source_dir} ${symlink_parent}
    if [ $(basename "${symlink}") != $(basename "${source_dir}") ];
    then
        sudo mv "${symlink_parent}/$(basename ${source_dir})" "${symlink}"
    fi
}

# Clone file ownership and mode
# $1: The source file
# $2: The target file
function clone_permission_and_ownership(){
    sudo chown --reference="$1" "$2"
    sudo chmod --reference="$1" "$2"
}

# Link a file and make sur the directory of the link exists
# $1: The source file
# $2: The target directory
function create_link (){
    sudo mkdir -p $2
    sudo ln -snf $(readlink -f "$1") $2
}
