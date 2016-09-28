#!/bin/sh -ex
test -z "$XORG_MINIMAL" && XORG_MINIMAL=xorg-minimal
test -z "$XRANDR" && XRANDR=xrandr
test -z "$ARANDR" && ARANDR=arandr
test -z "$DWM" && DWM=dwm
test -z "$STERM" && STERM=sterm
test -z "$DMENU" && DMENU=dmenu

pkg install -y $XORG_MINIMAL $XRANDR
pw groupmod video -m $VAGRANT_USER || pw groupmod wheel -m $VAGRANT_USER
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

pkg install -y $ARNADR $DWM $STERM $DMENU

for t in st st-256color st-meta st-meta-256color; do infocmp -C $t >> /usr/share/misc/termcap; done
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
