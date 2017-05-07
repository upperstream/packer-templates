# docker-io
yum -y install device-mapper-${DEVICE_MAPPER:-1.02.117-12.el6}
yum -y install --enablerepo epel docker-io-${DOCKER_IO:-1.7.1-2.el6}
groupadd docker
usermod -a -G docker vagrant
/etc/init.d/cgred stop
/etc/init.d/cgconfig stop
/etc/init.d/cgconfig start
/etc/init.d/cgred start
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
