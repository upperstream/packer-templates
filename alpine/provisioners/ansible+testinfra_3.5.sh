#!/bin/sh -ex
test -z "$ANSIBLE" && ANSIBLE=ansible
test -z "$PY2_PIP" && PY2_PIP=py2-pip
apk add --no-cache $ANSIBLE
apk add --no-cache $PY2_PIP
if [ -z "$TESTINFRA_VERSION" ]; then
  pip install testinfra
else
  pip install testinfra==$TESTINFRA_VERSION
fi
