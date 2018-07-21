#-------------------------------------------------
# Server analysis tool
#-------------------------------------------------


# Build docker-compose definition
    declare -A  docker_compose_template_mappings=(
    )
    process_docker_compose_service netdata/netdata "$(declare -p docker_compose_template_mappings)"
