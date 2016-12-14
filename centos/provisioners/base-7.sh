#!/bin/sh -ex
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
test -z "$SUDO" && SUDO=sudo-1.8.6p7-16.el7
yum -y install $SUDO
