#!/bin/sh -x
test -z "$VBOX_VER" && VBOX_VER=`cat /root/.vbox_version`
test "$VIRTUALBOX_WITH_XORG" = "1" || VIRTUALBOX_WITHOUT_XORG=--nox11
wget http://download.virtualbox.org/virtualbox/$VBOX_VER/VBoxGuestAdditions_$VBOX_VER.iso
mount -t iso9660 VBoxGuestAdditions_$VBOX_VER.iso /media/cdrom0
yes | /media/cdrom0/VBoxLinuxAdditions.run $VIRTUALBOX_WITHOUT_XORG
rm -f VBoxGuestAdditions_*.iso
