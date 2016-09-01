#!/bin/sh -x
for f in freebsd-11.0-rc-*.json; do packer build -var-file=vars-freebsd-11-amd64.json $* $f; done
for f in freebsd-11.0-rc-[^d]*.json; do packer build -var-file=vars-freebsd-11-i386.json $f; done
