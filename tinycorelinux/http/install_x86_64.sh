tce-load -wi grub2-multi.tcz

sudo fdisk /dev/sda << EOF
n
p
1


a
1
w
EOF

sudo mkfs.ext4 /dev/sda1

sudo rebuildfstab
 
sudo mount /mnt/sda1
sudo mkdir -p /mnt/sda1/boot/grub
sudo mount /mnt/sr0
sudo cp -p /mnt/sr0/boot/* /mnt/sda1/boot/

sudo mkdir -p /mnt/sda1/tce
sudo touch /mnt/sda1/tce/mydata.tgz

sudo grub-install --no-floppy --root-directory=/mnt/sda1 /dev/sda 

sudo sh -c 'cat > /usr/local/etc/grub.d/42_custom' << EOF
set default=0
set timeout=10
menuentry "$GRUB_ENTRY_NAME" {
  set root=(hd0,msdos1)
  linux /boot/vmlinuz64 restore=sda1/tce quiet waitusb=5
  initrd /boot/corepure64.gz
}
EOF
sudo cp /usr/local/etc/grub.d/42_custom /mnt/sda1/boot/grub/grub.cfg
sudo sh -c 'echo "usr/local/etc/grub.d" >> /opt/.filetool.lst'

tce-load -wil curl.tcz make.tcz

tce-setdrive

tce-load -wi openssh.tcz

sudo sh -c "sed 's/^#PermitEmptyPasswords no$/PermitEmptyPasswords yes/' /usr/local/etc/ssh/sshd_config.orig > /usr/local/etc/ssh/sshd_config"
sudo sh -c 'echo "usr/local/etc/ssh" >> /opt/.filetool.lst'

tce-load -wi rsync.tcz nfs-utils.tcz

sudo /usr/local/etc/init.d/openssh start
sudo sh -c 'cat >> /opt/bootsync.sh' << EOF
ssh-keygen -A
/usr/local/etc/init.d/openssh start
EOF
