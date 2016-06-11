useradd -m vagrant
usermod -p `pwhash vagrant` -G wheel vagrant
mkdir -p /home/vagrant/.ssh
ftp -o - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:users /home/vagrant     
chmod -R og-rwx /home/vagrant/.ssh
sed \
  -e '/^#UseDNS /s/^#//' \
  -e '/^UseDNS /s/ yes$/ no/' /etc/ssh/sshd_config > /tmp/sshd_config
sudo mv /tmp/sshd_config etcssh/sshd_config
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /usr/pkg/etc/sudoers.d/vagrant
