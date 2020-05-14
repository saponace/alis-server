#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

# Create docker-compose definition
    declare -A  docker_compose_template_mappings=(
    )
    process_docker_compose_service auth/authelia "$(declare docker_compose_template_mappings)"

# Create traefik data files
    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/authelia

# Create configuration files
    declare -A  config_mappings=(
    )
    fill_template_file ${COMPONENTS_DIR}/auth/config/config.yml /tmp/auth-config.yml "$(declare -p config_mappings)"
    sudo mv /tmp/auth-config.yml ${CONTAINERS_CONFIG_DIR}/authelia/config.yml


    hashed_pwd=$(sudo docker run authelia/authelia authelia hash-password "${admin_pwd}" | sed 's/Password hash: //g')
    declare -A  db_mappings=(
        ["USERNAME"]="${username}"
        # Singles quotes to prevent dollar sign from being interpreted as variable marker
        ["HASHED_PWD"]='${hashed_pwd}'
    )
    fill_template_file ${COMPONENTS_DIR}/auth/config/db.yml /tmp/auth-db.yml "$(declare -p db_mappings)"
    sudo mv /tmp/auth-db.yml ${CONTAINERS_CONFIG_DIR}/authelia/db.yml

# Create secret file
    authelia_secrets_dir=${CONTAINERS_CONFIG_DIR}/authelia/secrets
    jwt_secret_file=${authelia_secrets_dir}/jwt
    sudo mkdir -p ${authelia_secrets_dir}

    add_docker_secret "  authelia_jwt:
    file: ${jwt_secret_file}"

    sudo su -c "echo \"${authelia_jwt_secret}\" > ${jwt_secret_file}"
    sudo chmod 600 ${jwt_secret_file}
