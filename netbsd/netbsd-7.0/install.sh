#!/bin/sh
mount /dev/wd0a /mnt
sed -I 's/^#PermitRootLogin no/PermitRootLogin yes/' /mnt/etc/ssh/sshd_config
sed -I 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /mnt/etc/ssh/sshd_config
ftp -o /mnt/root/vagrant.pub http://$HTTPSERVER/vagrant.pub
mkdir -p /mnt/root/.ssh
cat /mnt/root/vagrant.pub >> /mnt/root/.ssh/authorized_keys
chmod -R og-rwx /mnt/root/.ssh
cat << EOF >> /mnt/etc/rc.conf
#critical_filesystems_local=/var
dhclient=YES
rpcbind=YES
nfs_client=YES
no_swap=YES
lockd=YES
statd=YES
EOF
umount /mnt
reboot
