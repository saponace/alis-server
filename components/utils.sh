#-------------------------------------------------
# Install utilities
#-------------------------------------------------

# Git
    ${INSTALL} git
# SSH client and server
    ${INSTALL} ssh
# Zip
    ${INSTALL} unzip
    ${INSTALL} zip
# Downloads from the web
    ${INSTALL} wget
# Distant and local copy
    ${INSTALL} rsync
# List open files by given process
    ${INSTALL} lsof
# Delete duplicates files
    ${INSTALL} rmlint
# System monitor tool
    ${INSTALL} glances
    ${INSTALL} python-bottle  # Glances web UI dependency
    # Glances web UI daemon
        # ufw enable 61208 # Disabled since all traffic goes trough nginx reverse proxy
        create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/glances-web.service" "/etc/systemd/system/"
        sudo systemctl enable glances-web
