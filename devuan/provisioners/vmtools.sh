#!/bin/sh
set -e
set -x

if [ "$VMWARE_WITH_XORG" = "1" ]; then
	if [ "$(cat /etc/devuan_version)" = "jessie" ]; then
		apt-get -y install "${XSERVER_XORG_INPUT_VMMOUSE:-"xserver-xorg-input-vmmouse"}"
	else
		if [ -n "$XSERVER_XORG_INPUT_VMMOUSE" ]; then
			apt-get -y install "$XSERVER_XORG_INPUT_VMMOUSE" || true
		fi
	fi
	apt-get -y install \
		"${OPEN_VM_TOOLS_DESKTOP:-"open-vm-tools-desktop"}" \
		"${XSERVER_XORG_VIDEO_VMWARE:-"xserver-xorg-video-vmware"}" \
		|| true
else
	apt-get -y install "${OPEN_VM_TOOLS:-"open-vm-tools"}" || true
fi
