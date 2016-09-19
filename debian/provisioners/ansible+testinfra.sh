#!/bin/sh -ex
apt-get -y install python-dev=2.7.3-4+deb7u1 libffi-dev=3.0.10-3
apt-get -y install python-pip=1.1-3
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
apt-get -y remove python-dev libffi-dev
apt-get -y autoremove
