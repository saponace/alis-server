#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Shell
    ${INSTALL} zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${username}
    # For root
        sudo chsh -s /bin/zsh root

# Terminal multiplexer
    ${INSTALL} tmux
# Text editor
    ${INSTALL} vim
# Neovim, improved version of vim
    ${INSTALL} neovim
    ${INSTALL} python-neovim
    # Ctags, tags index generating. Used by nvim plugin Tagbar
        ${INSTALL} tagbar
    # Link config files
        create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/nvim ${HOMEDIR_DOTFILES_DESTINATION}/.config/
    # Install nvim plugins
        nvim -E +PlugInstall +qall
