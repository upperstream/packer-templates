#!/bin/sh
set -e
set -x

if [ "${USE_DEFAULT_XINITRC:-NO}" = "NO" ]; then
	cat > /home/${VAGRANT_USER:=vagrant}/.xinitrc <<-EOF
	#!/bin/sh
	xterm &
	exec twm
	EOF
	chown $VAGRANT_USER:${VAGRANT_GROUP:-vagrant} /home/$VAGRANT_USER/.xinitrc
fi
