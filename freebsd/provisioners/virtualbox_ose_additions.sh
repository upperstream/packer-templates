#!/bin/sh
pkg install -y yasm-1.2.0 kBuild-0.1.9998_3 python27-2.7.8_5
pkg install -y libiconv-1.14_4
PWD=`pwd` sh -c "cd /usr/ports/emulators/virtualbox-ose-additions; make BATCH=yes OPENGL=no WITH=\"\" WITHOUT=\"X11\" install clean; cd $PWD"
pkg delete -y yasm kBuild binutils gcc gcc-ecj gmp mpc mpfr
echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf
echo '#vboxservice_flags="--disable-timesync"' >> /etc/rc.conf
