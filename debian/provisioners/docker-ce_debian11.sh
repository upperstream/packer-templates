#!/bin/sh
set -e
set -x

apt install -y ${DOCKER_IO:-docker.io=20.10.5+dfsg1-1+deb11u2} ${DOCKER_COMPOSE:-docker-compose=1.25.0-1}
exit 0

apt-get remove docker docker-engine || true
test -z "$WGET" && apt-get -y install curl
sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  gnupg2 \
  software-properties-common
${WGET:="curl -fsSL"} https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo apt-key fingerprint 0EBFCD88 | grep '9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88' > /dev/null
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
apt-get -y update
apt-get -y install ${DOCKER_CE:-docker-ce}
service docker start
groupadd docker || true
gpasswd -a ${VAGRANT_USERNAME:-vagrant} docker
$WGET https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION:-1.8.0}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
