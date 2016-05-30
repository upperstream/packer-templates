#!/bin/sh
mount /dev/$HDD /mnt
sed \
  -e 's/^#PermitRootLogin no/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /mnt/etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /mnt/etc/ssh/sshd_config
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
