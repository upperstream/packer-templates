#!/bin/sh
set -x
set -e

pkg_add "${RSYNC:-rsync}"
groupadd "$VAGRANT_GROUP"
useradd -g "$VAGRANT_GROUP" -p "`encrypt "$VAGRANT_PASSWORD"`" -m "$VAGRANT_USER"
ftp -o - https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> "/home/$VAGRANT_USER/.ssh/authorized_keys"
chown -R "$VAGRANT_USER:$VAGRANT_GROUP" "/home/$VAGRANT_USER/.ssh"
echo "permit nopass keepenv $VAGRANT_USER as root" >> /etc/doas.conf
