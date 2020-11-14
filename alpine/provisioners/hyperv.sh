#!/bin/sh
set -e
set -x
apk add ${XF86_VIDEO_FBDEV:-xf86-video-fbdev}
