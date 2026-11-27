#!/bin/sh
set -e
set -x

# shellcheck source=/dev/null
. /etc/os-release

repo_suites=stable
# Only DVD installs reconstruct the release-codename main repository.
if [ "${INSTALL_FROM_DVD:-false}" = "true" ]; then
	repo_suites="$repo_suites|$VERSION_CODENAME"
fi
if grep -Ev "^deb http://.*\.debian\.(net|org)/debian ($repo_suites) main" /etc/apt/sources.list | tee /tmp/sources.list; then
	mv /tmp/sources.list /etc/apt/sources.list
else
	rm -f /tmp/sources.list
fi
if [ "${INSTALL_FROM_DVD:-false}" = "true" ]; then
	sed -e "/^#deb cdrom:.*$/a\deb http://http.us.debian.org/debian $VERSION_CODENAME main\ndeb-src http://http.us.debian.org/debian $VERSION_CODENAME main" \
		-e 's/^# deb http:/deb http:/' \
		-e 's/^# deb-src http:/deb-src http:/' /etc/apt/sources.list | tee /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
fi

if [ "${OPTIMISE_REPOS:-0}" -eq 1 ]; then
	sed -e 's=http://http\.us\.debian\.org/=http://cdn.debian.net/=' \
		-e 's=http://deb\.debian\.org/=http://cdn.debian.net/=' /etc/apt/sources.list > /tmp/sources.list
	mv /tmp/sources.list /etc/apt/sources.list
fi

if [ "${ADD_SECURITY_REPO:-no}" = "yes" ]; then
	echo "deb http://security.debian.org/debian-security/ $VERSION_CODENAME-security main" >> /etc/apt/sources.list
fi

apt-get update

test -z "$WGET" && apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
