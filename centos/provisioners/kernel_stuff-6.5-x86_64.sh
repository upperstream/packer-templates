KERNEL_VERSION=$(uname -r)
rpm -iv http://vault.centos.org/6.5/os/x86_64/Packages/kernel-headers-$KERNEL_VERSION.rpm
rpm -iv http://vault.centos.org/6.5/os/x86_64/Packages/kernel-devel-$KERNEL_VERSION.rpm
