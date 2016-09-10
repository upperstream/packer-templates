#!/bin/sh -ex
KERNEL_VERSION=$(uname -r)
yum -y install kernel-headers-$KERNEL_VERSION kernel-devel-$KERNEL_VERSION
