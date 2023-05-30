#!/bin/sh
set -e
set -x
sed -i "/${OS_VER:-edge}\/community/s/^#//" /etc/apk/repositories
apk add --no-cache "${ANSIBLE:-ansible-2.9.1-r0}" "${PYTHON_PIP:-py3-pip-20.1.1-r0}"
if [ "$ANSIBLE_LINT_VERSION" ]; then
    "${PIP:-python3 -m pip}" install ansible-lint=="${ANSIBLE_LINT_VERSION}"
else
    apk add --no-cache "${ANSIBLE_LINT:-asible-lint-4.1.1a1-r0}"
fi
if [ "${PYTEST_TESTINFRA}" ]; then
    ${PIP:-python3 -m pip} install "$PYTEST_TESTINFRA"
else
    ${PIP:-python3 -m pip} install testinfra=="${TESTINFRA_VERSION:-4.1.0}"
fi
