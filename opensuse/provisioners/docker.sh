#!/bin/sh
set -e
set -x

zypper --non-interactive install ${DOCKER:-docker} ${DOCKER_COMPOSE:-docker-compose}
systemctl enable docker.service
usermod -a -G docker ${VAGRANT_USERNAME:-vagrant}
