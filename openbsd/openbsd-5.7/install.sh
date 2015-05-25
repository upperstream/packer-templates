#!/bin/sh
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /mnt/etc/sudoers
cat /tmp/vagrant.pub >> /mnt/home/vagrant/.ssh/authorized_keys
UID=`grep '^vagrant' /mnt/etc/passwd | sed 's/^[^:]*:[^:]*:\([^:]*\):.*$/\1/'`
GID=`grep '^vagrant' /mnt/etc/passwd | sed 's/^[^:]*:[^:]*:[^:]*:\([^:]*\):.*$/\1/'`
chown -R $UID:$GID /mnt/home/vagrant/.ssh
