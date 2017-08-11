#!/bin/sh
set -e
set -x

groupadd ${VAGRANT_GROUP:=vagrant}
useradd -g $VAGRANT_GROUP -m -p $(printf "${VAGRANT_PASSWORD:-vagrant}" | pwhash) -s /bin/sh ${VAGRANT_USER:=vagrant}
mkdir -p /home/$VAGRANT_USER/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER
chmod -R og-rwx /home/$VAGRANT_USER/.ssh
echo "PATH=/usr/bin:/bin:/usr/pkg/bin:/usr/local/bin:/usr/sbin" > /home/$VAGRANT_USER/.ssh/environment
chown root:$VAGRANT_GROUP /home/$VAGRANT_USER/.ssh/environment
chmod 0640 /home/$VAGRANT_USER/.ssh/environment

sed \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^UsePam yes/UsePam no/' \
  -e 's/^#UseDNS no/UseDNS no/' \
  -e 's/^#PermitUserEnvironment no/PermitUserEnvironment yes/' \
  -e 's/^#NoneEnabled no/NoneEnabled yes/' /etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config

pkg_add ${RSYNC:-rsync-3.1.2} ${SUDO:=sudo-1.8.5}
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/pkg/etc/sudoers.d/$VAGRANT_USER
