#!/bin/sh
set -e
set -x

sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk --update --no-cache add ${DOCKER:-docker}
apk --no-cache add ${PYTHON_PIP:-py3-pip} ${PY_PYNACL:-py3-pynacl} ${PY_BCRYPT:-py3-bcrypt} ${PY_CRYPTOGRAPHY:-py3-cryptography}
python3 -m pip install docker-compose==${DOCKER_COMPOSE_VERSION:=1.25.0}

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
