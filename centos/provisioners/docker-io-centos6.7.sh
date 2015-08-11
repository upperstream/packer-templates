# docker-io
yum -y install initscripts-9.03.49-1.el6.centos
yum -y install glibc-2.12-1.166.el6_7.3
yum -y install sqlite-3.6.20-1.el6
yum -y install device-mapper-libs-1.02.95-3.el6_7.3
yum -y install device-mapper-event-libs-1.02.95-3.el6_7.3
yum -y install device-mapper-event-1.02.95-3.el6_7.3
yum -y install device-mapper-1.02.95-3.el6_7.3
yum -y install libcgroup-0.40.rc1-16.el6
yum -y install lxc-libs-1.0.7-2.el6
yum -y install lua-filesystem-1.4.2-1.el6
yum -y install lua-lxc-1.0.7-2.el6
yum -y install lua-alt-getopt-0.7.0-1.el6
yum -y install lxc-1.0.7-2.el6
yum -y install bridge-utils-1.2-10.el6
yum -y install bash-4.1.2-33.el6
yum -y install xz-libs-4.999.9-0.5.beta.20091007git.el6
yum -y install xz-4.999.9-0.5.beta.20091007git.el6
yum -y install chkconfig-1.3.49.3-5.el6
yum -y install --enablerepo epel docker-io-1.7.1-2.el6
groupadd docker
usermod -a -G docker vagrant
/etc/init.d/cgred stop
/etc/init.d/cgconfig stop
/etc/init.d/cgconfig start
/etc/init.d/cgred start
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
