#!/bin/sh
set -e
set -x

# XORG_FONTS is optional
pkg install -y ${XORG_MINIMAL:-"xorg-minimal"} ${XRANDR:-xrandr} ${XORG_FONTS-}
pw groupmod video -m ${VAGRANT_USER:=vagrant} || pw groupmod wheel -m $VAGRANT_USER
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

pkg install -y ${ARANDR:-arandr} ${DWM:-dwm} ${STERM:-sterm} ${DMENU:-dmenu} ${NCURSES:-ncurses}

for t in st st-256color; do infocmp -C $t >> /usr/share/misc/termcap; done
cap_mkdb /usr/share/misc/termcap

cat >> /etc/X11/xorg.conf << EOF

Section "Module"
	Load "freetype"
EndSection

Section "Files"
	FontPath "/usr/local/share/fonts/dejavu/"
EndSection
EOF

cat > /home/$VAGRANT_USER/.xinitrc << EOF
st &
exec dwm
EOF
chown $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.xinitrc
