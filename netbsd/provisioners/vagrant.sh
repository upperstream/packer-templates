useradd -m $VAGRANT_USER
usermod -p `pwhash $VAGRANT_PASSWORD` -G wheel $VAGRANT_USER
mkdir -p /home/$VAGRANT_USER/.ssh
pkg_add wget-1.16.3
wget --no-check-certificate -O - https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER /home/$VAGRANT_USER     
chmod -R og-rwx /home/$VAGRANT_USER/.ssh
sed \
  -e '/^#UseDNS /s/^#//' \
  -e '/^UseDNS /s/ yes$/ no/' /etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/pkg/etc/sudoers.d/$VAGRANT_USER
