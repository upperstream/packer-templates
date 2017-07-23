#!/bin/sh
set -e
set -x

test -z "$WGET" && apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
