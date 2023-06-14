#!/bin/sh -ex
# shellcheck disable=SC2174
mkdir -pm 700 /home/"${VAGRANT_USERNAME:=vagrant}"/.ssh
if [ "$VAGRANT_SSH_PUBLIC_KEY" ]; then
	echo "$VAGRANT_SSH_PUBLIC_KEY" >> /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
else
	${WGET:="curl -kL"} 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
fi
chmod 0600 /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
chown -R "$VAGRANT_USERNAME":"$VAGRANT_USERNAME" /home/"$VAGRANT_USERNAME"/.ssh
if grep "^UseDNS yes" /etc/ssh/sshd_config; then
  sed "s/^UseDNS yes/UseDNS no/" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
else
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/"$VAGRANT_USERNAME"
chmod 0440 /etc/sudoers.d/"$VAGRANT_USERNAME"
