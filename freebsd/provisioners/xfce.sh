#!/bin/sh
set -x
set -e

pkg install -y ${XFCE:-"xfce-4.12_1"} ${ARANDR:-"arandr-0.1.7.1_2"}

cat >> /usr/local/etc/polkit-1/rules.d/10-restart.rules << EOF
polkit.addRule(function (action, subject) {
if (action.id == "org.freedesktop.consolekit.system.restart" ||
action.id == "org.freedesktop.consolekit.system.stop"
&& subject.isInGroup("wheel")) {
return polkit.Result.YES;
}
});
EOF

cat >> /usr/local/etc/polkit-1/rules.d/11-suspend.rules << EOF
polkit.addRule(function (action, subject) {
if (action.id == "org.freedesktop.consolekit.system.suspend"
&& subject.isInGroup("wheel")) {
return polkit.Result.YES;
}
});
EOF

pw groupmod wheel -m ${VAGRANT_USER:=vagrant}

cat >> /etc/X11/xorg.conf << EOF

Section "Module"
	Load "freetype"
EndSection

Section "Files"
	FontPath "/usr/local/share/fonts/dejavu/"
EndSection
EOF

echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > /home/$VAGRANT_USER/.xinitrc
chown $VAGRANT_USER:${VAGRANT_GROUP:=vagrant} /home/$VAGRANT_USER/.xinitrc

cat > /home/$VAGRANT_USER/.xsession << EOF
#!/bin/sh
exec /usr/local/bin/startxfce4 --with-ck-launch
EOF
chown $VAGRANT_USER:$VAGRANT_GROUP /home/$VAGRANT_USER/.xsession
chmod +x /home/$VAGRANT_USER/.xsession
