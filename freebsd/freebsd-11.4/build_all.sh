#!/bin/sh
set -x
for f in freebsd-11.4-beta-*.json; do packer build "$@" $f; done
for f in freebsd-11.4-beta-*.json; do packer build -var-file=vars-freebsd-11.4-i386.json "$@" $f; done
