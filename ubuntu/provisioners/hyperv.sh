#!/bin/sh -ex
mkdir -p /usr/libexec/hypervkvpd
ln -s /usr/sbin/hv_get_dns_info /usr/sbin/hv_get_dhcp_info /usr/libexec/hypervkvpd
