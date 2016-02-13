echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -y remove virtualbox-guest-utils
apt-get -y autoremove
apt-get -y install -t wheezy-backports linux-image-3.16.0-0.bpo.4-amd64
apt-get -y install -t wheezy-backports linux-headers-amd64
apt-get -y install dkms
shutdown -r now
sleep 60
