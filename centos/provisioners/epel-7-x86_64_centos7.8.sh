#!/bin/sh
set -e
set -x
yum install -y ${EPEL_RELEASE:-epel-release}

