KERNEL_VERSION=$(uname -r)
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-devel-$KERNEL_VERSION.rpm

yum -y install yum-plugin-priorities
rpm -U http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y --enablerepo epel install dkms
yum -y groupinstall "Development Tools"

cd /tmp
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_*.iso
