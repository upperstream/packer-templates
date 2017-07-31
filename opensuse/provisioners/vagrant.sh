#!/bin/sh
set -e
set -x

groupadd ${VAGRANT_GROUP:=vagrant}
useradd -m -g $VAGRANT_GROUP ${VAGRANT_USERNAME:=vagrant}
(echo ${VAGRANT_PASSWORD:=vagrant}; echo $VAGRANT_PASSWORD) | passwd $VAGRANT_USERNAME
mkdir -p /home/$VAGRANT_USERNAME/.ssh
curl -kL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/$VAGRANT_USERNAME/.ssh/authorized_keys 
chown -R $VAGRANT_USERNAME:$VAGRANT_GROUP /home/$VAGRANT_USERNAME/.ssh
chmod -R go-rwsx /home/$VAGRANT_USERNAME/.ssh
if grep "^AllowUsers" /etc/ssh/sshd_config; then
  sed "/^\(AllowUsers[ \t][ \t]*.*\)\$/\1 $VAGRANT_USERNAME" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
fi
zypper --non-interactive install ${SUDO:-sudo}
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME
chmod o-rwx /etc/sudoers.d/$VAGRANT_USERNAME
