#!/bin/sh -e
pkg_add rsync-3.1.2p0 sharity-light-1.3p0
groupadd $VAGRANT_GROUP
useradd -g $VAGRANT_GROUP -p $(encrypt $VAGRANT_PASSWORD) -m $VAGRANT_USER
ftp -o - https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER/.ssh
echo "permit nopass keepenv $VAGRANT_USER as root" >> /etc/doas.conf
