#-------------------------------------------------
# Install an AUR helper
#-------------------------------------------------

# Get the current directory
# Leave this block of code at the very beginning of the script (some
# commands may change the current directory later in this script)
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null


# Git is required to install yay
    sudo pacman -Sy --noconfirm git
# Install AUR helper
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ${git_repo_path}


# Enable colored output
    sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
