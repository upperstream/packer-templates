#!/bin/sh
set -e
set -x
yum install -y ${OPEN_VM_TOOLS:-open-vm-tools}
