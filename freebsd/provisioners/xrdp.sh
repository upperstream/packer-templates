#!/bin/sh -ex
test -z "$XRDP" & XRDP=xrdp-0.6.1_7,1
pkg install -y $XRDP
cat >> /etc/rc.conf << EOF
xrdp_enable="YES"
xrdp_sesman_enable="YES"
EOF
