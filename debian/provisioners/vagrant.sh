#!/bin/sh -ex

#shellcheck disable=SC2174
mkdir -pm 700 /home/"$VAGRANT_USERNAME"/.ssh

if [ "$VAGRANT_SSH_PUBLIC_KEY" ]; then
	echo "$VAGRANT_SSH_PUBLIC_KEY" >> /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
else
	${WGET:="curl -kL"} 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
fi

chmod 0600 /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
chown -R "$VAGRANT_USERNAME":"$VAGRANT_USERNAME" /home/"$VAGRANT_USERNAME"/.ssh
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/"$VAGRANT_USERNAME"
chmod 0440 /etc/sudoers.d/"$VAGRANT_USERNAME"
