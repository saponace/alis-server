#-------------------------------------------------
# Bookmarks manager
#-------------------------------------------------


declare -A  docker_compose_template_mappings=(
    ["DOMAIN_NAME"]="${domain_name}"
)
process_docker_compose_service bookmarks-manager/organizr "$(declare -p docker_compose_template_mappings)"
