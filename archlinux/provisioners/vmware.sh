#!/bin/sh
echo y | sudo pacman -S open-vm-tools
test -s /etc/arch-release || sudo ch -c "cat /proc/version > /etc/arch-release"
sudo systemctl enable vmtoolsd
