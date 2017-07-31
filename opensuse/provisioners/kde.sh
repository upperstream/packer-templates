#!/bin/sh
set -e
set -x

chmod +s /var/lib/X11/X
zypper --non-interactive install ${ARANDR:-arandr} ${XRDP:-xrdp}
