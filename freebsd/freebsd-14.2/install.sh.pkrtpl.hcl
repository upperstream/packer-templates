%{ for config_key, config_value in variables }
${config_key}=${config_value}
%{ endfor ~}

#!/bin/sh -eux
%{ for config_key, config_value in make_conf }
echo '${config_key}=${config_value}' >> /etc/make.conf
%{ endfor ~}
dhclient $${NETIF:=em0}
cat /etc/resolv.conf || true
cat >> /etc/rc.conf <<EOF
ifconfig_$NETIF="DHCP"
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
  url: pkg+http://pkg.freebsd.org/$${ABI}/release_2,
  enabled: true
}
EOF

ASSUME_ALWAYS_YES=yes; export ASSUME_ALWAYS_YES
IGNORE_OSVERSION=yes; export IGNORE_OSVERSION
pkg bootstrap
pkg update
if [ "$${SUDO:-}" ]; then
	pkg install -y "$SUDO"
	echo "$VAGRANT_USER ALL=(ALL) NOPASSWD:ALL" >> /usr/local/etc/sudoers.d/"$VAGRANT_USER"
elif [ "$${DOAS:-}" ]; then
	pkg install -y "$DOAS"
	echo "permit nopass keepenv $VAGRANT_USER as root" >> /usr/local/etc/doas.conf
fi
pkg install -y "$${CA_ROOT_NSS:-ca_root_nss}"
ln -sf /usr/local/share/certs/ca-root-nss.crt /etc/ssl/cert.pem

printf "%s" "$ROOT_PASSWORD" | pw usermod root -h 0
pw groupadd -n "$VAGRANT_GROUP" -g 1000
printf "%s" "$VAGRANT_PASSWORD" | pw useradd -n "$VAGRANT_USER" -u 1000 -s /bin/sh -m -d /home/"$VAGRANT_USER" -g "$VAGRANT_GROUP" -h 0
pw groupmod wheel -m "$VAGRANT_USER"

# SSH config
cp /etc/ssh/sshd_config /tmp/sshd_config
sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PasswordAuthentication no/PasswordAuthentication yes/' \
  -e 's/^#UseDNS yes/UseDNS no/' /tmp/sshd_config > /etc/ssh/sshd_config
rm /tmp/sshd_config

reboot
