#!/bin/sh -ex
apk add --no-cache python py-pip
apk add --no-cache libffi openssl
apk add --no-cache alpine-sdk libffi-dev openssl-dev python-dev
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
apk del --purge alpine-sdk libffi-dev openssl-dev python-dev
