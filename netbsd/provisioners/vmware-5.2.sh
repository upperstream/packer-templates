# This installs X11 files in addition

#pkg_add open-vm-tools

# If you want to exclude X11 files to be installed, uncomment and execute the rest of this script instead of the line above

## Uncomment unless you install Compiler Tools distribution set by the installer.
## ftp -o "| tar --unlink -zxpf - -C /" ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-`uname -r`/`uname -m`/binary/sets/comp.tgz

test -x /usr/bin/cvs || pkg_add cvs-1.12.13nb2

echo "$(date): Checking out anoncvs@anoncvs.NetBSD.org:/cvsroot with a tag \"pkgsrc-2015Q1\"."
echo "This can take very long (more than 50 minutes)."
cd /usr && cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -r pkgsrc-2015Q1 -P pkgsrc > /dev/null
echo "$(date): Checkout completed"

pkg_add digest-20121220 libtool-base-2.4.2nb9 openssl-1.0.2c automake-1.15 pkg-config-0.28 libdnet-1.12nb1 icu-54.1nb2

cd /usr/pkgsrc/sysutils/open-vm-tools
unset PKG_PATH
make PKG_OPTIONS.open-vm-tools="-x11" install clean
cp /usr/pkg/share/examples/rc.d/vmtools /etc/rc.d/vmtools
echo "vmtools=YES" >> /etc/rc.conf

# Comment out if you want to keep pkgsrc files.
rm -rf /usr/pkgsrc
