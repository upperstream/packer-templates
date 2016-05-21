cp /etc/ssh/sshd_config /tmp/sshd_config
sed '/^PermitRootLogin/s/ yes$/ no/' /tmp/sshd_config > /etc/ssh/sshd_config
rm /tmp/sshd_config
