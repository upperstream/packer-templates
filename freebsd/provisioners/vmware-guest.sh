#!/bin/sh

set -e
set -x

if [ "$VMWARE_WITH_XORG" = "1" ]; then

pkg install -y ${OPEN_VM_TOOLS:-"open-vm-tools"} ${XF86_VIDEO_VMWARE:-"xf86-video-vmware"} ${XF86_INPUT_VMMOUSE:-"xf86-input-vmmouse"}

cat >> /etc/rc.conf << EOF
hald_enable="YES"
dbus_enable="YES"
moused_enable="YES"
EOF

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

else

pkg install -y ${OPEN_VM_TOOLS:-"open-vm-tools-nox11"}

fi

cat >> /etc/rc.conf << EOF
vmware_guest_vmblock_enable="YES"
vmware_guest_vmhgfs_enable="YES"
vmware_guest_vmmemctl_enable="YES"
vmware_guest_vmxnet_enable="YES"
vmware_guestd_enable="YES"
EOF
