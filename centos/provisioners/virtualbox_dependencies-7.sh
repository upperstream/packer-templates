#!/bin/sh -ex
test -z "$BZIP2" && BZIP2=bzip2-1.0.6-13.el7
yum -y install $BZIP2
