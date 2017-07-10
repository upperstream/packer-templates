# python-devel
DISTRO_VERSION=$(cut -d' ' -f3 /etc/redhat-release)
HARDWARE=$(uname -i)
PROCESSOR=$(uname -p)
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-libs-${PYTHON_LIBS:-2.6.6-52.el6}.$PROCESSOR.rpm
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-${PYTHON:-2.6.6-52.el6}.$PROCESSOR.rpm
rpm -ih http://vault.centos.org/$DISTRO_VERSION/os/$HARDWARE/Packages/python-devel-${PYTHON_DEVEL:-2.6.6-52.el6}.$PROCESSOR.rpm
