#!/bin/sh
set -e
set -x

(cd /tmp; wget -O - https://get.docker.com/builds/Linux/x86_64/${DOCKER:-docker-17.05.0-ce}.tgz | tar zxf - && mv docker/* /usr/bin/)
apt-get -y install aufs-tools
groupadd docker
usermod -a -G docker ${VAGRANT_USERNAME:-vagrant}
sed 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LUNIX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub > /tmp/grub
mv /tmp/grub /etc/default/grub
update-grub
reboot
echo "GRUB updated; VM will reboot soon."
sleep 60
