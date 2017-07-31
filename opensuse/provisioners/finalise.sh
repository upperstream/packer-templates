#!/bin/sh
set -e
set -x

if grep '^ssh-rsa.*vagrant insecure public key$' /root/.ssh/authorized_keys; then
  grep -v '^ssh-rsa.*vagrant insecure public key$' /root/.ssh/authorized_keys > /tmp/authorized_keys
  mv /tmp/authorized_keys /root/.ssh/authorized_keys
fi
sed -e 's/^#PermitRootLogin[ \t][ \t]*yes$/PermitRootLogin no/' \
    -e '/^PermitRootLogin[ \t][ \t]*yes$/s/yes/no/' \
    -e 's/^#PasswordAuthentication[ \t][ \t]*yes$/PasswordAuthentication no/' \
    -e '/^PasswordAuthentication[ \t][ \t]*yes$/s/yes$/no/' \
    -e 's/^#PermitEmptyPasswords[ \t][ \t]*yes$/PermitEmptyPasswords no/' \
    -e '/^PermitEmptyPasswords[ \t][ \t]*yes$/s/yes$/no/' \
    -e 's/^#UseDNS[ \t][ \t]*yes$/UseDNS no/' \
    -e '/^UseDNS[ \t][ \t]*yes$/s/yes/no/' \
    /etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
rm -f /root/VBoxGuestAdditions*
