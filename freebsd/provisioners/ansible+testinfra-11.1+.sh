#!/bin/sh
set -e
set -x
pkg install -y ${ANSIBLE:-ansible} ${PY27_PIP:-"py27-pip"}
if [ "${ANSIBLE_LINT}" ]; then
    pkg install -y ${ANSIBLE_LINT}
fi
pip install ${TESTINFRA:-testinfra}
