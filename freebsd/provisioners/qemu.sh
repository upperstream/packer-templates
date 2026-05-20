#!/bin/sh
set -e
set -x
if pkg install -y "${QEMU_GUEST_AGENT:-qemu-guest-agent-10.2.2}"; then
	cat <<-EOF >> /etc/rc.conf
		qemu_guest_agent_enable="YES"
		qemu_guest_agent_flags="-d -v -l /var/log/qemu-ga.log"
	EOF
	service qemu-guest-agent start || true
fi

if [ "$QEMU_WITH_XORG" = "yes" ]; then
	pkg install -y "${XF86_VIDEO:-xf86-video-vesa}"
fi
