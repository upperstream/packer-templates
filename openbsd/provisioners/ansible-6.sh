#!/bin/sh -ex
pkg_add python-${PYTHON:-2.7.12} ansible-${ANSIBLE:-2.1.0.0} py-pip-${PY_PIP:-8.1.2}
pip2.7 install testinfra==${TESTINFRA:-1.4.0}
