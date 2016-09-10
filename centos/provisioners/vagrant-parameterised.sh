#!/bin/sh -ex
# vagrant stuff
# depends: sudo
useradd $VAGRANT_USER
echo "$VAGRANT_PASSWORD" | passwd --stdin $VAGRANT_USER
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$VAGRANT_USER
chmod 0440 /etc/sudoers.d/$VAGRANT_USER
mkdir -p /home/$VAGRANT_USER/.ssh
curl -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER/.ssh
chmod -R og-rwx /home/$VAGRANT_USER/.ssh
