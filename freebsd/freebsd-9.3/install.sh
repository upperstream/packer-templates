PARTITIONS=ada0
DISTRIBUTIONS="base.txz kernel.txz lib32.txz ports.txz src.txz"
BSDINSTALL_DISTSITE="ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/9.3-RELEASE"

#!/bin/sh
echo 'WITHOUT_X11="YES"' >> /etc/make.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
cat >> /etc/rc.conf <<EOF
ifconfig_em0="DHCP"
sshd_enable="YES"
dumpdev="AUTO"
rpcbind_enable="YES"
nfs_client_enable="YES"
mountd_flags="-r"
#ntpd_enable="YES"
EOF

env ASSUME_ALWAYS_YES="YES" pkg bootstrap
pkg update
pkg install -y sudo
pkg install -y curl
pkg install -y ca_root_nss

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
