#!/bin/sh
set -e
set -x

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install ${DOCKER_CE:-docker-ce-19.03.12-3.el7.centos}
systemctl enable docker
systemctl start docker

curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION:-1.25.5}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
