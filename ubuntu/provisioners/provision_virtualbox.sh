VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

apt-get insatll -y build-essential
apt-get install -y kernel-devel-`uname -r` kernel-headers-`uname -r`

cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso

