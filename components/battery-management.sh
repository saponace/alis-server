#-------------------------------------------------
# Install and configure utilities to save battery on a laptop
#-------------------------------------------------


# Battery state indicator
    ${INSTALL} acpi
# Suspend tool
    ${INSTALL} pm-utils
# Change behavior of system depending on AC state
    ${INSTALL} laptop-mode-tools
    sudo systemctl enable laptop-mode.service
