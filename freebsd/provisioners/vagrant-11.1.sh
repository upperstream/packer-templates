#!/bin/sh -x
mkdir -p /home/${VAGRANT_USER:=vagrant}/.ssh
fetch -o /home/$VAGRANT_USER/.ssh/authorized_keys 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chown -R $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.ssh
chmod -R go-rwsx /home/$VAGRANT_USER/.ssh

echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers $VAGRANT_USER" >> /etc/ssh/sshd_config

exit
