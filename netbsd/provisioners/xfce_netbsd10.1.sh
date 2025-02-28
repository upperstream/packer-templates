#!/bin/sh
set -e
set -x

pkg_add "${XFCE4:-xfce4}" "${FAM:-fam}" "${XRANDR:-xrandr}" "${X11VNC:-x11vnc}"
if [ "$HAL" ]; then
	pkg_add "$HAL"
fi

cp /etc/X11/xdm/Xresources /tmp/Xresources
sed 's/^XConsole\(.*\)/!XConsole\1/' /tmp/Xresources > /etc/X11/xdm/Xresources
rm /tmp/Xresources
cp /etc/X11/xdm/xdm-config /tmp/xdm-config
sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/' /tmp/xdm-config > /etc/X11/xdm/xdm-config
rm /tmp/xdm-config
echo "DisplayManager*authName:        MIT-MAGIC-COOKIE-1" >> /etc/X11/xdm/xdm-config

HAL=${HAL%%-*}
for f in famd dbus $HAL; do test -f "$f" && cp /usr/pkg/share/examples/rc.d/"$f" /etc/rc.d/; done

for f in rpcbind famd dbus $HAL; do
	echo "$f=YES" >> /etc/rc.conf
done

(cd /usr/pkg/etc/xdg/xfce4/; patch -p6 << 'EOF')
--- /usr/pkg/etc/xdg/xfce4/xinitrc.orig	2025-02-18 00:00:00.00000000 +0000
+++ /usr/pkg/etc/xdg/xfce4/xinitrc	2025-02-18 00:00:00.00000000 +0000
@@ -79,6 +79,17 @@

 # load local modmap
 test -r $HOME/.Xmodmap && xmodmap $HOME/.Xmodmap
+
+# Use dbus-launch if installed.
+if test x"$DBUS_SESSION_BUS_ADDRESS" = x""; then
+  if which dbus-luanch > /dev/null 2>&1; then
+    eval `dbus-launch --sh-syntax --exit-with-session`
+    # some older versions of dbus don't export the var properly
+    export DBUS_SESSION_BUS_ADDRESS
+  else
+    echo "Could not find dbus-launch; Xfce will not work properly" >&2
+  fi
+fi

 # ensure both the DBus session bus and systemd user session (if running) has
 # all the env vars it needs to properly populate the environment of child
EOF

cat > /home/"$VAGRANT_USER"/.xinitrc << 'EOF'
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

cat > /home/"$VAGRANT_USER"/.xsession << 'EOF'
#!/bin/sh
ENV=$HOME/.shrc
export ENV

test -f $HOME/.xprofile && . $HOME/.xprofile
test -f $HOME/.xinitrc && . $HOME/.xinitrc
EOF
chmod +x /home/"$VAGRANT_USER"/.xsession
chown "$VAGRANT_USER" /home/"$VAGRANT_USER"/.xsession /home/"$VAGRANT_USER"/.xinitrc
