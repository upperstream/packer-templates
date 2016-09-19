#!/bin/sh -ex
mount -t ext4 /dev/sda3 /mnt
apk add --root=/mnt openssl
apk add --root=/mnt sudo
apk add --root=/mnt openssh
ln -s /etc/init.d/sshd /mnt/etc/runlevels/default/sshd
cp /mnt/etc/ssh/sshd_config /tmp/sshd_config
sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
  -e 's/^#UseDNS no/UseDNS no/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
rm /tmp/sshd_config
reboot
