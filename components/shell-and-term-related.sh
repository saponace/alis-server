#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Shell
    ${INSTALL} zsh
    # Link config files
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/zsh ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config/
        sudo_create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/zsh ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config/
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.zshrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
        sudo_create_link ${HOMEDIR_DOTFILES_SOURCE}/.zshrc ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
    # Set default shell
        # For the user
            sudo chsh -s /bin/zsh ${username}
        # For root
            sudo chsh -s /bin/zsh root

# ls improved
    ${INSTALL} lsd
# Terminal multiplexer
    ${INSTALL} tmux
    # Link config file
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.tmux.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}
        sudo_create_link ${HOMEDIR_DOTFILES_SOURCE}/.tmux.conf ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
# Text editor
    ${INSTALL} vim
# Neovim, improved version of vim
    ${INSTALL} neovim
    ${INSTALL} python-neovim
    # Ctags, tags index generating. Used by nvim plugin Tagbar
        ${INSTALL} neovim-tagbar
    # Link config files
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/nvim ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config/
        sudo_create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/nvim ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config/
    # Install nvim plugins
        echo "Installling neovim plugins ..."
        nvim -E +PlugInstall +qall > /dev/null
        echo "Neovim plugins installed !"
