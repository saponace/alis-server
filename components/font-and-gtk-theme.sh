#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------


# Install fonts
    ${INSTALL} inconsolata-g     # Default font
    ${INSTALL} ttf-dejavu     # Fallback font

# Install arc gtk theme
    ${INSTALL} gtk-theme-arc

# Set this theme and the font for GTK2 and GTK3
    su -c "echo -e 'gtk-icon-theme-name = \"Arc-Darker\"\ngtk-theme-name = \"Arc-Darker\"\ngtk-font-name = \"Inconsolata-g 8\"' > /usr/share/gtk-2.0/gtkrc"
    su -c "echo -e '[Settings]\ngtk-icon-theme-name = Arc-Darker\ngtk-theme-name = Arc-Darker\ngtk-font-name = Inconsolata-g 8' > /usr/share/gtk-3.0/settings.ini"
