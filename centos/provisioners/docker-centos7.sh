#!/bin/sh -ex
yum -y install xz-5.1.2-8alpha.el7 glibc-2.17-55.el7_0.3 sqlite-3.7.17-4.el7 device-mapper-libs-1.02.84-14.el7
cd /; curl https://get.docker.com/builds/Linux/x86_64/docker-1.6.0.tgz | tar zxvf -
groupadd docker
usermod -a -G docker vagrant
curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
