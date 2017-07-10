#!/bin/sh -x
for f in centos-6.9-[am]*.json; do
  for g in vars-centos-6.9-*.json; do
    packer build -var-file=$g $* $f
  done
done
packer build -var-file=vars-centos-6.9-x86_64.json $* centos-6.9-docker.json
