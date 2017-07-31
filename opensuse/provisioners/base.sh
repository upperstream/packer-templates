#!/bin/sh
set -e
set -x

zypper --non-interactive addrepo -f -n \"openSUSE-Leap-42.3-Oss\" \
  http://download.opensuse.org/distribution/leap/42.3/repo/oss/ repo-oss
zypper --non-interactive addrepo -f -n \"openSUSE-Leap-42.3-Non-Oss\" \
  http://download.opensuse.org/distribution/leap/42.3/repo/non-oss/ repo-non-oss
zypper --non-interactive addrepo -f -n \"openSUSE-Leap-42.3-Update\" \
  http://download.opensuse.org/update/leap/42.3/oss/ repo-update-oss
zypper --non-interactive addrepo -f -n \"openSUSE-Leap-42.3-Update-Non-Oss\" \
  http://download.opensuse.org/update/leap/42.3/non-oss/ repo-update-non-oss
