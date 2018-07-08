#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

# Create docker-compose definition
    declare -A  reverse_proxy_docker_compose_template_mappings=(
        ["DOMAIN_NAME"]="${domain_name}"
        ["CLOUDFLARE_EMAIL"]="${cloudflare_email}"
        ["CLOUDFLARE_API_KEY"]="${cloudflare_api_key}"
        )
    process_docker_compose_service reverse-proxy/traefik "$(declare -p reverse_proxy_docker_compose_template_mappings)"

# Create traefik configuration files
    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/traefik
    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/traefik/acme
    sudo touch ${CONTAINERS_CONFIG_DIR}/traefik/acme/acme.toml
    sudo chmod 600 ${CONTAINERS_CONFIG_DIR}/traefik/acme/acme.toml
    declare -A  traefik_config_mappings=(
        ["LETS_ENCRYPT_EMAIL"]="${lets_encrypt_email}"
        ["DOMAIN_NAME"]="${domain_name}"
        ["HTPASSWD"]="${username}:`openssl passwd -apr1 ${webserver_passwd}`"
        )
    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/traefik.toml /tmp/traefik.toml "$(declare -p traefik_config_mappings)"
    sudo mv /tmp/traefik.toml ${CONTAINERS_CONFIG_DIR}/traefik/traefik.toml
