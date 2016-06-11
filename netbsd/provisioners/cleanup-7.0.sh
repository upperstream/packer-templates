sed -I 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
kill -HUP `cat /var/run/sshd.pid`
