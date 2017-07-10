yum -y install yum-plugin-priorities-1.1.30-40.el6
rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
yum install -y --enablerepo elrepo-kernel kernel-lt
yum install -y docker-io-1.7.1-2.el6
groupadd docker
usermod -a -G docker vagrant
/etc/init.d/cgred stop
/etc/init.d/cgconfig stop
/etc/init.d/cgconfig start
/etc/init.d/cgred start
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
