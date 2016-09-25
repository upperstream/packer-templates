#!/bin/sh -ex
test -z "$PYTHON_DEV" && PYTHON_DEV=python-dev=2.7.3-4+deb7u1
test -z "$LIBFFI_DEV" && LIBFFI_DEV=libffi-dev=3.0.10-3
test -z "$LIBYAML_DEV" && LIBYAML_DEV=libyaml-dev=0.1.6-3
test -z "$LIBGMP_DEV" && LIBGMP_DEV=libgmp-dev=2:6.0.0+dfsg-6
test -z "$LIBSSL_DEV" && LIBGMP_DEV=libssl-dev=1.0.1t-1+deb8u3
test -z "$PYTHON_PIP" && PYTHON_PIP=1.1-3
apt-get -y install $PYTHON_DEV $LIBFFI_DEV $LIBYAML_DEV $LIBGMP_DEV $LIBSSL_DEV
apt-get -y install $PYTHON_PIP
pip install --upgrade setuptools cryptography
if [ -z "$ANSIBLE_VERSION" ]; then
  pip install ansible
else
  pip install ansible==$ANSIBLE_VERSION
fi
if [ -z "$TESTINFRA_VERSION" ]; then
  pip install testinfra
else
  pip install testinfra==$TESTINFRA_VERSION
fi
apt-get -y remove python-dev libffi-dev libyaml-dev libgmp-dev libssl-dev
apt-get -y autoremove
