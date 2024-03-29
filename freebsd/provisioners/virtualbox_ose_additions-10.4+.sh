#!/bin/sh
set -e
set -x

if ! pkg search "${VIRTUALBOX_OSE_ADDITIONS:="virtualbox-ose-additions-4.3.38"}" 2>/dev/null; then
	exit
fi
pkg install -y "$VIRTUALBOX_OSE_ADDITIONS"
cat >> /etc/rc.conf << EOF
hald_enable="YES"
dbus_enable="YES"
vboxguest_enable="YES"
vboxservice_enable="YES"
EOF

test "${VIRTUALBOX_WITH_XORG:-true}" = "true" || exit 0

cat >> /etc/X11/xorg.conf << EOF
Section "Device"
	Identifier "Card0"
	Driver "vboxvideo"
	VendorName "InnoTek Systemberatung GmbH"
	BoardName "VirtualBox Graphics Adapter"
EndSection

Section "InputDevice"
	Identifier "Mouse0"
	Driver "vboxmouse"
EndSection
EOF

mkdir -p /usr/local/etc/hal/fdi/policy
cat > /usr/local/etc/hal/fdi/policy/90-vboxguest.fdi << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!--
# Sun VirtualBox
# Hal driver description for the vboxmouse driver
# $Id: 90-vboxguest.fdi 21412 2009-07-08 21:18:57Z vboxsync $

     Copyright (C) 2008-2009 Sun Microsystems, Inc.

     This file is part of VirtualBox Open Source Edition (OSE), as
     available from http://www.virtualbox.org. This file is free software;
     you can redistribute it and/or modify it under the terms of the GNU
     General Public License (GPL) as published by the Free Software
     Foundation, in version 2 as it comes in the "COPYING" file of the
     VirtualBox OSE distribution. VirtualBox OSE is distributed in the
     hope that it will be useful, but WITHOUT ANY WARRANTY of any kind.

     Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
     Clara, CA 95054 USA or visit http://www.sun.com if you need
     additional information or have any questions.
-->
<deviceinfo version="0.2">
  <device>
    <match key="info.subsystem" string="pci">
      <match key="info.product" string="VirtualBox Guest Service">
        <append key="info.capabilities" type="strlist">input</append>
        <append key="info.capabilities" type="strlist">input.mouse</append>
        <merge key="input.x11_driver" type="string">vboxmouse</merge>
        <merge key="input.device" type="string">/dev/vboxguest</merge>
      </match>
    </match>
  </device>
</deviceinfo>
EOF
