#-------------------------------------------------
# Finances management software
#-------------------------------------------------

db_name="firefly_db"
db_username="firefly_db"
db_pwd="firefly_db_secret"
app_key=$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 )
data_dir="${CONTAINERS_DATA_DIR}/firefly-iii"
firefly_iii_version="release-4.8.0.2"
postgres_version="12"

declare -A  firefly_iii_app_docker_compose_template_mappings=(
    ["FIREFLY_DATA"]=${data_dir}
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["APP_KEY"]=${app_key}
    ["VERSION"]=${firefly_iii_version}
)
process_docker_compose_service finances-management/firefly-iii-app "$(declare -p firefly_iii_app_docker_compose_template_mappings)"

declare -A  firefly_iii_db_docker_compose_template_mappings=(
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["VERSION"]=${postgres_version}
)
process_docker_compose_service finances-management/firefly-iii-db "$(declare -p firefly_iii_db_docker_compose_template_mappings)"
