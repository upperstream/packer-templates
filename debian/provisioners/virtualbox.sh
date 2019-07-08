#!/bin/sh
set -e
set -x

test "${INSTALL_DKMS:-false}" = "true" && apt-get -y install dkms
if [ -z "$VBOX_VER" ]; then
    VBOX_VER=`cat /root/.vbox_version`
fi
test "$VIRTUALBOX_WITH_XORG" = "1" || VIRTUALBOX_WITHOUT_XORG=--nox11
wget http://download.virtualbox.org/virtualbox/$VBOX_VER/VBoxGuestAdditions_$VBOX_VER.iso
mount -t iso9660 VBoxGuestAdditions_$VBOX_VER.iso /media/cdrom0
if { yes | /media/cdrom0/VBoxLinuxAdditions.run "$@" $VIRTUALBOX_WITHOUT_XORG; }; then
    :
else
    rc="$?"
    if [ "$rc" = "2" ]; then
        echo "Assume VirtualBox Guest Additions should work after reboot and ignore this error."
    else
        exit $rc
    fi
fi
rm -f VBoxGuestAdditions_*.iso
