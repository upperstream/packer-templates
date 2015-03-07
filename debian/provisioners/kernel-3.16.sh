echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -y remove virtualbox-guest-utils
apt-get -y autoremove
apt-get -y install -t wheezy-backports linux-headers-amd64
wget http://ftp.us.debian.org/debian/pool/main/i/initramfs-tools/initramfs-tools_0.115~bpo70+1_all.deb
dpkg -i initramfs-tools_0.115~bpo70+1_all.deb
wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux-image-3.16.0-0.bpo.4-amd64_3.16.7-ckt4-3~bpo70+1_amd64.deb
dpkg -i --auto-deconfigure linux-image-3.16.0-0.bpo.4-amd64_3.16.7-ckt4-3~bpo70+1_amd64.deb
apt-get -y install dkms
rm -f initramfs-tools_0.115~bpo70+1_all.deb linux-image-3.16.0-0.bpo.4-amd64_3.16.7-ckt4-3~bpo70+1_amd64.deb
shutdown -r now
sleep 60
