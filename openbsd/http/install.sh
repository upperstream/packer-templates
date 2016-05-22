#!/bin/sh
cp /mnt/etc/ssh/sshd_config /tmp/sshd_config
sed '/^PermitRootLogin/s/ no$/ yes/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
rm /tmp/sshd_config
