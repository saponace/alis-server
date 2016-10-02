#-------------------------------------------------
# Enable networking (enable DHCPCD)
#-------------------------------------------------


echo "Enabling networking ..."
sudo dhcpcd
while [ "$var1" != "end" ]
do
    pingtime=$(ping -w 1 google.com | grep ttl)
    if [ "$pingtime" = "" ]
    then
        sleep 2
    else
        break
    fi
done
echo "Done !"
