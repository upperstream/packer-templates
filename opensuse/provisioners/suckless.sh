#!/bin/sh
set -e
set -x

chmod +s /var/lib/X11/X
zypper --non-interactive --gpg-auto-import-keys addrepo -f http://download.opensuse.org/repositories/utilities:suckless/openSUSE_13.2/utilities:suckless.repo
zypper --non-interactive --gpg-auto-import-keys install ${DWM:-dwm} ${ST:-st} ${DMENU:-dmenu}
cat > /home/${VAGRANT_USERNAME:=vagrant}/.xinitrc << EOF
#!/bin/sh
uxterm &
exec dwm
EOF
chown $VAGRANT_USERNAME:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USERNAME/.xinitrc
zypper --non-interactive install ${ARANDR:-arandr} ${XRDP:-xrdp}
