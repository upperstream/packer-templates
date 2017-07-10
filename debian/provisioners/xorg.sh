#!/bin/sh -ex
apt-get -y install ${XORG:-xorg} ${DWM:-dwm} ${STTERM:-stterm} ${SUCKLESS_TOOLS:-"suckless-tools"} ${ARANDR:-arandr} ${SLIM:-slim}

#apt-get -y install lxrandr=0.3.0-1
#apt-get -y install x11-xserver-utils=7.7+3+b1

cat > /home/$VAGRANT_USERNAME/.xinitrc << EOF
#!/bin/sh
stterm &
exec dwm
EOF
chown $VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
chmod +x /home/$VAGRANT_USERNAME/.xinitrc
