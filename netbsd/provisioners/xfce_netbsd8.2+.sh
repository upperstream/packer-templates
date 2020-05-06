#!/bin/sh
set -e
set -x

pkg_add ${XFCE4:-xfce4} ${FAM:-fam} ${XRANDR:-xrandr} ${X11VNC:-x11vnc}
if [ "$HAL" ]; then
	pkg_add "$HAL"
fi

sed 's/^XConsole\(.*\)/!XConsole\1/' /etc/X11/xdm/Xresources > /tmp/Xresources
mv /tmp/Xresources /etc/X11/xdm/Xresources

sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/'  /etc/X11/xdm/xdm-config > /tmp/xdm-config
mv /tmp/xdm-config /etc/X11/xdm/xdm-config
echo "DisplayManager*authName:        MIT-MAGIC-COOKIE-1" >> /etc/X11/xdm/xdm-config

for f in famd dbus hal; do cp /usr/pkg/share/examples/rc.d/$f /etc/rc.d/; done

cat >> /etc/rc.conf << EOF
rpcbind=YES
famd=YES
dbus=YES
hal=YES
EOF

cat > /home/$VAGRANT_USER/.xinitrc << 'EOF'
#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

exec xfce4-session
EOF

cat > /home/$VAGRANT_USER/.xsession << 'EOF'
#!/bin/sh
ENV=$HOME/.shrc
export ENV

test -f $HOME/.xprofile && . $HOME/.xprofile
test -f $HOME/.xinitrc && . $HOME/.xinitrc
EOF
chmod +x /home/$VAGRANT_USER/.xsession
chown $VAGRANT_USER /home/$VAGRANT_USER/.xsession /home/$VAGRANT_USER/.xinitrc
