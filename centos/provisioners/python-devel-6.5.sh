# python-devel
DISTRO_VERSION=$(cut -d' ' -f3 /etc/redhat-release)
HARDWARE=$(uname -i)
PROCESSOR=$(uname -p)
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-libs-2.6.6-51.el6.$PROCESSOR.rpm
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-2.6.6-51.el6.$PROCESSOR.rpm
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-devel-2.6.6-51.el6.$PROCESSOR.rpm
