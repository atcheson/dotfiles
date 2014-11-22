#!/bin/sh
debInst() {
    dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}
if ! debInst "ruby" || ! debInst "git"; then
    echo "Enter the root password to install required components"
    su -c "apt-get --assume-yes install ruby git"
fi
gem install homesick
homesick clone 'atcheson/dotfiles'
/bin/sh $HOME/.homesick/repos/dotfiles/setup/bootstrap.sh
