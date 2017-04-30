#!/bin/sh -x
for f in centos-6.8-[am]*.json; do
  for g in vars-centos-6.8-*.json; do
    packer build -var-file=$g $* $f
  done
done
packer build -var-file=vars-centos-6.8-x86_64.json $* centos-6.8-docker.json
