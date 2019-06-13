#!/bin/sh
set -e
set -x
pkg install -y ${ANSIBLE:-"py36-ansible"} ${PIP:-"py36-pip"} ${ANSIBLE_LINT:-"py36-ansible-lint"} ${RUAMEL_YAML:-"py36-ruamel.yaml"}
pip install ${TESTINFRA:-testinfra}
