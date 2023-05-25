#!/bin/sh
set -e
set -u
set -x

echo "kern.hz=100" >> /boot/loader.conf
if [ "${PARALLELS_WITH_XORG:-""}" = "yes" ]; then
	echo 'ums_load="YES"' >> /boot/loader.conf
	if [ "${XF86_VIDEO_SCFB:-""}" ]; then
		pkg install -y "$XF86_VIDEO_SCFB"
	fi
fi

