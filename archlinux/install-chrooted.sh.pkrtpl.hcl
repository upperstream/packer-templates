#!/bin/sh
%{ for config_key, config_value in variables }
export ${config_key}=${config_value}
%{ endfor ~}

hwclock --systohc --utc
echo "$${VAGRANT_HOSTNAME:=archlinux}" > /etc/hostname
echo "127.0.0.1	$${VAGRANT_HOSTNAME}.localdomain	localhost" >> /etc/hosts

echo y | pacman -S grub
grub-install --target=i386-pc "/dev/$DISK"
grub-mkconfig -o /boot/grub/grub.cfg
echo y | pacman -S intel-ucode amd-ucode

echo y | pacman -S dhcpcd
systemctl enable dhcpcd.service

(echo "$${ROOT_PASSWORD:=vagrant}"; echo "$${ROOT_PASSWORD}") | passwd

groupadd "$${VAGRANT_GROUP:=$${VAGRANT_USERNAME:=vagrant}}"
useradd -m -g "$VAGRANT_GROUP" "$VAGRANT_USERNAME"
(echo "$${VAGRANT_PASSWORD:=vagrant}"; echo "$VAGRANT_PASSWORD") | passwd "$VAGRANT_USERNAME"

# shellcheck disable=SC2174
mkdir -pm 700 "/home/$VAGRANT_USERNAME/.ssh"
curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > "/home/$VAGRANT_USERNAME/.ssh/authorized_keys"
chown -R "$VAGRANT_USERNAME":"$VAGRANT_GROUP" "/home/$VAGRANT_USERNAME"
chmod -R og-rwx "/home/$VAGRANT_USERNAME/.ssh"

echo y | pacman -S sudo
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD:ALL" >> "/etc/sudoers.d/$VAGRANT_USERNAME"

echo y | pacman -S openssh
systemctl enable sshd.service

if [ "$CONFIG_HYPERV_GUEST" = "yes" ]; then
  echo y | pacman -S hyperv
  systemctl enable hv_kvp_daemon.service
  systemctl enable hv_vss_daemon.service
fi
exit
