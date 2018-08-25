#-------------------------------------------------
# Finances management software
#-------------------------------------------------

db_name="firefly_db"
db_username="firefly_db"
db_pwd="firefly_db_secret"
app_key=$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 )
echo "Firefly iii app key: ${app_key}"

declare -A  firefly_iii_docker_compose_template_mappings=(
    ["FIREFLY_DATA"]="/firefly-iii"
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["APP_KEY"]=${app_key}
)
process_docker_compose_service finances-management/firefly-iii "$(declare -p firefly_iii_docker_compose_template_mappings)"

declare -A  firefly_iii_db_docker_compose_template_mappings=(
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
)
process_docker_compose_service finances-management/firefly-iii-db "$(declare -p firefly_iii_db_docker_compose_template_mappings)"
