#!/bin/sh -ex
cat > /home/$VAGRANT_USER/.xinitrc << EOF
#!/bin/sh
xterm &
exec twm
EOF
chown $VAGRANT_USER /home/$VAGRANT_USER/.xinitrc
