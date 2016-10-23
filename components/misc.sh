#-------------------------------------------------
# Install GUI programs
#-------------------------------------------------


# Transmission (torrenting) daemon (and CLI and web-UI)
    ${INSTALL} transmission-cli
    transmission-remote-cli --create-config   # Make transmission detect config file

# auto-mounting media disks daemon
    ${INSTALL} udiskie

# NTFS filesystems management
    ${INSTALL} ntfs-3g