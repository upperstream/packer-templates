#!/bin/sh -ex
apt-get -y install ${XORG:-xorg} ${DWM:-dwm} ${STTERM:-stterm} ${SUCKLESS_TOOLS:-"suckless-tools"} ${ARANDR:-arandr}

cat > /home/${VAGRANT_USERNAME:=vagrant}/.xinitrc << EOF
#!/bin/sh
stterm &
exec dwm
EOF
chown $VAGRANT_USERNAME:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USERNAME/.xinitrc
