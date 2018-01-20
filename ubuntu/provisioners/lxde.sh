#!/bin/sh
set -x
set -e

apt-get update
apt-get -y install lxde-core
apt-get -y install lxsession-logout
apt-get -y install xorg
apt-get -y install leafpad lxterminal lxinput

cat > /usr/share/X11/xorg.conf.d/20-server.conf <<EOF
Section "Device"
	Identifier "modeset"
	Driver "modesetting"
	Option "AccelMethod" "None"
EndSection
EOF

apt-get -y install lightdm-gtk-greeter

if ! grep '\[Seat:\*]' 2>/dev/null; then
	cat > /etc/lightdm/lightdm.conf <<-'EOF'
	[Seat:*]
	greeter-session=lightdm-gtk-greeter
EOF
fi
