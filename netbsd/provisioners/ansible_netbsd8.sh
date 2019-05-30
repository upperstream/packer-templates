#!/bin/sh
set -x
set -e

pkg_add ${PYTHON:-python} ${PY27_PIP:-py27-pip} ${ANSIBLE:-ansible}
pip2.7 install ${TESTINFRA:-testinfra}
if [ "$ANSIBLE_LINT" ]; then
    pip2.7 install "$ANSIBLE_LINT"
fi
