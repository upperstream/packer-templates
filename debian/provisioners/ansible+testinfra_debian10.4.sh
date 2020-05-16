#!/bin/sh
set -e
set -x
apt-get -y install ${ANSIBLE:-ansible} ${ANSIBLE_LINT:-ansible-lint} ${PYTHON_PIP:-python3-pip}
${PIP_COMMAND:=pip3} install ${TESTINFRA_VERSION:-testinfra}
