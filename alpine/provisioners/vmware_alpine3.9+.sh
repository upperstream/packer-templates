#!/bin/sh
set -e
set -x

if [ "${OS_VER:=edge}" != "v3.13" ] || [ "${CPU:-x86_64}" != "x86" ]; then
	sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
	{ apk add ${OPEN_VM_TOOLS:-open-vm-tools} && rc-update add open-vm-tools default; } || true
fi
