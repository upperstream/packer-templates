#!/bin/sh
mount /dev/$HDD /mnt
sed 's/^#PermitRootLogin no/PermitRootLogin yes/' /mnt/etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /mnt/etc/ssh/sshd_config
ftp -o /mnt/root/vagrant.pub http://$HTTPSERVER/vagrant.pub
mkdir -p /mnt/root/.ssh
cat /mnt/root/vagrant.pub >> /mnt/root/.ssh/authorized_keys
chmod -R og-rwx /mnt/root/.ssh
cat << EOF >> /mnt/etc/rc.conf
sshd=YES
ntpd=YES
dhclient=YES
rpcbind=YES
nfs_client=YES
lockd=YES
statd=YES
EOF
umount /mnt
reboot
