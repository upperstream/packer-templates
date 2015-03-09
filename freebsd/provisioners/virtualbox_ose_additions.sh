#!/bin/sh
pkg install -y yasm kBuild python27 pkgconf
pkg install -y libiconv
PWD=`pwd` sh -c "cd /usr/ports/emulators/virtualbox-ose-additions; make BATCH=yes OPENGL=no WITH=\"\" WITHOUT=\"X11\" install clean; cd $PWD"
pkg delete -y yasm kBuild pkgconf binutils gcc gcc-ecj gmp mpc mpfr
echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf
echo '#vboxservice_flags="--disable-timesync"' >> /etc/rc.conf
