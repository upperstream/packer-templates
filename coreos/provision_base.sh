#!/bin/sh

echo "Adding vagrant to sudoers"
sh -c 'echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant'
chmod 0440 /etc/sudoers.d/vagrant

echo "Downloading Vagrant insecure key"
curl -ksLo /tmp/authorized_keys https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub

echo "Mounting CoreOS disk"
mount /dev/sda9 /mnt

echo "Copying vagrant home directory"
cp -pr /home/vagrant /mnt/home/

echo "Writing Vagrant insecure key"
mkdir -p /mnt/home/vagrant/.ssh
cp /tmp/authorized_keys /mnt/home/vagrant/.ssh/
chown -R vagrant:vagrant /mnt/home/vagrant
chmod -R og-rwx /mnt/home/vagrant/.ssh

echo "Copying shadow password file"
cp -pr /etc/shadow /etc/passwd /etc/group /etc/sudoers.d/ /mnt/etc/

echo "Unmounting CoreOS disk"
umount /mnt
