#!/bin/sh
set -e
set -x
pkg install -y ${ANSIBLE:-ansible} ${PY27_PIP:-"py27-pip"} ${ANSIBLE_LINT:-ansible-lint}
pip-2.7 install ${TESTINFRA:-testinfra}
