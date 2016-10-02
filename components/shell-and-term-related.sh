#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    ${INSTALL} xterm

# Shell
    ${INSTALL} zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${USER}
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
