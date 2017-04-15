#!/bin/sh -ex
pkg_add slim-${SLIM:-1.3.6p11} slim-themes-${SLIM_THEMES:-1.2.3p5} dwm-${DWM:-6.1p0} dmenu-${DMENU:-4.6} st-${ST:-0.7}
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

cat << EOF > /home/$VAGRANT_USER/.xinitrc
st &
exec dwm
EOF
cat > /home/$VAGRANT_USER/.xsession << EOF
#!/bin/sh
st &
exec dwm
EOF

sed -i.orig '/current_theme/s/default/openbsd-simple/' /etc/slim.conf
