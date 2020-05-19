#!/bin/sh
set -e
set -x

echo "machdep.allowaperture=2" >> /etc/sysctl.conf
echo "xenodm_flags=" >> /etc/rc.conf.local
