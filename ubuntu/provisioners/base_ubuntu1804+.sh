#!/bin/sh -ex
apt-get install -y curl
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
if grep 'GRUB_CMDLINE_LINUX_DEFAULT=' /etc/default/grub && grep -v 'net\.ifnames=0'/etc/default/grub; then
	sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 net.ifnames=0"/' /etc/default/grub
fi
if grep 'GRUB_CMDLINE_LINUX_DEFAULT=' /etc/default/grub && grep -v 'biosdevnames=0'/etc/default/grub; then
	sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 biosdevnames=0"/' /etc/default/grub
fi
update-grub
