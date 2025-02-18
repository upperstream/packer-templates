# Packer templates for FreeBSD 13.5-BETA2

Templates to create Vagrant boxes for FreeBSD 13.5-BETA2 (amd64, i386, and arm64)

## Prerequisites

* [Packer][] v1.10+
* [Vagrant][] v2.4+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) v7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10
* [Parallels][] Desktop 19+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]:
  https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/products/desktop/
  "Parallels Desktop18 for Mac"
[QEMU]: https://www.qemu.org/ "QEMU"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application,
  Public &amp; Hybrid Clouds"

## Provisioned software tools

* VirtualBox Guest Additions, [open-vm-tools][], or Hyper-V daemons
* sshd
* doas
* `vagrant` user and its insecure public key
* ntpd enabled

[open-vm-tools]: https://github.com/vmware/open-vm-tools
  "Official repository of VMware open-vm-tools project"

Note that `sudo` is not installed while `doas` is.

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default freebsd-13.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-virtualbox.box` in
the same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-13.5-BETA-minimal-v2.20250214` to your box list by
the following command:

    vagrant box add FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-virtualbox.box --name FreeBSD-13.5-BETA-minimal-v2.20250214 --provider virtualbox

VirtualBox build intends to create amd64 box and i386 box on amd64 host.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default freebsd-13.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-13.5-BETA-v2.20250214-amd64-vmware.box` in the same
directory after the command has succeeded.

Then you can add the box named
`FreeBSD-13.5-BETA-minimal-v2.20250214` to your box list by
the following command:

    vagrant box add FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-vmware.box --name FreeBSD-13.5-BETA-minimal-v2.20250214 --provider vmware_desktop

VMware build intends to create amd64 and i386 boxes on amd64 host, and
aarch64 box on Apple Silicon Mac host.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `ESXI_REMOTE_HOST` - ESXi host name or IP address
* `ESXI_REMOTE_USERNAME` - ESXi login user name
* `ESXI_REMOTE_PASSWORD` - ESXi login password
* `ESXI_REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
  created

You also have to enable SSH on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=vmware-iso.esxi freebsd-13.5-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi_vnc_over_websocket=false freebsd-13.5-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default freebsd-13.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-libvirt.box` in the same
directory after the command has succeeded.

Then you can add the box named
`FreeBSD-13.5-BETA-minimal-v2.20250214` to your box list by
the following command:

    vagrant box add FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-libvirt.box --name FreeBSD-13.5-BETA-minimal-v2.20250214 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box and i386 box on amd64 Linux
host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default freebsd-13.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-hyperv.box` in the same
directory after the command has succeeded.

Then you can add the box named
`FreeBSD-13.5-BETA-minimal-v2.20250214` to your box list by
the following command:

    vagrant box add FreeBSD-13.5-BETA-minimal-v2.20250214-amd64-hyperv.box --name FreeBSD-13.5-BETA-minimal-v2.20250214 --provider hyperv

Hyper-V build intends to create amd64 box and i386 box on Windows
host.

### Parallels

From the terminal, invoke the following command for Parallels provider:

    packer build -only=parallels-iso.default -var-file vars-freebsd-13.5-aarch64.pkrvars.hcl freebsd-13.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-13.5-BETA-minimal-v2.20250214-aarch64-parallels.box` in the same
directory after the command has succeeded.

Then you can add the box named
`FreeBSD-13.5-BETA-minimal-v2.20250214` to your box list
by the following command:

    vagrant box add FreeBSD-13.5-BETA-minimal-v2.20250214-aarch64-parallels.box --name FreeBSD-13.5-BETA-minimal-v2.20250214 --provider parallels

Parallels build intends to create aarch64 box on Apple Silicon Mac
host.

## Default settings

These default settings are done by the file `Vagrantfile.FreeBSD-13.2+`
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

Because `doas` command is installed in this box instead of `sudo`,
rsync path is set to `doas rsync` for `/vagrant` sync'ed folder by
default.  You still need to add `rsync__rsync_path: "doas rsync"`
option to your sync'ed folder settings when you choose rsync type
sync'ed folder for other locations than `/vagrant`.

### SSH Shell

Because Bash is not the standard shell for FreeBSD, default shell for
non-interactive SSH connection of this box is set to `/bin/sh`.

### Substituting a user during SSH command execution

Because `doas` command is installed in this box instead of `sudo`,
command for SSH command execution in privileged mode is configured to
use `doas`.

## Variants

* `freebsd-13.5-minimal.pkr.hcl` - FreeBSD 13.5-BETA2
* `freebsd-13.5-dwm.pkr.hcl` - FreeBSD 13.5-BETA2 + [X.Org][] +
  [dwm][] + [dmenu][] + [st][]
* `freebsd-13.5-xfce.pkr.hcl` - FreeBSD 13.5-BETA2 + [Xfce][] +
  [SLiM][]
* `freebsd-13.5-zfs.pkr.hcl` - FreeBSD 13.5-BETA2 on ZFS root
  file system

While `freebsd-13.5-*.pkr.hcl` templates generate amd64 boxes by
default, using `vars-freebsd-13.5-aarch64.pkrvars.hcl` generates
aarch64 boxes:

    packer build -var-file=vars-freebsd-13.5-aarch64.pkrvars.hcl freebsd-13.5-minimal.pkr.hcl

and using `vars-freebsd-13.5-i386.pkrvars.hcl` generates i386
boxes:

    packer build -var-file=vars-freebsd-13.5-i386.pkrvars.hcl freebsd-13.5-minimal.pkr.hcl

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

* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `disk_size` - Disk size of the creating VM.  Defaults to `50120`
  which means 50GB.
* `esxi_hardware_version` - Virtual hardware version of ESXi box.
  Defaults to `19`.
* `esxi_remote_datastore` - ESXi datastore name where a VM image will
  be created.
* `esxi_remote_host` - ESXi host name or IP address.
* `esxi_remote_password` - ESXi login password.
* `esxi_remote_username` - ESXi login user name.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
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
* `parallels_netif` - Network interface for Parallels box.  Defaults to
  `vtnet0`.
* `parallels_partition` - Disk name for Parallels box.  Defaults to
  `ada0`.
* `qemu_accelerator` - Accelerator for QEMU.  Defaults to `kvm`.
* `qemu_binary` - QEMU binary name.  Defaults to `qemu-system-x86_64`.
* `qemu_display` - Value for `-display` option for QEMU.  Defaults to
  an empty string.
* `qemu_machine_type` - Machine type for QEMU.  Defaults to `pc`.
* `qemu_netif` - Network interface for QEMU box.  Defaults to `vtnet0`.
* `qemu_partition` - Disk name for QEMU box.  Defaults to `vtbd0`.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Defaults to `false`.
* `root_password` - Password for `root` user.  Defaults to `vagrant`.
* `ssh_timeout` - SSH timeout to connect this box being created.
  Defaults to `60m`.
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
* `vmware_disk_adapter_type` - Disk adapter type for VMware.  Defaults
  to `scsi`.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Defaults to `13`.
* `vmware_netif` - Network interface name for VMware box.  Defaults to
  `em0`.
* `vmware_network_adapter_type` - Network adapter type for VMware.
  Defaults to `e1000`.
* `vmware_partition` - Disk name for VMware box.  Defaults to `da0`.

- - -

Copyright &copy; 2025 Upperstream.
