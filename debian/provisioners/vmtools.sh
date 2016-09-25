#!/bin/sh -ex
test -z "$OPEN_VM_TOOLS" && OPEN_VM_TOOLS=open-vm-tools
test -z "$XSERVER_XORG_VIDEO_VMWARE" && XSERVER_XORG_VIDEO_VMWARE=xserver-xorg-video-vmware
test -z "$XSERVER_XORG_INPUT_VMMOUSE" && XSERVER_XORG_INPUT_VMMOUSE=xserver-xorg-input-vmmouse

apt-get -y install open-vm-tools
test $VMWARE_WITH_XORG -eq 1 && apt-get -y install $XSERVER_XORG_VIDEO_VMWARE $XSERVER_XORG_INPUT_VMMOUSE 
