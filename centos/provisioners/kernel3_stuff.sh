KERNEL_VERSION=$(uname -r)
yum install -y --enablerepo elrepo-kernel kernel-lt-headers-$KERNEL_VERSION kernel-lt-devel-$KERNEL_VERSION
