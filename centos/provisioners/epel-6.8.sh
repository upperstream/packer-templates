#!/bin/sh -x
# EPEL
yum -y install yum-plugin-priorities-1.1.30-37.el6
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/$(uname -i)/epel-release-6-8.noarch.rpm
