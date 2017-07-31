#!/bin/sh
set -e
set -x

zypper --non-interactive install ${OPEN_VM_TOOLS:-open-vm-tools}
test -z "$VMWARE_TOOLS_WITH_X11" || zypper --non-interactive install ${OPEN_VM_TOOLS_DESKTOP:-open-vm-tools-desktop}
