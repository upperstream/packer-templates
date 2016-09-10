#!/bin/sh -ex
KERNEL_VERSION=$(uname -r)
yum -y install perl-5.16.3-283.el7 kernel-headers-$KERNEL_VERSION kernel-devel-$KERNEL_VERSION
