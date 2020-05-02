#!/bin/sh
set -e
set -x

sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk add ${OPEN_VM_TOOLS:-open-vm-tools}
rc-update add open-vm-tools default
