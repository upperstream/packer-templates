#!/bin/sh
set -e
set -x

apt-get install -y "${OPEN_VM_TOOLS:-open-vm-tools}"
if [ "$VMWARE_WITH_XORG" = "1" ]; then
	# shellcheck disable=SC2006
	case "`uname -m`" in
		amd64|i386) apt-get install -y "${XSERVER_XORG_VIDEO_VMWARE:-xserver-xorg-video-vmware}";;
		*) : ;;
	esac
	apt-get -y install \
	"${XSERVER_XORG_INPUT_VMMOUSE:-xserver-xorg-input-vmmouse}"
fi
