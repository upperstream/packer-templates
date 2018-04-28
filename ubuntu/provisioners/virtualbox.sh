#!/bin/sh
set -e
set -x

test -z "$VIRTUALBOX_VERSION" && VIRTUALBOX_VERSION=$(cat $HOME/.vbox_version)
test "$VIRTUALBOX_WITH_XORG" = "1" || VIRTUALBOX_WITHOUT_XORG=--nox11
VBOX_GUEST_ADDITIONS_ISO=VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso
test -f $VBOX_GUEST_ADDITIONS_ISO || wget http://download.virtualbox.org/virtualbox/$VIRTUALBOX_VERSION/$VBOX_GUEST_ADDITIONS_ISO

apt-get install -y build-essential
apt-get install -y linux-headers-`uname -r`
apt-get install -y dkms

cd /tmp
mount -o loop /home/${VAGRANT_USERNAME:=vagrant}/$VBOX_GUEST_ADDITIONS_ISO /mnt
sh /mnt/VBoxLinuxAdditions.run $VIRTUALBOX_WITHOUT_XORG || true
umount /mnt
rm -rf /home/$VAGRANT_USERNAME/$VBOX_GUEST_ADDITIONS_ISO
