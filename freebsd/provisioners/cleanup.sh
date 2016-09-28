#!/bin/sh -ex
cp /etc/ssh/sshd_config /tmp/sshd_config
sed 's/^PermitRootLogin yes/PermitRootLogin no/' /tmp/sshd_config > /etc/ssh/sshd_config
rm -rf /tmp/* || true
