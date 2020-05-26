#-------------------------------------------------
# Ad-blocking DNS server
#-------------------------------------------------

# WARNING: PiHole data is not persisted on the host's storage for simplicity reasons.
# To persist configurations and data, please map appropriate volumes to the host's storage


# Create files and direcetories needed by pihole
pihole_home="${SERVICES_DATA_DIR}/pihole"
sudo mkdir -p ${pihole_home}
sudo touch ${pihole_home}/pihole.log

# Create docker compose component
declare -A  docker_compose_template_mappings=(
    ["SERVER_IP"]=${static_ip_address}
    ["HOMEDIR"]=${pihole_home}
)
process_docker_compose_service dns-server/pihole "$(declare -p docker_compose_template_mappings)"


# Create a dashboard entry
    add_dashboard_entry Pi-Hole pihole pihole "Admin interface for the DNS server with intergated adds blocker" new_tab "Technical services"
