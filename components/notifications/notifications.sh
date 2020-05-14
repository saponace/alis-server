#-------------------------------------------------
# Push notification server
#-------------------------------------------------

add_docker_network "  notifications:"

declare -A  docker_compose_template_mappings=(
    ["GOTIFY_DATA_DIR"]="${CONTAINERS_DATA_DIR}/gotify"
)
process_docker_compose_service notifications/gotify "$(declare -p docker_compose_template_mappings)"
