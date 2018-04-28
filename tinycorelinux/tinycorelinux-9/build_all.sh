#!/bin/sh -x
for f in vars-core*.json; do
  for g in tc-9-compiletc.json tc-9-minimal.json; do
    packer build -var-file=$f $* $g
  done
done
for f in vars-tinycore*.json; do
  for g in tc-9-*x11.json; do
    packer build -var-file=$f $* $g
  done
done
