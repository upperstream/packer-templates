mkdir -p /home/vagrant/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:users /home/vagrant     
chmod -R og-rwx /home/vagrant/.ssh
sed -I \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^UsePam yes/UsePam no/' \
  -e 's/^#UseDNS no/UseDNS no/' \
  -e 's/^#NoneEnabled no/NoneEnabled yes/' /etc/ssh/sshd_config
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /usr/pkg/etc/sudoers.d/vagrant
