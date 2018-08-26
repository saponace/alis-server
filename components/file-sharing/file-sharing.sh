#-------------------------------------------------
# File sharing server
#-------------------------------------------------

nextcloud_data="/nextcloud"

declare -A  nextcloud_app_docker_compose_template_mappings=(
    ["NEXTCLOUD_DATA"]="${nextcloud_data}"
)
process_docker_compose_service file-sharing/nextcloud-app "$(declare -p nextcloud_app_docker_compose_template_mappings)"

declare -A  nextcloud_db_docker_compose_template_mappings=(
    ["NEXTCLOUD_DATA"]="${nextcloud_data}"
    ["DB_PWD"]="db_root_pwd"
    ["DB_ROOT_PWD"]="db_pwd"
)
process_docker_compose_service file-sharing/nextcloud-db "$(declare -p nextcloud_db_docker_compose_template_mappings)"
