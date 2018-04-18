mkdir -pm 700 /home/${VAGRANT_USERNAME:=vagrant}/.ssh
curl -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chmod 0600 /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chown -R $VAGRANT_USERNAME:$VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.ssh
if grep "^UseDNS yes" /etc/ssh/sshd_config; then
  sed "s/^UseDNS yes/UseDNS no/" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
else
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME
chmod 0440 /etc/sudoers.d/$VAGRANT_USERNAME
