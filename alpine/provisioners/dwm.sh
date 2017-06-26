#!/bin/sh -ex
setup-xorg-base \
  xorg-server xf86-video-vesa xf86-input-evdev xf86-input-mouse \
  xf86-input-keyboard udev xinit
apk add ${DWM:-dwm} ${ST:st} ${DMENU:-dmenu} ${XRANDR:-xrandr} ${XRDP:-xrdp}
cat << EOF > /home/${VAGRANT_USERNAME:=vagrant}/.xinitrc
#!/bin/sh
st &
exec dwm
EOF
chown $VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
