#!/bin/sh
set -x
set -e

pkg install -y ${PY27_PIP:=py27-pip}
pip install ${ANSIBLE:-ansible} ${TESTINFRA:-testinfra}
