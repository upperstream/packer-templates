#!/bin/sh -ex
test -z "$VIRTUALBOX_VERSION" && VIRTUALBOX_VERSION=`cat /root/.vbox_version`
test "$VIRTUALBOX_WITH_XORG" = "1" || VIRTUALBOX_WITHOUT_XORG=--nox11
wget http://download.virtualbox.org/virtualbox/$VIRTUALBOX_VERSION/VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso

apt-get install -y build-essential
apt-get install -y linux-headers-`uname -r`
apt-get install -y dkms

cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run $VIRTUALBOX_WITHOUT_XORG
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
