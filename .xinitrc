# Dual screen setup
    sleep 1 && xrandr --auto --output VGA-0 --mode 1280x1024 --pos 1600x-370
    xrandr --output LVDS --preferred &
# Network manager with tray icon
    nm-applet 2>&1 /dev/null &
# Auto USB mounter
    /usr/bin/udiskie -s &
# Wallpaper
    feh --bg-scale /usr/share/slim/themes/slim-minimal/background.jpg
# Load Xterm config file
    xrdb .Xresources
# Window manager
    exec i3 
