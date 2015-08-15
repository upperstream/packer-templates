sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
test -d /etc/sudoers.d || (echo "Making directoryetc/sudoers.d"; mkdir -p /etc/sudoers.d)
grep -F "#includedir /etc/sudoers.d" /etc/sudoers || (echo 'Adding "#includedir /etc/sudoers.d" to /etc/sudoers'; echo "#includedir /etc/sudoers.d" >> /etc/sudoers)
