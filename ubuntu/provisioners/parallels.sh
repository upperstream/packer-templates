#!/bin/sh
#set -e
set -x
mount -o exec -t iso9660 "$PRL_TOOLS" /mnt
(cd /mnt && ./install --install-unattended-with-deps --progress --verbose)
umount /mnt
rm "$PRL_TOOLS"
