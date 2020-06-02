#!/bin/sh
set -e
set -x
setup-xorg-base \
  xorg-server xf86-video-vesa xf86-input-evdev xf86-input-mouse \
  xf86-input-keyboard udev xinit
sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk add ${DWM:-dwm} ${ST:st} ${DMENU:-dmenu} ${XRANDR:-xrandr} ${XRDP:-xrdp}
cat << EOF > /home/${VAGRANT_USERNAME:=vagrant}/.xinitrc
#!/bin/sh
st &
exec dwm
EOF
chown $VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
