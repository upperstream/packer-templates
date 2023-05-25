#!/bin/sh
set -e
set -x

if [ "${INSTALL_FROM_DVD:-false}" = "true" ]; then
	. /etc/os-release
	sed -e "/^#deb cdrom:.*$/a\deb http://http.us.debian.org/debian $VERSION_CODENAME main\ndeb-src http://http.us.debian.org/debian $VERSION_CODENAME main" \
		-e 's/^# deb http:/deb http:/' \
		-e 's/^# deb-src http:/deb-src http:/' /etc/apt/sources.list | tee /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
fi

if [ "${OPTIMISE_REPOS:-0}" -eq 1 ]; then
	sed 's=http://http\.us\.debian\.org/=http://cdn.debian.net/=' /etc/apt/sources.list > /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
fi

apt-get update

test -z "$WGET" && apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
