#!/bin/sh
pkg install -y yasm-1.2.0 kBuild-0.1.9998_3 python27-2.7.8_5
PWD=`pwd` sh -c "cd /usr/ports/ports-mgmt/pkg; make && make deinstall reinstall clean; cd $PWD"
PWD=`pwd` sh -c "cd /usr/ports/converters/libiconv; make BATCH=yes DOCS=off ENCODINGS=off PATCHES=off deinstall reinstall clean; cd $PWD"
PWD=`pwd` sh -c "cd /usr/ports/emulators/virtualbox-ose-additions; make BATCH=yes OPENGL=no WITH=\"\" WITHOUT=\"X11\" install clean; cd $PWD"
pkg delete -y yasm kBuild binutils gcc gcc-ecj gmp mpc mpfr libiconv
echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf
echo '#vboxservice_flags="--disable-timesync"' >> /etc/rc.conf
