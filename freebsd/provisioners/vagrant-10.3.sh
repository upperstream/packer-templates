#!/bin/sh

mkdir -p /home/vagrant/.ssh
curl -o /home/vagrant/.ssh/authorized_keys -L 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh


echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers vagrant" >> /etc/ssh/sshd_config

pkg install -y rsync-3.1.2_1 pkgconf-0.9.12_1 samba36-smbclient-3.6.25

exit
