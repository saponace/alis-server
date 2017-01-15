#-------------------------------------------------
# Install file managers
#-------------------------------------------------


# Install ranger (file explorer)
    ${INSTALL} ranger
    # Install ranger dependencies
        ${INSTALL} libcaca  # ASCII image preview
        ${INSTALL} highlight  # Syntax highlight in preview
        ${INSTALL} mediainfo  # Audio and video files informations
        ${INSTALL} atool  # See archives content
    # Create ranger empty dotfiles (required)
        ranger --copy-config=all
