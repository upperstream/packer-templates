#!/bin/sh -x
for f in freebsd-10.4-release-*.json; do packer build $@ $f; done
for f in freebsd-10.4-release-*.json; do
  test "$f" != "freebsd-10.4-release-docker.json" -a "$f" != "freebsd-10.4-release-zfs.json" && packer build -var-file=vars-freebsd-10.4-i386.json $@ $f
done
