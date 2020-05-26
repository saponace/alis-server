#-------------------------------------------------
# File browser with web interface ala Google drive
#-------------------------------------------------

filebrowser_version="v2.1.0"

# Private filebrowser instance
    filebrowser_data_dir=${SERVICES_DATA_DIR}/filebrowser

    declare -A  filebrowser_private_docker_compose_template_mappings=(
        ["MNT_DIR"]="/mnt"
        ["DATA_DIR"]=${filebrowser_data_dir}
        ["VERSION"]=${filebrowser_version}
    )
    process_docker_compose_service file-browser-web/filebrowser "$(declare -p filebrowser_private_docker_compose_template_mappings)"

    # Create and empty file to prevent docker from creating a directory instead
        sudo mkdir -p ${filebrowser_data_dir}
        sudo touch ${filebrowser_data_dir}/database.db

# Public filebrowser instance
    filebrowser_public_data_dir=${SERVICES_DATA_DIR}/filebrowser-public

    declare -A  filebrowser_public_docker_compose_template_mappings=(
        ["MNT_DIR"]="/mnt/public"
        ["DATA_DIR"]=${filebrowser_public_data_dir}
        ["VERSION"]=${filebrowser_version}
    )
    process_docker_compose_service file-browser-web/filebrowser-public "$(declare -p filebrowser_public_docker_compose_template_mappings)"

    # Create and empty file to prevent docker from creating a directory instead
        sudo mkdir -p ${filebrowser_public_data_dir}
        sudo touch ${filebrowser_public_data_dir}/database.db


# Create a dashboard entries
    add_dashboard_entry Filebrowser filebrowser filebrowser "Web File Browser" iframe Misc
    add_dashboard_entry "Filebrowser (public)" share filebrowser "Web File Browser (public)" iframe Misc
