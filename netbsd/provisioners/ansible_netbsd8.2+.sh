#!/bin/sh
set -x
set -e

pkg_add ${PYTHON:-python37} ${PYTHON_PIP:-py37-pip} ${ANSIBLE:-ansible}
${PIP:=python3.7 -m pip} install testinfra==${TESTINFRA_VERSION:-4.1.0}
if [ "$ANSIBLE_LINT_VERSION" ]; then
    $PIP install ansible-lint=="$ANSIBLE_LINT_VERSION"
fi
