#!/bin/sh
set -e
set -x

pkg_add ansible-${ANSIBLE:-2.7.9} py3-pip-${PY3_PIP:-9.0.3} ansible-lint-${ANBILE_LINT:-4.1.0}
pip3.6 install testinfra==${TESTINFRA:-2.0.0}
