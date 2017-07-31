#!/bin/sh
set -e
set -x

zypper --non-interactive install \
  ${VIRTUALBOX_GUEST_TOOLS:-virtualbox-guest-tools} \
  ${VIRTUALBOX_GUEST_KMP_DEFAULT:-virtualbox-guest-kmp-default}
test -z "$VIRTUALBOX_GUEST_WITH_X11" || zypper --non-interactive install ${VIRTUALBOX_GUEST_X11:-virtualbox-guest-x11=5.1.22-20.2}
