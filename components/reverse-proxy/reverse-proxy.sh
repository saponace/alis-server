#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

# Create docker-compose definition
    declare -A  reverse_proxy_docker_compose_template_mappings=(
        ["CLOUDFLARE_EMAIL"]="${cloudflare_email}"
    )
    process_docker_compose_service reverse-proxy/traefik "$(declare -p reverse_proxy_docker_compose_template_mappings)"

# Create traefik data files
    sudo mkdir -p ${SERVICES_GENERATED_CONFIG_DIR}/traefik
    sudo mkdir -p ${SERVICES_DATA_DIR}/traefik
    sudo touch ${SERVICES_DATA_DIR}/traefik/acme.json
    sudo chmod 600 ${SERVICES_DATA_DIR}/traefik/acme.json


# Create docker network
    add_docker_network "  web:
    driver: bridge
    name: web"


# Create traefik configuration files
    declare -A  traefik_config_mappings=(
        ["LETS_ENCRYPT_EMAIL"]="${lets_encrypt_email}"
    )
    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/config/traefik.yml /tmp/traefik.yml "$(declare -p traefik_config_mappings)"
    sudo mv /tmp/traefik.yml ${SERVICES_GENERATED_CONFIG_DIR}/traefik/traefik.yml


    fill_template_file ${COMPONENTS_DIR}/reverse-proxy/config/dynamic-conf.yml /tmp/dynamic-conf.yml ""
    sudo mv /tmp/dynamic-conf.yml ${SERVICES_GENERATED_CONFIG_DIR}/traefik/dynamic-conf.yml


# Create Cloudflare api key secret file
    traefik_secrets_dir=${SERVICES_GENERATED_CONFIG_DIR}/traefik/secrets
    cf_api_key_secret_file=${traefik_secrets_dir}/cf_api_key
    sudo mkdir -p ${traefik_secrets_dir}

    add_docker_secret "  traefik_cf_api_key:
    file: ${cf_api_key_secret_file}"

    sudo su -c "echo \"${cloudflare_api_key}\" > ${cf_api_key_secret_file}"
    sudo chmod 600 ${cf_api_key_secret_file}


# Whitelist HTTP and HTTPS port in the firewall (and make sure the firewall is installed)
    ${INSTALL} ufw
    sudo ufw allow "WWW FULL"

# Create a dashboard entry
    add_dashboard_entry "Traefik admin dashboard" traefik traefik "Reverse proxy admin dashboard" iframe Maintenance
