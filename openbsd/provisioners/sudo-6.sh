#!/bin/sh -ex
pkg_add sudo-${SUDO:-1.8.17.1}
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chmod og-rwx /etc/sudoers
