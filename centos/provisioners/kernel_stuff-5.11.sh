KERNEL_VERSION=$(uname -r)
DISTRO_VERSION=$(cut -d' ' -f3 /etc/redhat-release)
HARDWARE=$(uname -i)
PROCESSOR=$(uname -p)
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/$DISTRO_VERSION/os/$HARDWARE/CentOS/kernel-headers-$KERNEL_VERSION.$HARDWARE.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/$DISTRO_VERSION/os/$HARDWARE/CentOS/kernel-devel-$KERNEL_VERSION.$PROCESSOR.rpm
