#!/bin/sh -x
mkdir -p /home/${VAGRANT_USER:=vagrant}/.ssh
curl -o /home/$VAGRANT_USER/.ssh/authorized_keys -L 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chown -R $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.ssh
chmod -R go-rwx /home/$VAGRANT_USER/.ssh

echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers $VAGRANT_USER" >> /etc/ssh/sshd_config

pkg install -y rsync-3.1.2_5

exit
