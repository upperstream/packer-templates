#!/bin/sh -x
pkg install -y open-vm-tools-nox11-1280544_14,1
cat >> /etc/rc.conf << EOF
vmware_guest_vmblock_enable="YES"
vmware_guest_vmhgfs_enable="YES"
vmware_guest_vmmemctl_enable="YES"
vmware_guest_vmxnet_enable="YES"
vmware_guestd_enable="YES"
EOF
