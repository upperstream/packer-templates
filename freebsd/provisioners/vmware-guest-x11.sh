#!/bin/sh -x
pkg install -y open-vm-tools-1280544_12,1

cat >> /etc/rc.conf << EOF
hald_enable="YES"
dbus_enable="YES"
moused_enable="YES"
vmware_guest_vmblock_enable="YES"
vmware_guest_vmhgfs_enable="YES"
vmware_guest_vmmemctl_enable="YES"
vmware_guest_vmxnet_enable="YES"
vmware_guestd_enable="YES"
EOF

pkg install -y xf86-video-vmware-13.1.0 xf86-input-vmmouse-13.1.0

cat >> /etc/X11/xorg.conf << EOF
Section "ServerLayout"
	Identifier "Layout0"
	Screen 0 "Screen0" 0 0
	InputDevice "Keyboard0" "CoreKeyboard"
	InputDevice "Mouse0" "CorePointer"
EndSection

Section "Device"
	Identifier "Card0"
	Driver "vmware"
EndSection

Section "InputDevice"
	Identifier "Keyboard0"
	Driver "keyboard"
EndSection

Section "InputDevice"
	Identifier "Mouse0"
	Driver "vmmouse"
EndSection
EOF

cat > /usr/local/etc/X11/xorg.conf.d/mouse.conf << EOF
Section "InputClass"
	Identifier "Mouse Defaults"
	Driver "vmmouse"
	MatchIsPointer "on"
EndSection
EOF
