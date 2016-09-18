#!/bin/sh -ex
(echo $VAGRANT_PASSWORD; echo $VAGRANT_PASSWORD) | adduser -s /bin/ash $VAGRANT_USERNAME
mkdir -pm 700 /home/$VAGRANT_USERNAME/.ssh
wget -O - 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chown -R $VAGRANT_USERNAME:$VAGRANT_USERNAME /home/$VAGRANT_USERNAME     
chmod -R og-rwx /home/$VAGRANT_USERNAME/.ssh
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME
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
