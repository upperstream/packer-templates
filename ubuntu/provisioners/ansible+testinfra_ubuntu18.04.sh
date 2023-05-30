#!/bin/sh
set -e
set -x

apt-get -y install "${ANSIBLE:-ansible}"
if [ -z "$PIP" ]; then
	if [ "$PYTHON_PIP" ]; then
		apt-get -y install "$PYTHON_PIP"
	fi
else
	wget -O - https://bootstrap.pypa.io/get-pip.py | python
	pip install --upgrade "$PIP"
fi
pip install "${TESTINFRA:-testinfra}"
