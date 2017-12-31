#!/bin/sh -ex
pkg_add ${PYTHON:-python27-2.7.11} ${PY27_PIP:-py27-pip-7.1.2}
pip2.7 install ansible==${ANSIBLE_VERSION:-2.1.0.0} testinfra==${TESTINFRA_VERSION:-1.2.0}
