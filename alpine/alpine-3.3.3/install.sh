mount -t ext4 /dev/sda3 /mnt
apk add --root=/mnt openssl
apk add --root=/mnt sudo
apk add --root=/mnt openssh
ln -s /etc/init.d/sshd /mnt/etc/runlevels/default/sshd
sed -i 's/^#PermitRootLogin .*/PermitRootLogin yes/' /mnt/etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /mnt/etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /mnt/etc/ssh/sshd_config
sed -i 's/^#UseDNS no/UseDNS no/' /mnt/etc/ssh/sshd_config
reboot
