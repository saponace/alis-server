#-------------------------------------------------
# Server analysis tool
#-------------------------------------------------



# Build netdata docker-compose definition
    declare -A  netdata_docker_compose_template_mappings=(
    )
    process_docker_compose_service system-monitoring/netdata "$(declare -p netdata_docker_compose_template_mappings)"
