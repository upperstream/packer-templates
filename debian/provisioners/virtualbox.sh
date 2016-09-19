#!/bin/sh -ex
test -z "$VBOX_VER" && VBOX_VER=`cat /root/.vbox_version`
wget http://download.virtualbox.org/virtualbox/$VBOX_VER/VBoxGuestAdditions_$VBOX_VER.iso
mount -t iso9660 VBoxGuestAdditions_$VBOX_VER.iso /media/cdrom0
yes | /media/cdrom0/VBoxLinuxAdditions.run --nox11
rm -f VBoxGuestAdditions_*.iso
