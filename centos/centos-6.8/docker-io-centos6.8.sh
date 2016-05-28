yum -y install yum-plugin-priorities-1.1.30-37.el6
rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
yum install -y --enablerepo elrepo-kernel kernel-lt
yum install -y docker-io-1.7.1-2.el6
groupadd docker
usermod -a -G docker vagrant
/etc/init.d/cgred stop
/etc/init.d/cgconfig stop
/etc/init.d/cgconfig start
/etc/init.d/cgred start
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo cp /boot/grub/grub.conf /tmp/grub.conf.orig
entry=$(expr $(grep '^[^#].*kernel /vmlinuz' /tmp/grub.conf.orig | grep -c 'vmlinuz-3\.') - 1)
if grep '^default' /tmp/grub.conf.orig; then
  sed "/^default=/s/^default=[0-9][0-9]*/default=$entry/" /tmp/grub.conf.orig > /tmp/grub.conf
else
  cat >> /tmp/update-grub.awk << EOF
{
  if (match($$0, "^#")) {
    if (in_body == 0) {
      print $$0
    }
  }
  else {
    if (in_body == 0) {
      in_body = 1
      print "default=$entry"
    }
    print $$0
  }
}
EOF
  awk -f /tmp/update-grub.awk /boot/grub/grub.conf.orig > /tmp/grub.conf
  rm -f /tmp/update-grub.awk
fi
sudo mv /tmp/grub.conf /boot/grub/
rm -f /tmp/grub.conf.orig

#shutdown -r now
