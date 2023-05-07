#!/bin/sh
set -e
set -x

if [ "$DOAS" != "" ]; then
	pkg_add "$DOAS"
	mkdir -p /usr/pkg/etc
	echo "permit nopass keepenv $VAGRANT_USER as root" >> /usr/pkg/etc/doas.conf
else
	pkg_add "${SUDO:-sudo}"
	mkdir -p /usr/pkg/etc/sudoers.d
	echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/pkg/etc/sudoers.d/"$VAGRANT_USER"
fi
pkg_add "${RSYNC:-rsync}"

groupadd "${VAGRANT_GROUP:=vagrant}"
useradd -g "$VAGRANT_USER" -m -p "$(echo "${VAGRANT_PASSWORD:-vagrant}" | pwhash)" "${VAGRANT_USER:=vagrant}"
mkdir -p /home/"$VAGRANT_USER"/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/"$VAGRANT_USER"/.ssh/authorized_keys
echo "PATH=/usr/bin:/bin:/usr/pkg/bin:/usr/local/bin:/usr/sbin" >> /home/"$VAGRANT_USER"/.ssh/environment
chown -R "$VAGRANT_USER":"$VAGRANT_GROUP" /home/"$VAGRANT_USER"
chmod -R og-rwx /home/"$VAGRANT_USER"/.ssh
sed \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^UsePam yes/UsePam no/' \
  -e 's/^#UseDNS no/UseDNS no/' \
  -e 's/^#PermitUserEnvironment no/PermitUserEnvironment yes/' \
  /etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
