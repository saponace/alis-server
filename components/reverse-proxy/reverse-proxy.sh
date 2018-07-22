#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

traefik_data_dir=/tarefik

# Create docker-compose definition
    declare -A  reverse_proxy_docker_compose_template_mappings=(
        ["CLOUDFLARE_EMAIL"]="${cloudflare_email}"
        ["CLOUDFLARE_API_KEY"]="${cloudflare_api_key}"
        )
    process_docker_compose_service reverse-proxy/traefik "$(declare -p reverse_proxy_docker_compose_template_mappings)"

# Create traefik configuration files
    sudo mkdir -p ${traefik_data_dir}/traefik
    sudo mkdir -p ${traefik_data_dir}/traefik/acme
    sudo touch ${traefik_data_dir}/traefik/acme/acme.toml
    sudo chmod 600 ${traefik_data_dir}/traefik/acme/acme.toml
    htpasswd=$(openssl passwd -apr1 ${webserver_passwd} | sed "s/\\$/\\\\$/g")
    declare -A  traefik_config_mappings=(
        ["LETS_ENCRYPT_EMAIL"]="${lets_encrypt_email}"
        ["HTPASSWD"]="${username}:${htpasswd}"
        )
    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/traefik.toml /tmp/traefik.toml "$(declare -p traefik_config_mappings)"
    sudo mv /tmp/traefik.toml ${}/traefik/traefik.toml
