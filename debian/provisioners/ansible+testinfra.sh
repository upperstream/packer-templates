#!/bin/sh
set -e
set -x
apt-get -y install ${PYTHON_DEV:-python-dev=2.7.3-4+deb7u1} ${LIBFFI_DEV:-libffi-dev=3.0.10-3} ${LIBYAML_DEV:-libyaml-dev=0.1.4-2+deb7u5} ${LIBGMP_DEV:-libgmp-dev=2:5.0.5+dfsg-2} ${LIBSSL_DEV:-libssl-dev=1.0.1e-2+deb7u20}
if [ -n "$PIP" ]; then
	wget -O - https://bootstrap.pypa.io/get-pip.py | python - $PIP
fi
pip --version
if [ -n "$PYOPENSSL" ]; then
	pip install --upgrade $PYOPENSSL
fi
pip install ${CFFI_VERSION:-cffi}
pip install --upgrade ${CRYPTOGRAPHY:-cryptography}
pip install --upgrade cryptography
pip install ${ANSIBLE:-ansible}
if [ -n "$ANSIBLE_LINT" ]; then
	pip install "$ANSIBLE_LINT"
fi
if [ -n "$PYTEST" ]; then
	pip install $PYTEST
fi
pip install ${TESTINFRA:-testinfra}
apt-get -y remove python-dev libffi-dev libyaml-dev libgmp-dev libssl-dev
apt-get -y autoremove
