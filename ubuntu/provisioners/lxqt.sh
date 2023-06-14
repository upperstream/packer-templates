#!/bin/sh
set -x
set -e

apt-get update
apt-get -y install lxqt-core lxqt-session xorg featherpad qterminal lightdm
session_selector=`printf "\n" | update-alternatives --config x-session-manager | sed -n '/\/startlxqt/s/^[ \*]*//p' | sort -k1 -nr | head -n1 | cut -f1 -d' '`
echo $session_selector | update-alternatives --config x-session-manager

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

apt-get remove -y ubuntu-session
apt-get autoremove -y
apt-get purge -y ubuntu-session
