#!/bin/sh
echo "$(date): Filling the remaining disk space with 0x00.  This will take long (appr. 15 minutes per 100GB)."
dd if=/dev/zero of=/tmp/zero.bin
rm /tmp/zero.bin
echo "$(date): Disk cleanup completed"
