#!/bin/sh
set -e
set -x
sed 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config > /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
kill -HUP `cat /var/run/sshd.pid`
if [ "${ENABLE_DHCP:-no}" = "yes" ]; then
    sed -e '/^ifconfig_/d' -e '/^defaultroute/d' /etc/rc.conf > /tmp/rc.conf
    echo "dhcpcd=YES" >> /tmp/rc.conf
    mv /tmp/rc.conf /etc/rc.conf
    rm /etc/resolv.conf
fi
