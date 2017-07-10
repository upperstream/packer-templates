#!/bin/sh
hwclock --systohc --utc
echo ${VAGRANT_HOSTNAME:=archlinux} > /etc/hostname
echo "127.0.0.1	${VAGRANT_HOSTNAME}.localdomain	localhost" >> /etc/hosts

echo y | pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo y | pacman -S intel-ucode

echo y | pacman -S dhcpcd
interface=$(ls /sys/class/net | grep -v lo)
systemctl enable dhcpcd@${interface}.service

(echo ${ROOT_PASSWORD:=vagrant}; echo ${ROOT_PASSWORD}) | passwd

groupadd ${VAGRANT_GROUP:=${VAGRANT_USERNAME:=vagrant}}
useradd -m -g $VAGRANT_GROUP $VAGRANT_USERNAME
(echo ${VAGRANT_PASSWORD:=vagrant}; echo $VAGRANT_PASSWORD) | passwd $VAGRANT_USERNAME

mkdir -pm 700 /home/$VAGRANT_USERNAME/.ssh
curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/$VAGRANT_USERNAME/.ssh/authorized_keys
chown -R $VAGRANT_USERNAME:$VAGRANT_GROUP /home/$VAGRANT_USERNAME     
chmod -R og-rwx /home/$VAGRANT_USERNAME/.ssh

echo y | pacman -S sudo
echo "$VAGRANT_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$VAGRANT_USERNAME

echo y | pacman -S openssh
systemctl enable sshd.service

exit
