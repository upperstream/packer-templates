echo "$(date): Filling the remaining disk space with 0x00.  This will take long (appr. 15 minutes per 100GB)."
sudo dd if=/dev/zero of=/mnt/sda1/zero.bin
sudo rm /mnt/sda1/zero.bin
