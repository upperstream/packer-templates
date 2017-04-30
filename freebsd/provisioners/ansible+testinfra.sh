#!/bin/sh -x
test -z "$PY27_PIP" && PY27_PIP=py27-pip
test -z "$ANSIBLE" && ANSIBLE=ansible
test -z "$TESTINFRA" && TESTINFRA=testinfra
pkg install -y $PY27_PIP
pip install $ANSIBLE $TESTINFRA
