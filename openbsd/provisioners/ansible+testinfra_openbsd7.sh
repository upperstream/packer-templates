#!/bin/sh
set -e
set -x

pkg_add "${ANSIBLE:-ansible}" "${PY_PIP:-py3-pip}" "${ANSIBLE_LINT:-ansible-lint}"
PIP=pip`python3 --version | cut -f2 -d' ' | cut -f 1 -f 2 -d'.'`
$PIP install ${TESTINFRA:-pytest-testinfra}
