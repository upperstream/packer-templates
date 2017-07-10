#!/bin/sh -x
for f in freebsd-11.1-beta-*.json; do packer build -var-file=vars-freebsd-11.1-amd64.json "$@" $f; done
for f in freebsd-11.1-beta-[^d]*.json; do \
  grep docker $f || packer build -var-file=vars-freebsd-11.1-i386.json "$@" $f; \
done
