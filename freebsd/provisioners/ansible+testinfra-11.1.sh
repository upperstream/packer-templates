#!/bin/sh -ex
pkg install -y ${ANSIBLE:-ansible} ${PY27_PIP:-"py27-pip"}
pip install ${TESTINFRA:-testinfra}
