#!/bin/sh
set -x
for f in freebsd-13.0-rc-*.json; do packer build "$@" $f; done
for f in freebsd-13.0-rc-*.json; do packer build -var-file=vars-freebsd-13.0-i386.json "$@" $f; done
