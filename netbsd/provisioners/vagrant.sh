useradd -m vagrant
usermod -p `pwhash vagrant` -G wheel vagrant
mkdir -p /home/vagrant/.ssh
cat /root/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:users /home/vagrant     
chmod -R og-rwx /home/vagrant/.ssh
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /usr/pkg/etc/sudoers.d/vagrant
