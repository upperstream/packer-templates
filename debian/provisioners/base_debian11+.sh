#!/bin/sh
set -e
set -x

if [ "${INSTALL_FROM_DVD:-false}" = "true" ]; then
	sed -e '/^#deb cdrom:.*$/a\
\
deb http://http.us.debian.org/debian bullseye main\
deb-src http://http.us.debian.org/debian bullseye main' \
		-e 's/^# deb http:/deb http:/' \
		-e 's/^# deb-src http:/deb-src http:/' /etc/apt/sources.list > /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
	apt-get update
fi

if [ "${OPTIMISE_REPOS:-0}" -eq 1 ]; then
	sed 's=http://http\.us\.debian\.org/=http://cdn.debian.net/=' /etc/apt/sources.list > /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
	apt-get update
fi

test -z "$WGET" && apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
