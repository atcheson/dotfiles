atcheson/dotfiles
=================
My Debian desktop configuration. Currently under development; no guarantees that anything will work  at the moment. Comprises three components:
* A Homesick-compatible 'castle' repo, [`/home`](home/)
* A set of scripts to automatically configure a new Debian installation or Linux home directory, [`/setup`](/setup)
* Some miscellaneous scripts, mostly for managing configuration files, [`/scripts`](/scripts)

[`/home`](home/)
------
Configuration files for use with various applications on Desktop Linux, and a homesick-compatible dotfile repo. See [`technicalpickles/homesick`](github.com/technicalpickles/homesick) for details on Homesick.

[`/setup`](/setup)
------
Two sets of scripts:
* [`/user`](/setup/user): Scripts to configure a user account from scratch using Homesick. Designed to work with brand-new accounts but can be applied to existing accounts if you are willing to clobber your existing dotfiles.
* [`/system`](/setup/system): Scripts to configure a brand-new Debian system from a minimal install, and also to optionally configure a user with the above configuration.

**Configuring a brand-new Debian system**

The idea is to be able to configure a Debian desktop system to my personal preference (sans machine-specific details such as drivers), from a completed minimal install, without user intervention. To do so:

1. Install a minimal Debian system using a netinst image.
2. Boot and login as root. Ensure you have internet access.
3. `apt-get --assume-yes install curl && curl -L deb-system-install.atcheson.org | sh -s m` (replace '`m`' at the end with the name of the non-root user you created during install).
4. Wait for the scripts to run, then log out and log in as your non-root user. `startx`.

This works because `deb-system-install.atcheson.org`  redirects to  [`/system/bootstrap.sh`](/setup/system/bootstrap.sh), which first downloads [`/system/sources.list`](/setup/system/sources.list) and copies it over /etc/apt/sources.list, then APT updates and upgrades, then fetches [`/system/pkglist`](/setup/system/pkglist) and installs all packages, then configures `/etc/sudoers`, and finally, if a username was provided as the first command-line parameter, starts a shell running as that user and fetches `deb-user-install.atcheson.org`, which redirects to [`/user/init.sh`](/setup/user/pkglist) which will configure that user's account. 


**Configuring a brand-new user account**

So, if you want to configure a new user account on a system (assuming all dependencies are satisfied, which are a subset of the Debian packages listed in [`/system/pkglist`](/setup/system/pkglist)), then you can do the following, as that user *after backing up anything in that user's home directory you would like to keep*:

`curl -L deb-user-install.atcheson.org | sh`

[`/scripts`](/scripts)
------
Scripts I want to carry around. Under construction.

