#!/bin/sh -ex
(echo "$VAGRANT_PASSWORD"; echo "$VAGRANT_PASSWORD") | adduser -s /bin/ash "$VAGRANT_USERNAME"

#shellcheck disable=SC2174
mkdir -pm 700 /home/"$VAGRANT_USERNAME"/.ssh
wget -O - 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> /home/"$VAGRANT_USERNAME"/.ssh/authorized_keys
chown -R "$VAGRANT_USERNAME":"$VAGRANT_USERNAME" /home/"$VAGRANT_USERNAME"
chmod -R og-rwx /home/"$VAGRANT_USERNAME"/.ssh
cat > /usr/sbin/shutdown << 'EOF'
#!/bin/sh
while getopts "h" opt; do
	case $opt in
		h) poweroff;;
	esac
done
EOF
chmod a+rx /usr/sbin/shutdown
apk add nfs-utils rsync doas
echo "permit nopass keepenv $VAGRANT_USERNAME as root" >> /etc/doas.d/doas.conf
