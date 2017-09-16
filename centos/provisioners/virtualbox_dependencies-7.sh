#!/bin/sh -ex
yum -y install ${BZIP2:-bzip2-1.0.6-13.el7} ${KERNEL_DEVEL:-kernel-devel}
