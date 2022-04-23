#!/bin/sh
set -e
set -x

cat >> /etc/rc.conf.local << EOF
pkg_scripts="dbus_daemon avahi_daemon"
dbus_enable=YES
multicast_host=YES
hotplugd_flags=""    ## needed to start hotplugd for toad
apmd_flags="-A"      ## enables suspend and power mgmt
EOF

if [ "$SLIM" ]; then
	pkg_add "${SLIM:-slim}" "${SLIM_THEMES:-slim-themes}"
	echo '/usr/local/bin/slim -d' >> /etc/rc.local
	echo 'pkg_scripts="${pkg_scripts} messagebus toadd slim"' >> /etc/rc.conf.local
	sed -i.orig '/current_theme/s/default/openbsd-simple/' /etc/slim.conf
else
	rcctl enable xenodm
	rcctl start xenodm
	sed 's/^XConsole\(.*\)/!XConsole\1/' /etc/X11/xenodm/Xresources > /tmp/Xresources
	mv /tmp/Xresources /etc/X11/xenodm/Xresources
	sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/' /etc/X11/xenodm/xenodm-config > /tmp/xenodm-config
	mv /tmp/xenodm-config /etc/X11/xenodm/xenodm-config
	echo "DisplayManager*authName:        MIT-MAGIC-COOKIE-1" >> /etc/X11/xenodm/xenodm-config
fi
pkg_add "${DWM:-dwm}" "${DMENU:-dmenu}" "${ST:-st}"

cat << EOF > "/home/$VAGRANT_USER/.xinitrc"
st &
exec dwm
EOF
cat > "/home/$VAGRANT_USER/.xsession" << EOF
#!/bin/sh
st &
exec dwm
EOF
chown "$VAGRANT_USER" "/home/$VAGRANT_USER/.xinitrc" "/home/$VAGRANT_USER/.xsession"
