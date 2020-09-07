#!/bin/sh
set -e
set -x

yum -y install ${ANSIBLE:-ansible}
yum -y install ${PYTHON_PIP:-python2-pip}
${PIP:-pip} install ${ANSIBLE_LINT:-ansible-lint} ${TESTINFRA:-testinfra}
