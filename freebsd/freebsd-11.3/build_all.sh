#!/bin/sh -x
for f in freebsd-11.3-beta-*.json; do packer build "$@" $f; done
for f in freebsd-11.3-beta-*.json; do
  grep docker $f > /dev/null || packer build -var-file=vars-freebsd-11.3-i386.json "$@" $f;
done
