#!/bin/sh -x
for f in vars-core*.pkrvars.hcl; do
	for g in tc-16-compiletc.pkr.hcl tc-16-kernel.pkr.hcl tc-16-minimal.pkr.hcl; do
		echo ">>>>>> $f - $g <<<<<<"
		packer build -var-file="$f" "$@" "$g"
	done
done
for f in vars-tinycore*.pkrvars.hcl; do
	for g in tc-16-*x11.pkr.hcl; do
		echo ">>>>>> $f - $g <<<<<<"
		packer build -var-file="$f" "$@" "$g"
	done
done
