#!/bin/sh
set -e
set -x
pkg install -y ${ANSIBLE:-"py27-ansible"} ${PIP:-"py27-pip"} ${ANSIBLE_LINT:-"py27-ansible-lint"} ${RUAMEL_YAML:-"py27-ruamel.yaml"}
if [ "$RUAMEL_ORDEREDDICT" ]; then
	pkg install -y "$RUAMEL_ORDEREDDICT"
fi

pip install ${TESTINFRA:-testinfra}
