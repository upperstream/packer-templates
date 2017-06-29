#!/bin/sh -ex
pkg install -y ${DOCKER_FREEBSD:-"docker-freebsd-20150625"}
echo "fdesc                   /dev/fd         fdescfs rw              0       0" >> /etc/fstab
mount fdesc
zfs create -o mountpoint=/usr/docker zroot/docker
sysrc -f /etc/rc.conf docker_enable="YES"
service docker start
while ! service docker status; do sleep 10; done
mkdir -p /usr/local/bin
docker run --rm jpetazzo/nsenter cat /nsenter > /usr/local/bin/nsenter && chmod +x /usr/local/bin/nsenter && strip /usr/local/bin/nsenter
fetch -o /usr/local/bin/docker-enter https://raw.githubusercontent.com/jpetazzo/nsenter/master/docker-enter
chmod +x /usr/local/bin/docker-enter
pkg install -y ${PY27_PIP:-"py27-pip-8.0.2"}
pip install ${DOCKER_COMPOER:-"docker-compose==1.3.3"}
