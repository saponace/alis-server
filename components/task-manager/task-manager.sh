#-------------------------------------------------
# Task manager
#-------------------------------------------------

data_dir="${CONTAINERS_DATA_DIR}/wekan"
wekan_version="v3.21"
mongo_version="4.2.0"

declare -A  wekan_app_docker_compose_template_mappings=(
    ["VERSION"]=${wekan_version}
)
process_docker_compose_service task-manager/wekan-app "$(declare -p wekan_app_docker_compose_template_mappings)"

declare -A  wekan_db_docker_compose_template_mappings=(
    ["DATA_DIR"]=${data_dir}
    ["VERSION"]=${mongo_version}
)
process_docker_compose_service task-manager/wekan-db "$(declare -p wekan_db_docker_compose_template_mappings)"
