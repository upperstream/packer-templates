#!/bin/sh -ex
linux_release=`uname -r`
arch="${ARCH:-x86_64}"
# shellcheck disable=SC1091
tc_version=`. /etc/os-release; echo "${VERSION_ID%.*}.x"`
tarball=linux-${linux_release%-*}-patched.tar.xz
download_url=http://tinycorelinux.net/$tc_version/$arch/release/src/kernel/$tarball
dest=/mnt/${DISK}1/$tarball
src_dir=${dest%/*}/src
linux_dir=linux-${linux_release%-*}
kernel_config=config-$linux_release

if [ ! -f "$dest" ]; then
	sudo wget -T 7200 -O "$dest" "$download_url"
	xz -tv "$dest" || { echo "tarball verification failed"; exit 1; }
fi

if [ ! -d "$src_dir"/"$linux_dir" ]; then
	if [ ! -d "$src_dir" ]; then
		sudo mkdir -p "$src_dir"
		sudo chmod og+rwx "$src_dir"
	fi
	tar x -Jf "$dest" -C "$src_dir" || { echo "tarball extraction failed"; exit 1; }
fi

if [ ! -h /usr/src/"$linux_dir" ]; then
	if [ ! -d /usr/src ]; then
		sudo mkdir -p /usr/src
	fi
	sudo ln -s "$src_dir"/"$linux_dir" /usr/src/
fi

if [ ! -f "$src_dir"/"$linux_dir"/.config ]; then
	wget -T 7200 -O "$src_dir"/"$linux_dir"/.config http://tinycorelinux.net/"$tc_version"/"$arch"/release/src/kernel/"$kernel_config"
fi
