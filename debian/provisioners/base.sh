#!/bin/sh
set -e
set -x

if [ ${OPTIMISE_REPOS:-0} -eq 1 ]; then
	sed 's=http://http.us.debian.org/=http://cdn.debian.net/=' /etc/apt/sources.list > /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
	apt-get update
fi

test -z "$WGET" && apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
