#!/bin/sh -ex
pkg_add sudo-1.8.14.3.tgz
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
chmod og-rwx /etc/sudoers
