#!/bin/sh
set -e
set -x

apt-get -y install "${CURL:-curl}"
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
VERSION=$(echo "${DOCKER:-docker-ce}" | sed 's/^docker-ce//' | sed 's/^-//') sh /tmp/get-docker.sh
usermod -a -G docker "${VAGRANT_USERNAME:-vagrant}"

apt-get -y install "${PYTHON_PIP:-python-pip}"
pip install "${DOCKER_COMPOSE:-docker-compose}"
