#!/bin/sh -ex
test -z "$XORG" && XORG=xorg
test -z "$DWM" && DWM=dwm
test -z "$STTERM" && STTERM=stterm
test -z "$SUCKLESS_TOOLS" && SUCKLESS_TOOLS=suckless-tools
test -z "$ARANDR" && ARANDR=arandr
test -z "$SLIM" && SLIM=slim

apt-get -y install $XORG $DWM $STTERM $SUCKLESS_TOOLS $ARANDR $SLIM

#apt-get -y install lxrandr=0.3.0-1
#apt-get -y install x11-xserver-utils=7.7+3+b1

cat > /home/$VAGRANT_USERNAME/.xinitrc << EOF
#!/bin/sh
stterm &
exec dwm
EOF
chown $VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
chmod +x /home/$VAGRANT_USERNAME/.xinitrc
