#-------------------------------------------------
# Reverse proxy
#-------------------------------------------------

# Create docker-compose definition
    process_docker_compose_service auth/authelia ""

# Create traefik data files
    sudo mkdir -p ${SERVICES_GENERATED_CONFIG_DIR}/authelia

# Create configuration files
    fill_template_file ${COMPONENTS_DIR}/auth/config/config.yml /tmp/auth-config.yml ""
    sudo mv /tmp/auth-config.yml ${SERVICES_GENERATED_CONFIG_DIR}/authelia/config.yml


    hashed_pwd=$(sudo docker run authelia/authelia authelia hash-password "${admin_pwd}" | sed 's/Password hash: //g')
    declare -A  db_mappings=(
        ["USERNAME"]="${username}"
        # Singles quotes to prevent dollar sign from being interpreted as variable marker
        ["HASHED_PWD"]='${hashed_pwd}'
    )
    fill_template_file ${COMPONENTS_DIR}/auth/config/db.yml /tmp/auth-db.yml "$(declare -p db_mappings)"
    sudo mv /tmp/auth-db.yml ${SERVICES_GENERATED_CONFIG_DIR}/authelia/db.yml

# Create secret file
    authelia_secrets_dir=${SERVICES_GENERATED_CONFIG_DIR}/authelia/secrets
    jwt_secret_file=${authelia_secrets_dir}/jwt
    sudo mkdir -p ${authelia_secrets_dir}

    add_docker_secret "  authelia_jwt:
    file: ${jwt_secret_file}"

    sudo su -c "echo \"${authelia_jwt_secret}\" > ${jwt_secret_file}"
    sudo chmod 600 ${jwt_secret_file}


# Create a dashboard entry
    add_dashboard_entry Authentication auth authelia "Central authentication with Signle Sign On" new_tab "Technical services"
