#!/bin/sh
set -e
set -x

apt-get -y install ${ANSIBLE:-ansible}
wget -O - https://bootstrap.pypa.io/get-pip.py | python
test -z "$PIP" || pip install --upgrade $PIP
pip install ${TESTINFRA:-testinfra}
