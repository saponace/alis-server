#-------------------------------------------------
# Finances management software
#-------------------------------------------------

db_name="firefly_db"
db_username="firefly_db"
db_pwd="firefly_db_secret"
app_key=$( cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 )
data_dir="/firefly-iii"
firefly_iii_version=latest
mariadb_version=latest

declare -A  firefly_iii_app_docker_compose_template_mappings=(
    ["FIREFLY_DATA"]=${data_dir}
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["APP_KEY"]=${app_key}
    ["FIREFLY_III_VERSION"]=${firefly_iii_version}
)
process_docker_compose_service finances-management/firefly-iii-app "$(declare -p firefly_iii_app_docker_compose_template_mappings)"

declare -A  firefly_iii_db_docker_compose_template_mappings=(
    ["DB_NAME"]=${db_name}
    ["DB_USERNAME"]=${db_username}
    ["DB_PWD"]=${db_pwd}
    ["DATABASE_VERSION"]=${mariadb_version}
)
process_docker_compose_service finances-management/firefly-iii-db "$(declare -p firefly_iii_db_docker_compose_template_mappings)"


# Create/update the database
    sudo systemctl start docker
    # Start the temporary application container
        sudo docker run -d \
        --name firefly_iii_app \
        --link firefly_iii_db \
        -v ${data_dir}/export:/var/www/firefly-iii/storage/export \
        -v ${data_dir}/upload:/var/www/firefly-iii/storage/upload \
        -e FF_DB_HOST=firefly_iii_db \
        -e FF_DB_NAME=${db_name} \
        -e FF_DB_USER=${db_username} \
        -e FF_DB_PASSWORD=${db_pwd} \
        -e FF_APP_KEY=${app_key} \
        -e FF_APP_ENV=local \
        -p 80:80 \
        jc5x/firefly-iii:${firefly_iii_version}

    # Start the temporary databse container
        sudo docker run -d \
        --name firefly_iii_db \
        -v ${data_dir}/db:/var/lib/mysql \
        -e MYSQL_DATABASE=${db_name} \
        -e MYSQL_USER=${db_username} \
        -e MYSQL_PASSWORD=${db_pwd} \
        -e MYSQL_RANDOM_ROOT_PASSWORD=yes \
        mariadb:${mariadb_version}

    # Execute the databse creation/migration commands
        sudo docker exec -it firefly_iii_app php artisan migrate --seed
        sudo docker exec -it firefly_iii_app php artisan firefly:upgrade-database
        sudo docker exec -it firefly_iii_app php artisan firefly:verify
        sudo docker exec -it firefly_iii_app php artisan passport:install > /dev/null

    # Stop the temporary containers
        sudo docker container stop firefly_iii_app
        sudo docker container stop firefly_iii_db
