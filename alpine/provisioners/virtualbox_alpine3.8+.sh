#!/bin/sh
set -e
set -x

sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk add --no-cache ${VIRTUALBOX_GUEST_ADDITIONS:-virtualbox-guest-additions}
if [  `uname -m` = "x86_64" ]; then
	if [ "${VIRTUALBOX_WITH_X11:=false}" = "true" ]; then
		apk add --no-cache ${VIRTUALBOX_GUEST_MODULES_LTS:-virtualbox-guest-modules-lts} ${VIRTUALBOX_GUEST_ADDITIONS_X11:-virtualbox-guest-additions-x11}
	else
		apk add --no-cache ${VIRTUALBOX_GUEST_MODULES_VIRT:-virtualbox-guest-modules-virt}
	fi
	modprobe -a vboxsf
else
	if [ "${VIRTUALBOX_WITH_X11:=false}" = "true" ]; then
		apk add --no-cache ${VIRTUALBOX_GUEST_ADDITIONS_X11:-virtualbox-guest-additions-x11}
	fi
fi
