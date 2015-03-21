yum -y install xz-5.1.2-8alpha.el7
yum -y install systemd-208-11.el7_0.6
yum -y install glibc-2.17-55.el7_0.3
yum -y install sqlite-3.7.17-4.el7
yum -y install device-mapper-libs-1.02.84-14.el7
yum -y install bash-4.2.45-5.el7_0.4
yum -y install docker-1.3.2-4.el7.centos
usermod -a -G docker vagrant
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
