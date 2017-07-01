#!/bin/sh -x
for f in freebsd-11.1-rc-*.json; do packer build "$@" $f; done
for f in freebsd-11.1-rc-*.json; do
  grep docker $f > /dev/null || packer build -var-file=vars-freebsd-11.1-i386.json "$@" $f;
done
