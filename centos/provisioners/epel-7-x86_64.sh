#!/bin/sh -ex
# EPEL
if ! (md5sum epel-release-7-8.noarch.rpm | grep 8c2d7a86160d3f55f8d45730d325d0a6); then
  curl -O http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
fi
rpm -ivh epel-release-7-8.noarch.rpm
