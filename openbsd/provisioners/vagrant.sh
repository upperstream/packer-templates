#!/bin/sh -ex
ftp -o - https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER/.ssh
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
