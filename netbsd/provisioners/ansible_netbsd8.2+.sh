#!/bin/sh
set -x
set -e

pkg_add ${PYTHON:-python37} ${PYTHON_PIP:-py37-pip} ${ANSIBLE:-ansible}
${PIP:=python3.7 -m pip} install ${TESTINFRA:-testinfra}
if [ "$ANSIBLE_LINT" ]; then
    $PIP install "$ANSIBLE_LINT"
fi
