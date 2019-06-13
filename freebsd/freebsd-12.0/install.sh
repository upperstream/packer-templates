
#!/bin/sh
set -e
set -x
echo 'WITHOUT_X11="YES"' >> /etc/make.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
cat >> /etc/rc.conf <<EOF
ifconfig_em0="DHCP"
sshd_enable="YES"
dumpdev="AUTO"
rpcbind_enable="YES"
#nfs_client_enable="YES"
mountd_flags="-r"
ntpd_enable="YES"
EOF

mkdir -p /usr/local/etc/pkg/repos/
cat > /usr/local/etc/pkg/repos/FreeBSD.conf << EOF
FreeBSD: {
    url: pkg+http://pkg.freebsd.org/${ABI}/release_0,
    enabled: true
}
EOF

env ASSUME_ALWAYS_YES="YES" pkg bootstrap -y
pkg update
pkg install -y sudo-1.8.25p1
pkg install -y ca_root_nss-3.40
ln -sf /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem

echo -n "$ROOT_PASSWORD" | pw usermod root -h 0
pw groupadd -n "$VAGRANT_GROUP" -g 1000
echo -n "$VAGRANT_PASSWORD" | pw useradd -n $VAGRANT_USER -u 1000 -s /bin/sh -m -d /home/$VAGRANT_USER -g $VAGRANT_GROUP -h 0
pw groupmod wheel -m $VAGRANT_USER

echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/local/etc/sudoers.d/$VAGRANT_USER

# SSH config
cp /etc/ssh/sshd_config /tmp/sshd_config
sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication no/PasswordAuthentication yes/' \
  -e 's/^#UseDNS yes/UseDNS no/' /tmp/sshd_config > /etc/ssh/sshd_config
rm /tmp/sshd_config

reboot
