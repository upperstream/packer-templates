mkdir -p /home/$VAGRANT_USER/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/$VAGRANT_USER/.ssh/authorized_keys
chown -R $VAGRANT_USER:users /home/$VAGRANT_USER
chmod -R og-rwx /home/$VAGRANT_USER/.ssh
sed -I \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^UsePam yes/UsePam no/' \
  -e 's/^#UseDNS no/UseDNS no/' \
  -e 's/^#NoneEnabled no/NoneEnabled yes/' /etc/ssh/sshd_config
echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/pkg/etc/sudoers.d/$VAGRANT_USER
