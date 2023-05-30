#!/bin/sh
set -e
set -x
mount -t ext4 /dev/${DISK:-sda}3 /mnt
apk add --root=/mnt --no-cache openssl openssh
ln -s /etc/init.d/sshd /mnt/etc/runlevels/default/sshd
cp /mnt/etc/ssh/sshd_config /tmp/sshd_config
sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
  -e 's/^#UseDNS no/UseDNS no/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
rm /tmp/sshd_config
apk add --root=/mnt hvtools
chroot /mnt sh -c "rc-update add hv_fcopy_daemon default && \
rc-update add hv_kvp_daemon default && \
rc-update add hv_vss_daemon default"
reboot
