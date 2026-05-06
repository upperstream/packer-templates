#!/bin/sh
set -x
set -e

pkg install -y \
	"${XORG_MINIMAL:="xorg-minimal"}" \
	"${XTERM:-"xterm"}" \
	"${XCLOCK:-"xclock"}" \
	"${TWM:-"twm"}" \
	"${XRANDR:-"xrandr"}"

pw groupmod video -m "${VAGRANT_USER:=vagrant}" || \
	pw groupmod wheel -m "$VAGRANT_USER"
echo "kern.vty=vt" >> /boot/loader.conf
cat >> /usr/local/etc/X11/xorg.conf.d/screen-resolutions.conf << EOF
Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	SubSection "Display"
		Modes      "1024x768"
		Modes      "1152x864"
		Modes      "1280x768"
		Modes      "1280x1024"
		Modes      "1920x1080"
	EndSubSection
EndSection
EOF
sysctl kern.evdev.rcpt_mask=6
echo "kern.evdev.rcpt_mask=6" >> /etc/sysctl.conf
