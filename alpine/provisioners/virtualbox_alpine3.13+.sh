#!/bin/sh
set -e
set -x

sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk add --no-cache ${VIRTUALBOX_GUEST_ADDITIONS:-virtualbox-guest-additions}
if [ "${VIRTUALBOX_WITH_X11:=false}" = "true" ]; then
	apk add --no-cache ${VIRTUALBOX_GUEST_ADDITIONS_X11:-virtualbox-guest-additions-x11}
fi
modprobe -a vboxsf
