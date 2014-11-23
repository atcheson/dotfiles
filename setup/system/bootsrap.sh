#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This system setup script must be run as root"
   echo "For user setup, try: curl -L deb-user-setup.atcheson.org | sh"
   exit 1
fi

#install all packages
echo "bootstrap.sh: installing packages"
curl https://raw.githubusercontent.com/atcheson/dotfiles/master/setup/system/pkglist > /tmp/pkglist

xargs apt-get --assume-yes install

#set up sudo and /etc/sudoers
sudoers_line="%sudo         ALL=(ALL:ALL) NOPASSWD: ALL"
if ! grep -q "^\%sudo\s*ALL\=(ALL\:ALL)\s*NOPASSWD:\s*ALL.*$" /etc/sudoers; then
    echo "setting up sudoers"
    if [-f "/etc/sudoers.tmp"]; then
        echo "bootstrap.sh ERROR: /etc/sudoers is locked for editing, aborting"
        exit 1
    fi
    touch /etc/sudoers.tmp
    cp /etc/sudoers /tmp/sudoers.tmp
    echo $sudoers_line >> /tmp/sudoers.tmp
    visudo -c -f /tmp/sudoers.tmp
    if [ "$? " -eq "0" ]; then
        cp /tmp/sudoers.tmp /etc/sudoers
    fi
    rm /etc/sudoers.tmp
fi

#configure a user, if supplied
if [ ! -z $i ]; then
    echo "bootstrap.sh: user $1 added to group sudo"
    useradd -G sudo $1
    echo "now configuring user $1"
    sudo -u $1 curl -L deb-user-setup.atcheson.org | sh
fi

