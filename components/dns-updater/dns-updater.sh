#-------------------------------------------------
# DNS updater
#-------------------------------------------------

# Create docker-compose definition
    process_docker_compose_service dns-updater/ddclient ""

# Create ddclient configuration files
    sudo mkdir -p ${CONTAINERS_DATA_DIR}/ddclient
    declare -A  ddclient_config_mappings=(
        ["CLOUDFLARE_EMAIL"]="${cloudflare_email}"
        ["CLOUDFLARE_API_KEY"]="${cloudflare_api_key}"
        )
    fill_template_file ${COMPONENTS_DIR}/dns-updater/config/ddclient.conf /tmp/ddclient.conf "$(declare -p ddclient_config_mappings)"
    sudo mv /tmp/ddclient.conf ${CONTAINERS_DATA_DIR}/ddclient/ddclient.conf
