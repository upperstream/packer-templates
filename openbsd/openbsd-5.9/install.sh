#!/bin/sh
cat /tmp/vagrant.pub >> /mnt/home/vagrant/.ssh/authorized_keys
UID=`grep '^vagrant' /mnt/etc/passwd | sed 's/^[^:]*:[^:]*:\([^:]*\):.*$/\1/'`
GID=`grep '^vagrant' /mnt/etc/passwd | sed 's/^[^:]*:[^:]*:[^:]*:\([^:]*\):.*$/\1/'`
chown -R $UID:$GID /mnt/home/vagrant/.ssh
echo "permit nopass keepenv vagrant as root" >> /mnt/etc/doas.conf
