#!/bin/sh
set -e
set -x

yum -y install ${PERL:-perl} ${GCC:-gcc}

yum -y --enablerepo epel install dkms

curl -O http://download.virtualbox.org/virtualbox/${VBOX_VERSION:=`cat /root/.vbox_version`}/VBoxGuestAdditions_$VBOX_VERSION.iso

cd /tmp
mount -o loop /root/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f /root/VBoxGuestAdditions_*.iso

yum -y erase perl gcc
