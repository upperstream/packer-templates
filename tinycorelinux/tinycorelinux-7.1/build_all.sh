#!/bin/sh -x
for f in vars-core*.json; do
  for g in tc-7.1-ansible.json tc-7.1-compiletc.json tc-7.1-minimal.json; do
    packer build -var-file=$f $g
  done
done
for f in vars-tinycore*.json; do
  for g in tc-7.1-*x11.json; do
    packer build -var-file=$f $g
  done
done
