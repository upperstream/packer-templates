#!/bin/sh -ex
setup-desktop xfce
apk add "${XRANDR:-xrandr}" "${XRDP:-xrdp}"
