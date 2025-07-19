partition="${disk}1"

tce-load -wil grub2-multi.tcz liblvm2.tcz

sudo fdisk /dev/${disk} << EOF
n
p
1


a
1
w
EOF

sudo mkfs.ext4 /dev/$partition

sudo rebuildfstab

sudo mount /mnt/$partition
sudo mkdir -p /mnt/$partition/boot/grub
sudo mount /mnt/sr0
sudo cp -p /mnt/sr0/boot/* /mnt/$partition/boot/

sudo mkdir -p /mnt/$partition/tce
dd if=/dev/zero bs=1024 count=1 | gzip -c | sudo tee /mnt/$partition/tce/mydata.tgz

sudo grub-install --no-floppy --root-directory=/mnt/$partition /dev/${disk}

cat << EOF | sudo tee /usr/local/etc/grub.d/42_custom
set default="0"
set timeout=10
menuentry "$GRUB_ENTRY_NAME" {
  set root=(hd0,msdos1)
  linux /boot/${kernel_image} restore=$partition/tce quiet waitusb=5
  initrd /boot/${ramdisk}
}
EOF
sudo cp /usr/local/etc/grub.d/42_custom /mnt/$partition/boot/grub/grub.cfg
echo "usr/local/etc/grub.d" | sudo tee -a /opt/.filetool.lst

tce-load -wil curl.tcz make.tcz

tce-setdrive -s /mnt/$partition

tce-load -wi openssh.tcz

sed 's/^#PermitEmptyPasswords no$/PermitEmptyPasswords yes/' /usr/local/etc/ssh/sshd_config.orig | sudo tee /usr/local/etc/ssh/sshd_config
echo "usr/local/etc/ssh" | sudo tee -a /opt/.filetool.lst

tce-load -wil rsync.tcz nfs-utils.tcz

sudo /usr/local/etc/init.d/openssh start
cat << EOF | sudo tee -a /opt/bootsync.sh
ssh-keygen -A
/usr/local/etc/init.d/openssh start
EOF
