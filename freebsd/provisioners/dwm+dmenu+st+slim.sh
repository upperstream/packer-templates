#!/bin/sh -ex
pkg install -y slim-1.3.6_12 slim-themes-1.0.1 arandr-0.1.7.1_2
echo 'slim_enable="YES"' >> /etc/rc.conf

pkg install -y pkgconf-0.9.12_1 ncurses-6.0_2
pkg install -y dwm-6.1_1 dmenu-4.6

cd /tmp
curl http://dl.suckless.org/st/st-0.7.tar.gz | tar zxvf -
cd st-0.7
cp config.mk config.def.mk
sed '/MANPREFIX/s:share/man:man:' config.def.mk > config.mk
make clean st
sudo make install
for t in st st-256color st-meta st-meta-256color; do sudo sh -c "infocmp -C $t >> /usr/share/misc/termcap"; done
sudo cap_mkdb /usr/share/misc/termcap
cd /tmp
rm -rf st-0.7

cat >> /etc/X11/xorg.conf << EOF

Section "Module"
	Load "freetype"
EndSection

Section "Files"
	FontPath "/usr/local/share/fonts/dejavu/"
EndSection
EOF

cat << EOF > /home/$VAGRANT_USER/.xinitrc
st &
exec dwm
EOF

cp /usr/local/etc/slim.conf /usr/local/etc/slim.conf.orig
sed '/current_theme/s/default/fbsd/' /usr/local/etc/slim.conf.orig > /usr/local/etc/slim.conf
