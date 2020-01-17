#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

# Create docker-compose definition
    declare -A  reverse_proxy_docker_compose_template_mappings=(
        ["CLOUDFLARE_EMAIL"]="${cloudflare_email}"
        ["CLOUDFLARE_API_KEY"]="${cloudflare_api_key}"
    )
    process_docker_compose_service reverse-proxy/traefik "$(declare -p reverse_proxy_docker_compose_template_mappings)"

# Create traefik data files
    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/traefik
    sudo mkdir -p ${CONTAINERS_DATA_DIR}/traefik
    sudo touch ${CONTAINERS_DATA_DIR}/traefik/acme.json
    sudo chmod 600 ${CONTAINERS_DATA_DIR}/traefik/acme.json

# Create traefik configuration files
    declare -A  traefik_config_mappings=(
        ["LETS_ENCRYPT_EMAIL"]="${lets_encrypt_email}"
    )
    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/config/traefik.yml /tmp/traefik.yml "$(declare -p traefik_config_mappings)"
    sudo mv /tmp/traefik.yml ${CONTAINERS_CONFIG_DIR}/traefik/traefik.yml


    # Escape $ with \ because else the "$" is interpreted by the script that injects the mappings in the
    # files and the password is truncated at the first "$" occurence
    htpasswd=$(openssl passwd -apr1 ${webserver_passwd} | sed -e s/\\$/\\\\$/g)
    declare -A  dynamic_config_mappings=(
        ["HT_PASSWD"]="${username}:${htpasswd}"
    )
    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/config/dynamic-conf.yml /tmp/dynamic-conf.yml "$(declare -p dynamic_config_mappings)"
    sudo mv /tmp/dynamic-conf.yml ${CONTAINERS_CONFIG_DIR}/traefik/dynamic-conf.yml


# Whitelist HTTP and HTTPS port in the firewall (and make sure the firewall is installed)
    ${INSTALL} ufw
    sudo ufw allow "WWW FULL"
