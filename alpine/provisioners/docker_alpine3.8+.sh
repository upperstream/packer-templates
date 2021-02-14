#!/bin/sh
set -e
set -x

sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk --update --no-cache add ${DOCKER:-docker}
if [ "$DOCKER_COMPOSE" ]; then
	apk --no-cache add ${DOCKER_COMPOSE:-docker-compose}
else
	apk --no-cache add ${PYTHON:-python3} python3-dev libffi-dev openssl-dev
	apk --no-cache add build-base
	if [ "$PYTHON_PIP" ]; then
		apk --no-cache add ${PYTHON_PIP:-py3-pip}
	fi
	python3 -m pip install docker-compose==${DOCKER_COMPOSE_VERSION:=1.25.0}
	apk del build-base libffi-dev openssl-dev python3-dev
fi

rc-update add docker boot

adduser -SDHs /sbin/nologin dockremap
addgroup -S dockremap
echo dockremap:`cat /etc/passwd | grep dockremap | cut -d: -f3`:65536 >> /etc/subuid
echo dockremap:`cat /etc/passwd | grep dockremap | cut -d: -f4`:65536 >> /etc/subgid

mkdir -p /etc/docker
cat << EOF >> /etc/docker/daemon.json
{
  "userns-remap": "dockremap"
}
EOF
