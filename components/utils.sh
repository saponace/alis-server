#-------------------------------------------------
# Install utilities
#-------------------------------------------------

# # Git
#     ${INSTALL} git
# # SSH client and server
#     ${INSTALL} ssh
# # Zip
#     ${INSTALL} unzip
#     ${INSTALL} zip
# # Downloads from the web
#     ${INSTALL} wget
# # Distant and local copy
#     ${INSTALL} rsync
# # List open files by given process
#     ${INSTALL} lsof
# # Delete duplicates files
#     ${INSTALL} rmlint
# System monitor tool
    declare -A  glances_docker_compose_template_mappings=(
        ["GLANCES_PORT"]="9006"
    )
    process_docker_compose_service glances "$(declare -p glances_docker_compose_template_mappings)"
