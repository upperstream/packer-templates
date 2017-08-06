#!/bin/sh -x
pkg_add ${DWM:-dwm} ${DMENU:-dmenu} ${ST_TERM:-"st-term"} ${FREETYPE2:-freetype2} ${FONTCONFIG:-fontconfig} ${XFT2:-Xft2}
#echo "xdm=YES" >> /etc/rc.conf
cp /etc/X11/xdm/Xresources /tmp/Xresources
sed 's/^XConsole\(.*\)/!XConsole\1/' /tmp/Xresources > /etc/X11/xdm/Xresources
rm /tmp/Xresources
cp /etc/X11/xdm/xdm-config /tmp/xdm-config
sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/' /tmp/xdm-config > /etc/X11/xdm/xdm-config
rm /tmp/xdm-config
cat > /home/${VAGRANT_USER:=vagrant}/.xinitrc << EOF
#!/bin/sh
st &
exec dwm
EOF
cat > /home/$VAGRANT_USER/.xsession << EOF
#!/bin/sh
. /home/$VAGRANT_USER/.xinitrc
EOF
chown $VAGRANT_USER /home/$VAGRANT_USER/.xinitrc /home/$VAGRANT_USER/.xsession
chmod +x /home/$VAGRANT_USER/.xsession
