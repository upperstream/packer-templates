#!/bin/sh -ex
yum -y install ${ANSIBLE:-ansible}
yum -y install ${PYTHON2_PIP:-python2-pip}
pip install ${TESTINFRA:-testinfra}
