#!/bin/sh
set -e
set -x
apt-get -y install ${PYTHON_DEV:-python-dev=2.7.3-4+deb7u1} ${LIBFFI_DEV:-libffi-dev=3.0.10-3} ${LIBYAML_DEV:-libyaml-dev=0.1.4-2+deb7u5} ${LIBGMP_DEV:-libgmp-dev=2:5.0.5+dfsg-2} ${LIBSSL_DEV:-libssl-dev=1.0.1e-2+deb7u20}
wget -O - https://bootstrap.pypa.io/get-pip.py | python
test -n "$PIP" && pip install --upgrade $PIP
pip --version
pip install ${CFFI_VERSION:-cffi}
pip install --upgrade cryptography
pip install ${ANSIBLE:-ansible} ${TESTINFRA:-testinfra}
if [ -n "$ANSIBLE_LINT" ]; then
    pip install "$ANSIBLE_LINT"
fi
apt-get -y remove python-dev libffi-dev libyaml-dev libgmp-dev libssl-dev
apt-get -y autoremove
