#!/bin/sh -ex

if [ "$VMWARE_WITH_XORG" = "1" ]; then

	pkg install -y "${OPEN_VM_TOOLS:-"open-vm-tools"}" "$XF86_VIDEO_VMWARE" "$XF86_INPUT_VMMOUSE"

	cat >> /etc/rc.conf <<-EOF
		hald_enable="YES"
		dbus_enable="YES"
		moused_enable="YES"
	EOF

	cat >> /etc/X11/xorg.conf <<-EOF
	Section "ServerLayout"
		Identifier "Layout0"
		Screen 0 "Screen0" 0 0
		InputDevice "Keyboard0" "CoreKeyboard"
		InputDevice "Mouse0" "CorePointer"
	EndSection

	Section "InputDevice"
		Identifier "Keyboard0"
		Driver "keyboard"
	EndSection
	EOF

	if [ "$XF86_VIDEO_VMWARE" ]; then
		cat >> /etc/X11/xorg.conf <<-EOF
		Section "Device"
			Identifier "Card0"
			Driver "vmware"
		EndSection

		Section "Device"
			Identifier  "VMware Virtual Display"
			Driver      "${VMWARE_VIDEO_DRIVER:-vmware}"
		EndSection
		EOF
	fi

	if [ "$XF86_INPUT_VMMOUSE" ]; then
		cat >> /etc/X11/xorg.conf <<-EOF
		Section "InputDevice"
			Identifier "Mouse0"
			Driver "${VMWARE_MOUSE_DRIVER:=vmmouse}"
		EndSection
		EOF

		cat > /usr/local/etc/X11/xorg.conf.d/mouse.conf <<-EOF
		Section "InputClass"
			Identifier "Mouse Defaults"
			Driver "$VMWARE_MOUSE_DRIVER"
			MatchIsPointer "on"
		EndSection
		EOF
	fi

else

	pkg install -y "${OPEN_VM_TOOLS:-"open-vm-tools-nox11"}"

fi

cat >> /etc/rc.conf << EOF
vmware_guest_vmblock_enable="YES"
vmware_guest_vmhgfs_enable="YES"
vmware_guest_vmmemctl_enable="YES"
vmware_guest_vmxnet_enable="YES"
vmware_guestd_enable="YES"
EOF
