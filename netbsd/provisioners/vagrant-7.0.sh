mkdir -p /home/vagrant/.ssh
cat /root/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:users /home/vagrant     
chmod -R og-rwx /home/vagrant/.ssh
sed -I 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -I 's/^UsePam yes/UsePam no/' /etc/ssh/sshd_config
sed -I 's/^#UseDNS no/UseDNS no/' /etc/ssh/sshd_config
sed -I 's/^#NoneEnabled no/NoneEnabled yes/' /etc/ssh/sshd_config
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /usr/pkg/etc/sudoers.d/vagrant
