#!/bin/sh
set -e
set -x

pkg_add ansible-${ANSIBLE:-2.7.9} py3-pip-${PY3_PIP:-9.0.3} ansible-lint-${ANSIBLE_LINT:-4.1.0}
PIP=pip`python3 --version | cut -f2 -d' ' | cut -f 1 -f 2 -d'.'`
$PIP install testinfra==${TESTINFRA:-2.0.0}
