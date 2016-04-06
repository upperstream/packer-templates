test -f /root/.ssh/authorized_keys && sed -i '/^ssh-rsa.*vagrant insecure public key$/d' /root/.ssh/authorized_keys
rm -f /root/VBoxGuestAdditions*
