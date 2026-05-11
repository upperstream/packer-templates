#!/bin/sh
set -x
set -e

apt-get update
if ! apt-get -y install lxqt lxqt-menu-data sddm-theme-elarun xorg; then
	dpkg -i --force-overwrite /var/cache/apt/archives/lxqt-panel_*.deb || apt-get install -f
fi
session_selector=`printf "\n" | update-alternatives --config x-session-manager | sed -n '/\/startlxqt/s/^[ \*]*//p' | sort -k1 -nr | head -n1 | cut -f1 -d' '`
echo $session_selector | update-alternatives --config x-session-manager
printf "\n" | update-alternatives --config sddm-ubuntu-theme | sed -n '/\/elarun/s/^[ \*]*//p' | sort -k1 -nr | head -n1 | cut -f1 -d' ' | update-alternatives --config sddm-ubuntu-theme

mkdir -p /usr/share/X11/xorg.conf.d
cat > /usr/share/X11/xorg.conf.d/20-server.conf <<EOF
Section "Device"
	Identifier "modeset"
	Driver "modesetting"
	Option "AccelMethod" "None"
EndSection
EOF

systemctl enable sddm

#apt-get -y install lightdm-gtk-greeter

#if ! grep '\[Seat:\*]' /etc/lightdm/lightdm.conf 2>/dev/null; then
#	cat > /etc/lightdm/lightdm.conf <<-'EOF'
#	[Seat:*]
#	greeter-session=lightdm-gtk-greeter
#EOF
#fi

#apt-get remove -y ubuntu-session
#apt-get autoremove -y
#apt-get purge -y ubuntu-session
