#!/bin/sh
set -e
set -x
apk add --no-cache ${ANSIBLE:-ansible-2.9.1-r0} ${ANSIBLE_LINT:-asible-lint-4.1.1a1-r0}
${PIP:=python3 -m pip} install ${TESTINFRA:-testinfra==3.2.1}
