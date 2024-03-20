#!/bin/sh
set -e
set -x

pkg_add "${DWM:-dwm}" "${DMENU:-dmenu}" "${ST_TERM:-"st-term"}" "${XRANDR:-xrandr}" "${X11VNC:-x11vnc}"

cp /etc/X11/xdm/Xresources /tmp/Xresources
sed 's/^XConsole\(.*\)/!XConsole\1/' /tmp/Xresources > /etc/X11/xdm/Xresources
rm /tmp/Xresources
cp /etc/X11/xdm/xdm-config /tmp/xdm-config
sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/' /tmp/xdm-config > /etc/X11/xdm/xdm-config
rm /tmp/xdm-config
echo "DisplayManager*authName:        MIT-MAGIC-COOKIE-1" >> /etc/X11/xdm/xdm-config

cat > /home/"${VAGRANT_USER:=vagrant}"/.xinitrc << EOF
#!/bin/sh
st &
exec dwm
EOF
cat > /home/"$VAGRANT_USER"/.xsession << EOF
#!/bin/sh
. /home/"$VAGRANT_USER"/.xinitrc
EOF
chown "$VAGRANT_USER":"${VAGRANT_GROUP:-vagrant}" /home/"$VAGRANT_USER"/.xinitrc /home/"$VAGRANT_USER"/.xsession
chmod +x /home/"$VAGRANT_USER"/.xsession
