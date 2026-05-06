#!/bin/sh -ex
pkg install -y "${XRDP:-"xrdp-0.6.1_7,1"}"
cat >> /etc/rc.conf << EOF
xrdp_enable="YES"
xrdp_sesman_enable="YES"
EOF

if [ -n "$XORGXRDP" ]; then
	pkg install -y "$XORGXRDP"
fi
