#!/bin/sh
set -e
set -x
pkg_add "${SLIM:-slim}" "${SLIM_THEMES:-slim-themes}" "${DWM:-dwm}" "${DMENU:-dmenu}" "${ST:-st}"
echo '/usr/local/bin/slim -d' >> /etc/rc.local

cat >> /etc/rc.conf.local << EOF
pkg_scripts="dbus_daemon avahi_daemon"
dbus_enable=YES
multicast_host=YES
hotplugd_flags=""    ## needed to start hotplugd for toad
apmd_flags="-A"      ## enables suspend and power mgmt
# messagebus is the new name for dbus_daemon in 5.8
pkg_scripts="${pkg_scripts} messagebus toadd slim"
EOF

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

sed -i.orig '/current_theme/s/default/openbsd-simple/' /etc/slim.conf
