#!/bin/sh

mkdir -p /home/vagrant/.ssh
fetch -o /home/vagrant/.ssh/authorized_keys 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh


echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers vagrant" >> /etc/ssh/sshd_config

exit
