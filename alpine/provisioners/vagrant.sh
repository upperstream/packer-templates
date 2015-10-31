(echo vagrant; echo vagrant) | adduser -s /bin/ash vagrant
mkdir -pm 700 /home/vagrant/.ssh
wget -O - 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant     
chmod -R og-rwx /home/vagrant/.ssh
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vagrant
cat > /usr/sbin/shutdown << 'EOF'
#!/bin/sh
while getopts "h" opt; do
	case $opt in
		h) poweroff;;
	esac
done
EOF
chmod a+rx /usr/sbin/shutdown
apk add nfs-utils
apk add rsync
