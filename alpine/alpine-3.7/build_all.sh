#!/bin/sh -x
for f in vars-alpine-*.json; do
  for g in alpine-3.7-minimal.json alpine-3.7-ansible.json alpine-3.7-dwm.json; do
    packer build -var-file=$f $@ $g
  done
done
for f in vars-alpine-*-x86_64.json; do
  packer build -var-file=$f $@ alpine-3.7-docker.json
done
