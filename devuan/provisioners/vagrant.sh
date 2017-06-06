#!/bin/sh -ex
mkdir -pm 700 /home/${VAGRANT_USERNAME:=vagrant}/.ssh
curl -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chmod 0600 /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chown -R $VAGRANT_USERNAME:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USERNAME/.ssh
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME
chmod 0440 /etc/sudoers.d/$VAGRANT_USERNAME
