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
%{ for line in lines ~}
${line}
%{ endfor ~}
umount /mnt
reboot
