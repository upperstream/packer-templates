#!/bin/sh
set -e
set -x

zypper --non-interactive install ${ANSIBLE:-ansible}
zypper --non-interactive install ${PYTHON_PIP:-python-pip}
pip install ${TESTINFRA:-testinfra}
