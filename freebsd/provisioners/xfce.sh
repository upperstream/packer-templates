#!/bin/sh -e -x
pkg install -y xfce-4.12_1 slim-1.3.6_12 slim-themes-1.0.1_1 arandr-0.1.7.1_2
echo 'slim_enable="YES"' >> /etc/rc.conf

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

pw groupmod wheel -m $VAGRANT_USER

cat >> /etc/X11/xorg.conf << EOF

Section "Module"
	Load "freetype"
EndSection

Section "Files"
	FontPath "/usr/local/share/fonts/dejavu/"
EndSection
EOF

echo "exec /usr/local/bin/startxfce4 --with-ck-launch" > /home/$VAGRANT_USER/.xinitrc
cat > /home/$VAGRANT_USER/.xsession << EOF
#!/bin/sh
exec /usr/local/bin/startxfce4 --with-ck-launch
EOF

sed -i .orig '/current_theme/s/default/fbsd/' /usr/local/etc/slim.conf
