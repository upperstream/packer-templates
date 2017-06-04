#!/bin/sh -x
test -z "$VBOX_VER" && VBOX_VER=`cat /root/.vbox_version`
test "$VIRTUALBOX_WITH_XORG" = "1" || virtualbox_without_xorg=--nox11
vbox_guest_additions_iso=VBoxGuestAdditions_${VBOX_VER:=$(cat /root/.vbox_version)}.iso
wget http://download.virtualbox.org/virtualbox/$VBOX_VER/$vbox_guest_additions_iso
mount -t iso9660 $vbox_guest_additions_iso /media/cdrom0
yes | /media/cdrom0/VBoxLinuxAdditions.run $virtualbox_without_xorg
rm -f $vbox_guest_additions_iso
