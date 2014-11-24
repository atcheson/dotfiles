#!/bin/sh

# linux.atcheson.org
#
# INSTALL:
# 1. Install a minimal Debian system using a netinst image.
# 2. Boot and login as root. Ensure you have internet access.
# 3. apt-get --assume-yes install curl && curl -L linux.atcheson.org -s m 
#    (replace 'm' at the end with the name of the non-root user you created during install).
# 4. Wait for the scripts to run, then log out and log in as your non-root user. 
# 5. startx

if [ "$(id -u)" != "0" ]; then
   echo "This system setup script must be run as root"
   echo "For user setup, try: curl -L deb-user-install.atcheson.org | sh"
   exit 1
fi

#set up /etc/apt/sources.list
curl -L deb-sources-list.atcheson.org > \
    /etc/apt/sources.list
apt-get update

#install all packages
apt-get --assume-yes upgrade
echo "`basename $0`: installing packages"
curl -L deb-pkg-list.atcheson.org | \
    sed  -r 's/i (\S+)\s+.*/\1/' | \
    xargs apt-get --assume-yes install

#set up sudo and /etc/sudoers
sudoers_line="%sudo         ALL=(ALL:ALL) NOPASSWD: ALL"
if ! grep -q "^\%sudo\s*ALL\=(ALL\:ALL)\s*NOPASSWD:\s*ALL.*$" /etc/sudoers; then
    echo "setting up sudoers"
    if [ -f "/etc/sudoers.tmp" ]; then
        echo "`basename $0` ERROR: /etc/sudoers is locked for editing, aborting"
        exit 1
    fi
    touch /etc/sudoers.tmp
    tempfile=/tmp/sudoers.tmp
    cp /etc/sudoers $tempfile
    echo $sudoers_line >> $tempfile
    visudo -c -f $tempfile
    if [ "$? " -eq "0" ]; then
        cp $tempfile /etc/sudoers
    fi
    rm /etc/sudoers.tmp
fi

#configure a user, if supplied
if [ ! -z $1 ]; then
    id -u $1 &>/dev/null || useradd $1
    echo "`basename $0`: user $1 added to group sudo"
    sudo usermod -a -G sudo $1
    echo "now configuring user $1"
    sudo -u $1 -H sh -c 'curl -L deb-user-install.atcheson.org | sh'
fi
