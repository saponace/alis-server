#-------------------------------------------------
# Finances management software
#-------------------------------------------------

db_name="firefly_db"
db_username="firefly_db"
db_pwd="firefly_db_secret"
app_key=$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 )
data_dir="${SERVICES_DATA_DIR}/firefly-iii"
firefly_iii_version="release-5.2.5"
postgres_version="12.3"


add_docker_network "  firefly_iii:"

declare -A  firefly_iii_app_docker_compose_template_mappings=(
    ["FIREFLY_DATA"]=${data_dir}
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["VERSION"]=${firefly_iii_version}
)
process_docker_compose_service finances-management/firefly-iii-app "$(declare -p firefly_iii_app_docker_compose_template_mappings)"

declare -A  firefly_iii_db_docker_compose_template_mappings=(
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["VERSION"]=${postgres_version}
)
process_docker_compose_service finances-management/firefly-iii-db "$(declare -p firefly_iii_db_docker_compose_template_mappings)"

# Create APP_KEY secret file
    firefly_iii_secrets_dir=${SERVICES_GENERATED_CONFIG_DIR}/firefly_iii/secrets
    app_key_secret_file=${firefly_iii_secrets_dir}/app_key
    sudo mkdir -p ${firefly_iii_secrets_dir}

    add_docker_secret "  firefly_iii_app_key:
    file: ${app_key_secret_file}"

    sudo su -c "echo \"${app_key}\" > ${app_key_secret_file}"
    sudo chmod 600 ${app_key_secret_file}
