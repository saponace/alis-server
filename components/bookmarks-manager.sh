#-------------------------------------------------
# Bookmarks manager
#-------------------------------------------------


declare -A  docker_compose_template_mappings=(
    ["ORGANIZR_PORT"]="9001"
)
process_docker_compose_service organizr "$(declare -p docker_compose_template_mappings)"
