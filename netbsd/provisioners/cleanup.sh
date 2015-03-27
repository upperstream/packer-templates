rm vagrant.pub
sed 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config > /tmp/sshd_config
rm -rf /root/.ssh
mv /tmp/sshd_config /etc/ssh/sshd_config
kill -HUP `cat /var/run/sshd.pid`
