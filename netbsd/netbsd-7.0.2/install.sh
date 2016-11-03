#!/bin/sh
mount /dev/$HDD /mnt
sed -I \
  -e 's/^#PermitRootLogin no/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /mnt/etc/ssh/sshd_config
cat << EOF >> /mnt/etc/rc.conf
#critical_filesystems_local=/var
dhclient=YES
rpcbind=YES
nfs_client=YES
no_swap=YES
lockd=YES
statd=YES
hostname=$HOSTNAME
EOF
umount /mnt
reboot
