#!/bin/sh -x
for f in freebsd-11.2-release-*.json; do packer build "$@" $f; done
for f in freebsd-11.2-release-*.json; do
  grep docker $f > /dev/null || packer build -var-file=vars-freebsd-11.2-i386.json "$@" $f;
done
