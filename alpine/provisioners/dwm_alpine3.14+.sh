#!/bin/sh -ex
setup-xorg-base \
  xorg-server "${XF86_VIDEO:-xf86-video-vesa}" xf86-input-evdev udev xinit
sed -i "/${OS_VER:-edge}\/community/s/^#/ */" /etc/apk/repositories
apk add "${DWM:-dwm}" "${ST:-st}" "${DMENU:-dmenu}" "${XRANDR:-xrandr}" "${XRDP:-xrdp}"
cat << EOF > /home/"${VAGRANT_USERNAME:=vagrant}"/.xinitrc
#!/bin/sh
st &
exec dwm
EOF
chown "$VAGRANT_USERNAME" /home/"$VAGRANT_USERNAME"/.xinitrc
