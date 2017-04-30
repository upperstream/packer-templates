#!/bin/sh -ex
test -z "$PYTHON_DEV" && PYTHON_DEV=python-dev
test -z "$LIBFFI_DEV" && LIBFFI_DEV=libffi-dev
test -z "$LIBYAML_DEV" && LIBYAML_DEV=libyaml-dev
test -z "$LIBGMP_DEV" && LIBGMP_DEV=libgmp-dev
test -z "$LIBSSL_DEV" && LIBSSL_DEV=libssl-dev
test -z "$ANSIBLE" && ANSIBLE=ansible
test -z "$TESTINFRA" && TESTINFRA=testinfra

apt-get -y install $PYTHON_DEV $LIBFFI_DEV $LIBYAML_DEV $LIBGMP_DEV $LIBSSL_DEV
wget -O - https://bootstrap.pypa.io/get-pip.py | python
test -n "$PIP" && pip install --upgrade $PIP
pip --version
if [ -z "$CFFI_VERSION" ]; then
  pip install cffi
else
  pip install cffi==$CFFI_VERSION
fi
pip install --upgrade cryptography
pip install $ANSIBLE $TESTINFRA
apt-get -y remove python-dev libffi-dev libyaml-dev libgmp-dev libssl-dev
apt-get -y autoremove
