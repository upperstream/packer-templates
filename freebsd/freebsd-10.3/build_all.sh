#!/bin/sh -x
for f in freebsd-10.3-release-*.json; do packer build -var-file=vars-freebsd-10.3-amd64.json $* $f; done
for f in freebsd-10.3-release-[^d]*.json; do packer build -var-file=vars-freebsd-10.3-i386.json $* $f; done
