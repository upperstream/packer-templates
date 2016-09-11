PARTITIONS=ada0

#!/bin/sh
echo 'WITHOUT_X11="YES"' >> /etc/make.conf
echo "WITH_PKGNG=yes" >> /etc/make.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
cat >> /etc/rc.conf <<EOF
ifconfig_em0="DHCP"
sshd_enable="YES"
dumpdev="AUTO"
rpcbind_enable="YES"
nfs_client_enable="YES"
mountd_flags="-r"
ntpd_enable="YES"
EOF

mkdir -p /usr/local/etc/pkg/repos/
cat > /usr/local/etc/pkg/repos/FreeBSD.conf << EOF
FreeBSD: {
    url: pkg+http://pkg.freebsd.org/${ABI}/latest,
    enabled: true
}
EOF
cat /usr/local/etc/pkg/repos/FreeBSD.conf
env ASSUME_ALWAYS_YES="YES" pkg bootstrap
cat > /usr/local/etc/pkg/repos/FreeBSD.conf << EOF
FreeBSD: {
    url: pkg+http://pkg.freebsd.org/${ABI}/release_3,
    enabled: true
}
EOF
pkg update
pkg install -y sudo-1.8.10.p2
pkg install -y curl-7.36.0
pkg install -y ca_root_nss-3.15.5

ln -sf /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem

echo -n 'vagrant' | pw usermod root -h 0
pw groupadd -n vagrant -g 1000
echo -n 'vagrant' | pw useradd -n vagrant -u 1000 -s /bin/sh -m -d /home/vagrant/ -G vagrant -h 0
pw groupmod wheel -m vagrant

echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /usr/local/etc/sudoers.d/vagrant

# SSH config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config

reboot
