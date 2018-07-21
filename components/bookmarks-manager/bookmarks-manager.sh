#-------------------------------------------------
# Bookmarks manager
#-------------------------------------------------


declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service bookmarks-manager/organizr "$(declare -p docker_compose_template_mappings)"
