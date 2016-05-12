mkdir ~/.ssh
wget -O - "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub" >> /home/tc/.ssh/authorized_keys
chmod -R og-rwx /home/tc/.ssh
sudo sed -i -e '/^#UseDNS /s/^#//' -e '/^UseDNS /s/ yes$/ no/' /usr/local/etc/ssh/sshd_config
