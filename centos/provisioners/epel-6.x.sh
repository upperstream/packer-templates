#!/bin/sh -ex
# EPEL
yum -y install yum-plugin-priorities-${YUM_PLUGIN_PRIORITIES:-1.1.30-30.el6}
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/$(uname -i)/epel-release-6-8.noarch.rpm
