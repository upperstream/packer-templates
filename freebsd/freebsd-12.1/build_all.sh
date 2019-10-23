#!/bin/sh -x
for f in freebsd-12.1-rc-*.json; do packer build "$@" $f; done
for f in freebsd-12.1-rc-*.json; do packer build -var-file=vars-freebsd-12.1-i386.json "$@" $f; done
