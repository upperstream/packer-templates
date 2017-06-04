#!/bin/sh -ex
apt-get -y install ${OPEN_VM_TOOLS:-"open-vm-tools"}
if [ "$VMWARE_WITH_XORG" = "1" ]; then
  apt-get -y install ${XSERVER_XORG_VIDEO_VMWARE:-"xserver-xorg-video-vmware"} ${XSERVER_XORG_INPUT_VMMOUSE:-"xserver-xorg-input-vmmouse"}
fi
