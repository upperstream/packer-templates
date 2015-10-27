rm vagrant.pub
sed -I 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
rm -rf /root/.ssh
kill -HUP `cat /var/run/sshd.pid`
