VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

apt-get install -y build-essential
apt-get install -y linux-headers-`uname -r`
apt-get install -y dkms

cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
