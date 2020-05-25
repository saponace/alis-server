#-------------------------------------------------
# Server analysis tool
#-------------------------------------------------



# Build netdata docker-compose definition
    ${INSTALL} docker # Ensure docker in installed before getting docker group from /etc/group
    docker_gid_from_host="$(grep docker /etc/group | cut -d ':' -f 3)"

    declare -A  netdata_docker_compose_template_mappings=(
        ["DOCKER_GROUP_ID_FROM_HOST"]=${docker_gid_from_host}
    )
    process_docker_compose_service system-monitoring/netdata "$(declare -p netdata_docker_compose_template_mappings)"

# Create a dashboard entry
    add_dashboard_entry Netdata netdata netdata "Real time system monitoring tool" iframe "Maintenance / monitoring"
