#!/bin/sh -ex
apt-get -y install rsync
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
