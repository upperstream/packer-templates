test -z "$VIRTUALBOX_VERSION" && VIRTUALBOX_VERSION=`cat /root/.vbox_version`
wget http://download.virtualbox.org/virtualbox/$VIRTUALBOX_VERSION/VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso

apt-get install -y build-essential
apt-get install -y linux-headers-`uname -r`
apt-get install -y dkms

cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
