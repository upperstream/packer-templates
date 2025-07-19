#!/bin/sh
set -e
set -x
partition="${DISK:-sda}1"
echo "$(date): Filling the remaining disk space with 0x00.  This will take long (appr. 15 minutes per 100GB)."
sudo dd if=/dev/zero of=/"mnt/$partition/zero.bin" || true
sudo rm "/mnt/$partition/zero.bin"
