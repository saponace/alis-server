#! /bin/bash

DATA1_DEVICE_UUID="136020b5-a00d-46e1-a77f-4774c96dff81"
DATA2_DEVICE_UUID="3245f655-c540-460e-9828-636680c099ee"
MOVIES_DEVICE_UUID="0edd1cec-c43c-4cda-9e95-f453305c27c6"
TV_DEVICE_UUID="c31f1a91-1c8b-44e8-b922-832465c3d2e9"


sudo -v



# $1: Prompt phrase
# $2: UUID of luks device to get passphrase of
function get_luks_passwd(){
    # Prompt for the device LUKS passphrase and loop infinitely until the passphrase is correct
    echo $1
    read -s LUKS_PASSWD
    until $(printf ${LUKS_PASSWD} | sudo cryptsetup luksOpen --test-passphrase /dev/disk/by-uuid/${2} -d -)
    do
        echo $1
        read -s LUKS_PASSWD
    done
}

# $1: Passphrase prompt message
# $2: device UUID
# $3: LUKS mapper name
# $4: Mount point
function mount_single_device(){
    printf ${LUKS_PASSWD} | sudo cryptsetup luksOpen /dev/disk/by-uuid/$2 $3 -d -
    sudo mount /dev/mapper/$3 $4
}

# $1: Passphrase prompt message
# $2: device 1 UUID
# $3: device 2 UUID
# $4: LUKS mapper 1 name
# $5: LUKS mapper 2 name
# $6: Mount point
# $7: Mount options
function mount_btrfs_raid1_device(){
    printf ${LUKS_PASSWD} | sudo cryptsetup luksOpen /dev/disk/by-uuid/$2 $4 -d -
    printf ${LUKS_PASSWD} | sudo cryptsetup luksOpen /dev/disk/by-uuid/$3 $5 -d -
    sudo mount -t btrfs -o $7 /dev/mapper/$4 $6
}



# Prompt all LUKS passphrases without checking
    get_luks_passwd "Enter LUKS passphrase" ${TV_DEVICE_UUID}

# Mount DATA RAID1
    echo "Mounting DATA device ..."
    mount_btrfs_raid1_device ${DATA1_DEVICE_UUID} ${DATA2_DEVICE_UUID} "data1-luks-mapper" "data2-luks-mapper" /mnt "autodefrag"
# Mount MOVIES disk
    echo "Mounting MOVIES device ..."
    mount_single_device ${MOVIES_DEVICE_UUID} movies-luks-mapper /mnt/media/movies
# Mount TV disk
    echo "Mounting TV device ..."
    mount_single_device ${TV_DEVICE_UUID} tv-luks-mapper /mnt/media/tv

# Unset password and remove it from memroy
    unset LUKS_PASSWD



# After all the drives are mounted
    # Start transmission
        transmission-daemon --config-dir /home/saponace/.config/transmission-daemon/
    # Start nginx
        sudo nginx
    # Start kodi
        sudo systemctl start kodi
