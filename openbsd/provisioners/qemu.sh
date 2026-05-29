#!/bin/sh -eux
pkg_add "${QEMU_GA:-qemu-ga-10.2.1}"
rcctl enable qemu_ga
rcctl set qemu_ga flags "-t /var/run/qemu-ga \
	-f /var/run/qemu-ga/qemu-ga.pid -m isa-serial -p /dev/cua00"
rcctl start qemu_ga
