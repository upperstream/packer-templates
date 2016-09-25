#!/bin/sh -ex
test -z "$XRDP" && XRDP=xrdp
apt-get install -y $XRDP
