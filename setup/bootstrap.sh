#!/bin/sh

script_dir=`pwd -P`

#first, ensure that we can use sudo
required_access="(ALL:ALL) NOPASSWD: ALL"
actual_access=`sudo -l -U $USER | tail -n 1 | tr -d ' '`
if [ ! "`echo "$required_access" | tr -d ' '`" = "$actual_access" ]; then
    echo "Enter root password to configure sudo"
    su -c "$script_dir/sudo_setup.sh" $USER
fi



