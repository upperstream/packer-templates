KERNEL_VERSION=$(uname -r)
DISTRO_VERSION=$(cut -d' ' -f3 /etc/redhat-release)
HARDWARE=$(uname -i)
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/$DISTRO_VERSION/os/$HARDWARE/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/$DISTRO_VERSION/os/$HARDWARE/Packages/kernel-devel-$KERNEL_VERSION.rpm
