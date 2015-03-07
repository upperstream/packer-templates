wget http://download.virtualbox.org/virtualbox/$VBOX_VER/VBoxGuestAdditions_$VBOX_VER.iso
mount -t iso9660 VBoxGuestAdditions_$VBOX_VER.iso /media/cdrom0
yes | /media/cdrom0/VBoxLinuxAdditions.run --nox11 || (cat /var/log/vboxadd-install.log && cat /var/lib/dkms/vboxguest/$VBOX_VER/build/make.log)
rm -f VBoxGuestAdditions_*.iso
