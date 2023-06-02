#!/bin/sh -ex
sed -i "/${OS_VER:-edge}\/community/s/^# *//" /etc/apk/repositories
if command -v setup-desktop > /dev/null; then
	setup-desktop xfce
else
	apk add --no-cache "${XFCE:-xfce4}"
fi
apk add --no-cache "${XRANDR:-xrandr}" "${XRDP:-xrdp}"
