KERNEL_VERSION=$(uname -r)
VBOX_VERSION=$(cat /root/.vbox_version)

rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-devel-$KERNEL_VERSION.rpm

yum -y install yum-plugin-priorities-1.1.30-30.el6
rpm -U http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y --enablerepo epel install dkms-2.2.0.3-28.git.7c3e7c5.el6
yum -y install gcc-4.4.7-11.el6 make-3.81-20.el6 perl-5.10.1-136.el6_6.1

cd /tmp
mount -o loop /root/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /root/VBoxGuestAdditions_*.iso
