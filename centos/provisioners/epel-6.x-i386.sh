# EPEL
yum -y install yum-plugin-priorities-1.1.30-30.el6
if ! (md5sum epel-release-6-8.noarch.rpm | grep 2cd0ae668a585a14e07c2ea4f264d79b); then
  curl -O http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
fi
rpm -ivh epel-release-6-8.noarch.rpm
