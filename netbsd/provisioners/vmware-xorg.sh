#!/bin/sh
set -e
set -x

if [ "$(uname -m)" = "i386" ]; then
  { pkg_add ${OPEN_VM_TOOLS:-open-vm-tools} && cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools; } || true
else
  pkg_add ${OPEN_VM_TOOLS:-open-vm-tools}
  cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools
fi

pkg_add ${XF86_INPUT_VMMOUSE:-xf86-input-vmmouse} ${XF86_VIDEO_VMWARE:-xf86-video-vmware}
