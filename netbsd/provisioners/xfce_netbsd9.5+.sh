#!/bin/sh
set -e
set -x

pkg_add "${XFCE4:-xfce4}" "${FAM:-fam}" "${XRANDR:-xrandr}" "${X11VNC:-x11vnc}"

tmp_dir=$(mktemp -d /tmp/xfce-netbsd.XXXXXXXXXX)
trap 'rm -rf "$tmp_dir"' 0
trap 'exit 1' HUP INT TERM

cp /etc/X11/xdm/Xresources "$tmp_dir/Xresources"
sed 's/^XConsole\(.*\)/!XConsole\1/' "$tmp_dir/Xresources" > /etc/X11/xdm/Xresources
rm "$tmp_dir/Xresources"
cp /etc/X11/xdm/xdm-config "$tmp_dir/xdm-config"
sed 's/^DisplayManager\._0\(.*\)/!DisplayManager._0\1/' "$tmp_dir/xdm-config" > /etc/X11/xdm/xdm-config
rm "$tmp_dir/xdm-config"
echo "DisplayManager*authName:        MIT-MAGIC-COOKIE-1" >> /etc/X11/xdm/xdm-config

for service in famd dbus; do
	cp "/usr/pkg/share/examples/rc.d/$service" "/etc/rc.d/$service"
done
for service in rpcbind famd dbus; do
	echo "$service=YES" >> /etc/rc.conf
done

# Start a private D-Bus session without patching the packaged Xfce xinitrc.
cat > /home/"${VAGRANT_USER:=vagrant}"/.xinitrc << 'EOF'
#!/bin/sh
exec dbus-run-session -- xfce4-session
EOF
cat > /home/"$VAGRANT_USER"/.xsession << 'EOF'
#!/bin/sh
ENV=$HOME/.shrc
export ENV

if [ -f "$HOME/.xprofile" ]; then
	. "$HOME/.xprofile"
fi
exec "$HOME/.xinitrc"
EOF
chmod +x /home/"$VAGRANT_USER"/.xsession /home/"$VAGRANT_USER"/.xinitrc
chown "$VAGRANT_USER":"${VAGRANT_GROUP:-vagrant}" /home/"$VAGRANT_USER"/.xsession /home/"$VAGRANT_USER"/.xinitrc
