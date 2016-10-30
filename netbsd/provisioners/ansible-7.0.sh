#!/bin/sh -ex
test -z "$PYTHON" && PYTHON=python27-2.7.11
test -z "$PY27_PIP" && PY27_PIP=py27-pip-7.1.2
test -z "$ANSIBLE_VERSION" && ANSIBLE_VERSION=2.1.0.0
test -z "$TESTINFRA_VERSION" && TESTINFRA_VERSION=1.2.0

pkg_add $PYTHON $PY27_PIP
pip2.7 install ansible==$ANSIBLE_VERSION testinfra==$TESTINFRA_VERSION
