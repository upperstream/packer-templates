#!/bin/sh
set -ex
sudo sh -c "echo loop > /etc/modules-load.d/loop.conf"
sudo modprobe loop
echo y | sudo pacman -S docker
sudo systemctl enable docker.service
sudo usermod -G docker -a $VAGRANT_USERNAME
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo sh -c "cat >> /etc/systemd/system/docker.service.d/override.conf" << EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -s overlay2
EOF
