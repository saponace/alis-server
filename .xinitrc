sleep 1 && xrandr --auto --output VGA-0 --mode 1280x1024 --pos 1600x-370
xrandr --output LVDS --preferred &
nm-applet 2>&1 /dev/null &
/usr/bin/udiskie -s &
exec i3 
