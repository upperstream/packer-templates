# Packer templates for FreeBSD 12.4-RELEASE

Templates to create Vagrant boxes for FreeBSD 12.4-RELEASE (amd64 and
i386).

## Prerequisites

* [Packer][] version 1.8.5+
* [Vagrant][] version 2.2.18+
* [VirtualBox][] version 7.0+
* [VMware][] Workstation version 17.0+ / VMware Fusion v10.0+
* [ESXi][] (vSphere Hypervisor) version 5.5+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
    "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
    "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[QEMU]: https://www.qemu.org/ "QEMU"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
    "VMware Virtualization for Desktop &amp; Server, Application,
    Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* sudo
* `vagrant` user and its insecure public key
* ntpd enabled

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default freebsd-12.4-minimal.pkr.hcl

You will find a vagrant box file named `FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-virtualbox`
to your box list by the following command:

    vagrant box add FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-virtualbox.box --name FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso freebsd-12.4-minimal.pkr.hcl

You will find a vagrant box file named `FreeBSD-12.4-RELEASE-amd64-v12.4.20221205-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-vmware`
to your box list by the following command:

    vagrant box add FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-vmware.box --name FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-vmware

In the `output` directory you will also find a VM image that can be
directly imported from VMware.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
   created

You also have to enable SSH on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=vmware-iso.esxi freebsd-12.4-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi_vnc_over_websocket=false freebsd-12.4-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu freebsd-12.4-minimal.pkr.hcl

You will find a vagrant box file named `FreeBSD-12.4-RELEASE-amd64-v12.4.20221205-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-libvirt`
to your box list by the following command:

    vagrant box add FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-libvirt.box --name FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso freebsd-12.4-minimal.pkr.hcl

You will find a vagrant box file named `FreeBSD-12.4-RELEASE-amd64-v12.4.20221205-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-hyperv`
to your box list by the following command:

    vagrant box add FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-hyperv.box --name FreeBSD-12.4-RELEASE-amd64-minimal-v12.4.20221205-hyperv

## Default settings

These default settings are done by the file `Vagrantfile.FreeBSD-11+`
which will be included in the box.  Users can override this setting by
users' own `Vagrantfile`s.

### Synced Folder

Because VirtualBox share folder on FreeBSD guest was not supported
until Vagrant 2.2.5, VirtualBox Synced Folder is disabled by default.
You can enable it in your Vagrantfile with Vagrant 2.2.5 or later, or
use other types of synced folders:

* NFS on non-Windows hosts
* RSync on any hosts.

with Vagrant older versions.  SMB synced folder is not supported for
FreeBSD guest.

### SSH Shell

Because Bash is not the standard shell for FreeBSD, default shell for
SSH connection of this box is set to `/bin/sh`.

## Variants

* `freebsd-12.4-minimal.pkr.hcl` - FreeBSD 12.4-RELEASE
* `freebsd-12.4-dwm.pkr.hcl` - FreeBSD 12.4-RELEASE + [X.Org][] +
  [dwm][] + [dmenu][] + [st][]
* `freebsd-12.4-xfce.pkr.hcl` - FreeBSD 12.4-RELEASE + [Xfce][] +
  [SLiM][]
* `freebsd-12.4-zfs.pkr.hcl` - FreeBSD 12.4-RELEASE on ZFS root
  file system

While `freebsd-12.4-*.pkr.hcl` templates generate amd64 boxes by
default, using `vars-freebsd-12.4-i386.pkrvars.hcl` generates i386 boxes:

    packer build -var-file=vars-freebsd-12.4-i386.pkrvars.hcl freebsd-12.4-minimal.pkr.hcl

[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/
  "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `disk_size` - Disk size of the creating VM.  Defaults to `50120`
  which means 50GB.
* `esxi_vnc_over_websocket` - Controlls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Defaults to `false`.
* `hyperv_netif` - Network interface for Hyper-V box.  Defaults to
  `hn0`.
* `hyperv_partition` - Disk name for Hyper-V box.  Defaults to `da0`.
* `hyperv_switch_name` - Network switch name for Packer Hyper-V builder.
  Defaults to `Default Switch`.
* `mem_size` - RAM size of the created VM.  Defaults to `1024` which
  means 1GB.
* `num_cpus` - Number of virtual CPUs.  Defaults to `2`.
* `qemu_display` - Value for `-display` option for QEMU.  Defaults to
  an empty string.
* `qemu_netif` - Network interface for QEMU box.  Defaults to `vtnet0`.
* `qemu_partition` - Disk name for QEMU box.  Defaults to `vtbd0`.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Defaults to `false`.
* `root_password` - Password for `root` user.  Defaults to `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Defaults to `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Defaults to
  `vagrant`.  This is also used for SSH password during build time.
* `vagrant_username` - User name used for runtime.  Vagrant box is set
  for this user.  Defaults to `vagrant`.
  This is also used for SSH user name during build time.
* `virtualbox_netif` - Network interface for VirtualBox box.  Defaults
  to `em0`.
* `virtualbox_partition` - Disk name for VirtualBox box.  Defaults to
  `ada0`.
* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `vmware_netif` - Network interface name for VMware box.  Defaults to
  `em0`.
* `vmware_partition` - Disk name for VMware box.  Defaults to `da0`.

- - -

Copyright &copy; 2023 Upperstream Software.
