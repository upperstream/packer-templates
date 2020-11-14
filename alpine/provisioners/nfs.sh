#!/bin/sh
set -e
set -x
apk add ${NFS_UTILS:-nfs-utils} ${UTIL_LINUX:-util-linux}
rc-update add rpc.statd default
