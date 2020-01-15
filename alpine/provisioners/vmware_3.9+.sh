#!/bin/sh
set -e
set -x

sed -i "/${OS_VEr:-edge}\/community/s/^#//" /etc/apk/repositories
apk add open-vm-tools
rc-update add open-vm-tools default
