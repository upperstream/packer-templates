#!/bin/sh
set -e
set -x
apk add --no-cache ${ANSIBLE:-ansible-2.9.1-r0}
if [ "$ANSIBLE_LINT" ]; then
	sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
	apk --no-cache add ${ANSIBLE_LINT:-ansible-lint-4.1.1a1-r0}
fi
if [ "$ANSIBLE_LINT_VERSION" ]; then
	${PIP:=python3 -m pip} install ansible-lint==${ANSIBLE_LINT_VERSION:-4.1.1a1-r0}
fi
${PIP:-python3 -m pip} install testinfra==${TESTINFRA_VERSION:-3.2.1}
