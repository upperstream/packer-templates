#!/bin/sh -ex
pkg_add sudo-1.8.15.tgz
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chmod og-rwx /etc/sudoers
