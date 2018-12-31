#-------------------------------------------------
# Ad-blocking DNS server
#-------------------------------------------------


# Create files and direcetories needed by pihole
pihole_home="${CONTAINERS_DATA_DIR}/pihole"
suod mkdir ${pihole_home}
sudo touch ${pihole_home}/pihole.log

# Create docker compose component
declare -A  docker_compose_template_mappings=(
    ["SERVER_IP"]=${static_ip_address}
    ["HOMEDIR"]=${pihole_home}
    ["WEBSERVER_PASSWD"]=${webserver_passwd}
)
process_docker_compose_service pihole/pihole "$(declare -p docker_compose_template_mappings)"
