#!/bin/sh -ex
apt-get install -y curl rsync
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
