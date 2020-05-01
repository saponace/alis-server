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

# Link a file and make sure the directory of the link exists
# $1: The source file
# $2: The target directory
function create_link (){
    mkdir -p $2
    ln -snf $(readlink -f "$1") $2
}

# Link a file as root and make sure the directory of the link exists (create it as root if it does not exist)
# $1: The source file
# $2: The target directory
function sudo_create_link (){
    sudo mkdir -p $2
    sudo ln -snf $(readlink -f "$1") $2
}

# Fill a template file from a variables mapping
# First replaces specific mappings, then mappings contained in COMMON_TEMPLATES_MAPPING
# specific mappings will override global templates
# $1: The source file
# $2: The destication file
# $3: The mapping array definition
function fill_template_file (){
    source_file=$1
    dest_file=$2
    eval "declare -A specific_mappings=${3#*=}"

    for key in "${!specific_mappings[@]}";
    do
        sed_args="-e \"s;%$key%;${specific_mappings[$key]};g\" "${sed_args};
    done
    for key in "${!COMMON_TEMPLATES_MAPPING[@]}";
    do
        sed_args="-e \"s;%$key%;${COMMON_TEMPLATES_MAPPING[$key]};g\" "${sed_args};
    done
    eval "sed "${sed_args}" ${source_file}" > ${dest_file}
}

# Process a docker compose service file
# $1: component and docker-compose service names. Like <service>/<docker-compose service>
# $2: The mapping array definition
function process_docker_compose_service (){
    source_file=${COMPONENTS_DIR}"/"$1".yml"
    service_name=$(echo "$1" | sed -e 's/.*\///g')
    dest_file=${TEMP_DOCKER_COMPOSE_PARTS_DIR}/${service_name}".yml"
    mkdir -p ${TEMP_DOCKER_COMPOSE_PARTS_DIR}
    fill_template_file ${source_file} ${dest_file} "$2"
}

# Add a docker network
# Indentation should be input in the parameter as if you were writing the yaml compose file straight
# $1: Definition of the network
function add_docker_network (){
    echo "$1" >> ${TEMP_DOCKER_PART_NETWORKS}
}

# Add a docker named volume
# Indentation should be input in the parameter as if you were writing the yaml compose file straight
# $1: Definition of the named volume
function add_docker_volume (){
    echo "$1" >> ${TEMP_DOCKER_PART_VOLUMES}
}
