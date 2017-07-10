#!/bin/sh -ex
sed -i '/edge\/community/s/^#//' /etc/apk/repositories
sed -i '/edge\/main/s/^#//' /etc/apk/repositories
HOST=$(grep '/main$' /etc/apk/repositories | head -1)
if ! ( grep -q "^http.*/edge/main$" /etc/apk/repositories ); then
  echo $HOST | sed 's%\(.*\)/\(.*\)/main$%\1/edge/main%' >> /etc/apk/repositories
fi
if ! ( grep -q "^http.*/edge/community" /etc/apk/repositories ); then
  echo $HOST | sed 's%\(.*\)/\(.*\)/main$%\1/edge/community%' >> /etc/apk/repositories
fi
apk --update add docker
sysctl -w kernel.grsecurity.chroot_deny_chmod=0
sysctl -w kernel.grsecurity.chroot_deny_mknod=0
apk add py-pip
pip install docker-compose
rc-update add docker boot
adduser ${VAGRANT_USERNAME:-vagrant} docker
