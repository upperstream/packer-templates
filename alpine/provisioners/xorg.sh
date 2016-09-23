#!/bin/sh -ex
setup-xorg-base \
  xorg-server xf86-video-vesa xf86-input-evdev xf86-input-mouse \
  xf86-input-keyboard udev xinit
if [ -z "$DWM" ]; then DWM=dwm; fi
if [ -z "$ST" ]; then ST=st; fi
if [ -z "$DMENU" ]; then DMENU=dmenu; fi
if [ -z $"XRANDR" ]; then XRANDR=xrandr; fi
if [ -z $"XRDP" ]; then XRDP=xrdp; fi
apk add $DWM $ST $DMENU $XRANDR $XRDP
cat << EOF > /home/$VAGRANT_USERNAME/.xinitrc
#!/bin/sh
st &
exec dwm
EOF
chmod +x /home/$VAGRANT_USERNAME/.xinitrc
chown $VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
