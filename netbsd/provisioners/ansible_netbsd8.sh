#!/bin/sh
set -x
set -e

pkg_add ${PYTHON:-python} ${PY27_PIP:-py27-pip} ${ANSIBLE:-ansible}
pip2.7 install ${TESTINFRA:-testinfra}
