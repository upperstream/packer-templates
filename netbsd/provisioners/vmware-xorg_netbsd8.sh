#!/bin/sh
set -e
set -x

if [ "$(uname -m)" = "i386" ]; then
  { pkg_add ${OPEN_VM_TOOLS:-open-vm-tools} && cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools; } || true
else
  pkg_add ${OPEN_VM_TOOLS:-open-vm-tools}
  cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools
fi

if [ "$XF86_INPUT_VMMOUSE" ]; then
	pkg_add $XF86_INPUT_VMMOUSE
fi
if [ "$XF86_VIDEO_VMWARE" ]; then
	pkg_add $XF86_VIDEO_VMWARE
fi
