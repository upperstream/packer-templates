#!/bin/sh
# shellcheck disable=SC3028

set -e
set -x
dkctl "$DISK" makewedges
mount /dev/"$PARTITION" /mnt
sed \
  -e 's/^#PermitRootLogin [a-z][a-z-]*$/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /mnt/etc/ssh/sshd_config \
  > /tmp/sshd_config
mv /tmp/sshd_config /mnt/etc/ssh/sshd_config
tee -a /mnt/etc/rc.conf << EOF
#critical_filesystems_local=/var
rpcbind=YES
#nfs_client=YES
no_swap=YES
lockd=YES
statd=YES
hostname=$HOSTNAME
ifconfig_$NETIF="inet $HOST_CIDR"
defaultroute=$GATEWAY
dhcpcd=YES
EOF
echo "nameserver $GATEWAY" > /mnt/etc/resolv.conf
umount /mnt
reboot
