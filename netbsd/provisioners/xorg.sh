#!/bin/sh
set -e
set -x

cat > /home/${VAGRANT_USER:=vagrant}/.xinitrc << EOF
#!/bin/sh
xterm &
exec twm
EOF
chown $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.xinitrc
