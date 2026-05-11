#!/bin/sh -ex
apt-get install -y ${QEMU_GUEST_AGENT:-qemu-guest-agent}
systemctl enable qemu-guest-agent
systemctl start qemu-guest-agent
