sudo sed -i \
    -e '/^#PermitRootLogin /s/^#//' \
    -e '/^PermitRootLogin /s/ yes$/ no/' \
    -e '/^PermitRootLogin /s/ prohibit-password$/ no/' \
    -e '/^PermitEmptyPasswords/s/ yes$/ no/' \
    -e 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /usr/local/etc/ssh/sshd_config
sudo filetool.sh -b
