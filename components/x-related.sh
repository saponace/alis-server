#-------------------------------------------------
# Install X server, login manager, windows manager, etc. and all their dependencies
#-------------------------------------------------


# X server
    ${INSTALL} xorg-server xorg-server-utils xorg-xinit
# Login manager
    ${INSTALL} slim
    sudo systemctl enable slim.service   # Start login manager on startup

    # Windows manager
        ${INSTALL} i3
        # Application launcher (rofi is a program launcher and window selector. Calls dmenu to start programs)
            ${INSTALL} rofi dmenu
        # Status bar
            ${INSTALL} i3blocks
        # i3blocks dependencies
            # Proc stats, for mpstat, proc stats
                ${INSTALL} sysstat
            # Fontawesome for the icons in the status bar
                ${INSTALL} otf-font-awesome

# Notifications daemon
    ${INSTALL} dunst
# Lock screen
    ${INSTALL} i3lock
# Multi-monitor management
    ${INSTALL} xrandr arandr
# Color shifter, reduce blue emission
    ${INSTALL} redshift
# Access X clipboard
    ${INSTALL} xclip

