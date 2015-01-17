KERNEL_VERSION=$(uname -r)
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.6/os/i386/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.6/os/i386/Packages/kernel-devel-$KERNEL_VERSION.rpm
