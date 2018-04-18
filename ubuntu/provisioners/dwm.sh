#!/bin/sh
set -e
set -x

apt-get -y install ${XORG:-xorg} ${DWM:-dwm} ${STTERM:-stterm} ${SUCKLESS_TOOLS:-"suckless-tools"} ${ARANDR:-arandr}

#apt-get -y install lxrandr=0.3.0-1
#apt-get -y install x11-xserver-utils=7.7+3+b1

cat > /home/${VAGRANT_USERNAME:=vagrant}/.xinitrc << EOF
#!/bin/sh
stterm &
exec dwm
EOF
chown $VAGRANT_USERNAME:$VAGRANT_USERNAME /home/$VAGRANT_USERNAME/.xinitrc
