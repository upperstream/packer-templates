#!/bin/sh
set -e
set -x

if [ ! -f /etc/fuse.conf ]; then
	sudo touch /etc/fuse.conf
	echo "etc/fuse.conf" >> /opt/.filetool.lst
fi
tce-load -wi "${OPEN_VM_TOOLS:-open-vm-tools}"
echo "/usr/local/etc/init.d/open-vm-tools start" | sudo tee -a /opt/bootlocal.sh
