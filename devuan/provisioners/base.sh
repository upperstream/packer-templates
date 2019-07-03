#!/bin/sh
set -e
set -x

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

DEVUAN_VERSION=${DEVUAN_VERSION:-jessie}
if [ "${INSTALL_FROM_DVD:-false}" = "true" ]; then
  sed -e "/^#deb cdrom:.*$/a\
\
deb http://auto.mirror.devuan.org/merged $DEVUAN_VERSION main\
deb-src http://auto.mirror.devuan.org/merged $DEVUAN_VERSION main" \
      -e 's/^# deb http:/deb http:/' \
      -e 's/^# deb-src http:/deb-src http:/' /etc/apt/sources.list > /tmp/sources.list
  mv /tmp/sources.list /etc/apt/sources.list
  apt-get update
fi
apt-get -y install rsync
