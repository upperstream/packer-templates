#!/bin/sh
set -e
set -x

sed "s=^\([^#]* \)http://archive.ubuntu.com/ubuntu\( .*\)\$=\1${ARCHIVE_MIRROR:-http://archive.ubuntu.com/ubuntu}\2=" /etc/apt/sources.list > /tmp/sources.list
mv /tmp/sources.list /etc/apt/sources.list
apt-get update
