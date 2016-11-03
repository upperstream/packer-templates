#!/bin/sh -ex
test -z "$OPEN_VM_TOOLS" && OPEN_VM_TOOLS=open-vm-tools
test -z "$XF86_INPUT_VMMOUSE" && XF86_INPUT_VMMOUSE=xf86-input-vmmouse
test -z "$XF86_VIDEO_VMWARE" && XF86_VIDEO_VMWARE=xf86-video-vmware
pkg_add $OPEN_VM_TOOLS $XF86_INPUT_VMMOUSE $XF86_VIDEO_VMWARE
cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools
