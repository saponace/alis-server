#-------------------------------------------------
# Server analysis tool
#-------------------------------------------------



# FIXME: Does not seem to work on arm. Maybe x86 ?
# docker_sock_location=/docker.sock.only-containers
# Create interface of /var/run/docker.sock for netdata to fetch and display better info on containers
    # # ${INSTALL} gvt-git # Required to build docker-proxy-acl
    # mkdir -p /tmp/docker-proxy-acl
    # git clone https://github.com/titpetric/docker-proxy-acl.git /tmp/docker-proxy-acl
    # cd /tmp/docker-proxy-acl
    # ./run -a containers
    # # mv docker.sock ${docker_sock_location}
    # cd -



# Build glances docker-compose definition
    declare -A  glances_docker_compose_template_mappings=(
    )
    process_docker_compose_service system-monitoring/glances "$(declare -p glances_docker_compose_template_mappings)"

# Build netdata docker-compose definition
    declare -A  netdata_docker_compose_template_mappings=(
    )
    process_docker_compose_service system-monitoring/netdata "$(declare -p netdata_docker_compose_template_mappings)"
