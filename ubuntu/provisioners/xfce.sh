#!/bin/sh
set -x
set -e
apt-get update
apt-get -y install xfce4 xfce4-goodies lightdm lightdm-gtk-greeter

cat > /usr/share/X11/xorg.conf.d/20-server.conf <<EOF
Section "Device"
	Identifier "modeset"
	Driver "modesetting"
	Option "AccelMethod" "None"
EndSection
EOF

if ! grep '\[Seat:\*]' /etc/lightdm/lightdm.conf 2>/dev/null; then
	cat > /etc/lightdm/lightdm.conf <<-'EOF'
	[Seat:*]
	greeter-session=lightdm-gtk-greeter
EOF
fi
