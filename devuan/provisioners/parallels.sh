#!/bin/sh

set -e
set -x

mount -o exec -t iso9660 /root/"$PRL_TOOLS" /media/cdrom
cd /media/cdrom
./install --install-unattended-with-deps --progress --verbose && rm /root/"$PRL_TOOLS"
