#-------------------------------------------------
# Install file managers
#-------------------------------------------------


# Install ranger (file explorer)
    install_package ranger
    # Link config file
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/ranger ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
        sudo_create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/ranger ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Install ranger dependencies
        install_package libcaca  # ASCII image preview
        install_package highlight  # Syntax highlight in preview
        install_package mediainfo  # Audio and video files informations
        install_package atool  # See archives content
    # Create ranger empty dotfiles (required)
        ranger --copy-config=all
