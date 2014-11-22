#ensure that sudo is set up so we can use it
apt-get --assume-yes install sudo
sudoers_line="%sudo         ALL=(ALL:ALL) NOPASSWD: ALL"
if ! grep -q "^\%sudo\s*ALL\=(ALL\:ALL)\s*NOPASSWD:\s*ALL.*$" /etc/sudoers; then
    if [-f "/etc/sudoers.tmp"]; then
        echo "ERROR: /etc/sudoers is locked for editing"
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
useradd -G sudo $1
