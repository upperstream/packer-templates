#!/bin/sh -ex
if [ "$VMWARE_WITH_XORG" = "1" ]; then
  apt-get -y install \
    ${OPEN_VM_TOOLS_DESKTOP:-"open-vm-tools-desktop"} \
    ${XSERVER_XORG_VIDEO_VMWARE:-"xserver-xorg-video-vmware"} \
    ${XSERVER_XORG_INPUT_VMMOUSE:-"xserver-xorg-input-vmmouse"}
else
  apt-get -y install ${OPEN_VM_TOOLS:-"open-vm-tools"}
fi
