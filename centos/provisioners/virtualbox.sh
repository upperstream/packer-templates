# Virtualbox
# Depends: kernel-stuff, epel
test -z "$GCC" && GCC=gcc
test -z "$PERL" && PERL=perl
yum -y install $PERL $GCC

VBOX_VERSION=$(cat /root/.vbox_version)

yum -y --enablerepo epel install dkms

cd /tmp
mount -o loop /root/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /root/VBoxGuestAdditions_*.iso

yum -y erase perl gcc
