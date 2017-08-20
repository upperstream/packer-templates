#!/bin/sh -x
for f in freebsd-10.4-beta-*.json; do packer build $* $f; done
for f in freebsd-10.4-beta-[^d]*.json; do packer build -var-file=vars-freebsd-10.4-i386.json $* $f; done
