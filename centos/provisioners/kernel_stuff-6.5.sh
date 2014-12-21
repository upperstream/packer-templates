KERNEL_VERSION=$(uname -r)
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://ftp.iij.ad.jp/pub/linux/centos/6.5/os/x86_64/Packages/kernel-devel-$KERNEL_VERSION.rpm
