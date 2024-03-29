#-------------------------------------------------
# Install file server
#-------------------------------------------------


# Install NFS (Network FileSystem)
    install_package nfs-utils

# NFS configuration
sudo su -c "echo '
' > /etc/nfs.conf"


sudo mkdir -p /srv/nfs/data
sudo su -c "echo '
/srv/nfs        192.168.0.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
/srv/nfs/data   192.168.0.0/24(rw,sync,no_subtree_check,nohide)
' >> /etc/exports"

sudo su -c "echo '
# NFS shared data directory
/mnt /srv/nfs/data  none   bind   0   0
' >> /etc/fstab"

# Enable the service
    sudo systemctl enable nfs-server.service

# Whitelist NFS port in the firewall (and make sure the firewall is installed)
    install_package ufw
    sudo ufw allow NFS


# Client mount command (as root):
    # mount -t nfs4 -o vers=4 __SERVER_IP__:/data __CLIENT_MOUNT_DIR__
