# Packer templates for Ubuntu 24.04.3 LTS

Templates to create Vagrant boxes for Ubuntu 24.04.3 LTS (amd64 and
arm64).

## Prerequisites

* [Packer][] v1.10+
* [Vagrant][] v2.4+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) v7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10
* [Parallels][] Desktop 18+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]:
  https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/products/desktop/
  "Run Windows on Mac - Parallels Desktop 18 Virtual Machine for Mac"
[QEMU]: https://www.qemu.org/ "QEMU"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public
  &amp; Hybrid Clouds"

## Provisioned software tools

* VirtualBox Guest Additions, [open-vm-tools][], or Parallels Tools
* sshd
* sudo
* `vagrant` user and its insecure public key

[open-vm-tools]: https://github.com/vmware/open-vm-tools
    "Official repository of VMware open-vm-tools project"

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default ubuntu-24.04-minimal.pkr.hcl

You will find a vagrant box file named
`Ubuntu-24.04-minimal-v2404.3.20250807-amd64-virtualbox.box` in the
same directory after the command has succeeded.

Then you can add the box named `Ubuntu-24.04-minimal-v2404.3.20250807`
to your box list by the following command:

    vagrant box add Ubuntu-24.04-minimal-v2404.3.20250807-amd64-virtualbox.box \
      --name Ubuntu-24.04-minimal-v2404.3.20250807 --provider virtualbox

VirtualBox build intends to create amd64 box on amd64 host.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default ubuntu-24.04-minimal.pkr.hcl

You will find a vagrant box file named
`Ubuntu-24.04-minimal-v2404.3.20250807-amd64-vmware.box` in the same
directory after the command has succeeded.

Then you can add the box named `Ubuntu-24.04-minimal-v2404.3.20250807`
to your box list by the following command:

    vagrant box add Ubuntu-24.04-minimal-v2404.3.20250807-amd64-vmware.box \
      --name Ubuntu-24.04-minimal-v2404.3.20250807 --provider vmware_desktop

VMware build intends to create amd64 box on amd64 host using VMware
Workstation, or create arm64 box on Apple Silicon Mac host using
VMware Fusion.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `ESXI_REMOTE_HOST` - ESXi host name or IP address
* `ESXI_REMOTE_USERNAME` - ESXi login user name
* `ESXI_REMOTE_PASSWORD` - ESXi login password
* `ESXI_REMOTE_DATASTORE` - ESXi datastore name where a VM image will
  be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=vmware-iso.esxi ubuntu-24.04-minimal.pkr.hcl

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi-vnc-over-websocket=false ubuntu-24.04-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default ubuntu-24.04-minimal.pkr.hcl

You will find a vagrant box file named
`Ubuntu-24.04-minimal-v2404.3.20250807-amd64-libvirt.box` in the same
directory after the command has succeeded.

Then you can add the box named `Ubuntu-24.04-minimal-v2404.3.20250807`
to your box list by the following command:

    vagrant box add Ubuntu-24.04-minimal-v2404.3.20250807-amd64-libvirt.box \
      --name Ubuntu-24.04-minimal-v2404.3.20250807 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box on amd64 Linux host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default ubuntu-24.04-minimal.pkr.hcl

You will find a vagrant box file named
`Ubuntu-24.04-minimal-v2404.3.20250807-amd64-hyperv.box` in the same
directory after the command has succeeded.

Then you can add the box named `Ubuntu-24.04-minimal-v2404.3.20250807`
to your box list by the following command:

    vagrant box add Ubuntu-24.04-minimal-v2404.3.20250807-amd64-hyperv.box \
      --name Ubuntu-24.04-minimal-v2404.3.20250807 --provider hyperv

Hyper-V build intends to create amd64 box on Windows host.

### Parallels

From the terminal, invoke the following command for Parallels provider:

    packer build -only=parallels-iso.default \
      -var-file vars-ubuntu-24.04-arm64.pkrvars.hcl ubuntu-24.04-minimal.pkr.hcl

You will find a vagrant box file named
`Ubuntu-24.04-minimal-v2404.3.20250807-arm64-parallels.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-24.04-minimal-v2404.3.20250807`
to your box list by the following command:

    vagrant box add Ubuntu-24.04-minimal-v2404.3.20250807-arm64-parallels.box \
      --name Ubuntu-24.04-minimal-v2404.3.20250807 --provider parallels

Parallels build intends to create arm64 box on Apple Silicon Mac host.

## Variants

* `ubuntu-24.04-minimal.pkr.hcl` - Ubuntu Server 24.04.3 LTS
* `ubuntu-24.04-dwm.pkr.hcl` - Ubuntu 24.04.3 LTS + [X.org][],
  [dwm][], [suckless][] tools, [ARandR][], and [xrdp][].
* `ubuntu-24.04-lxqt.pkr.hcl` - Ubuntu 24.04.3 LTS + [LXQt][]
* `ubuntu-24.04-xfce.pkr.hcl` - Ubuntu 24.04.3 LTS + [Xfce][]

[ARandR]: https://christian.amsuess.com/tools/arandr/
    "ARandR: Another XRandR GUI"
[dwm]: https://dwm.suckless.org/ "dwm - dynamic window manager"
[LXQt]: https://lxqt-project.org/ "LXQt - The Lightweight Qt Desktop
    Environment"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: https://xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Installer ISO images

While `ubuntu-24.04-*.pkr.hcl` templates use `ubuntu-24.04.3-live-server-amd64.iso`
ISO image to create amd64 boxes by default, using `vars-ubuntu-24.04-arm64.pkrvars.hcl`
creates arm64 boxes with `ubuntu-24.04.3-live-server-arm64.iso` ISO
image:

    packer build -var-file=vars-ubuntu-24.04-arm64.pkrvars.hcl ubuntu-24.04-minimal.pkr.hcl

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `archive_mirror` - URL to download packages from.  Default value is
  `http://archive.ubuntu.com/ubuntu`.
* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `disk_size` - Disk size of the created box.  Defaults to `51200`,
  which means 50GB.
* `esxi_boot_mode` - Boot mode for ESXi box.  Defaults to `efi`.
* `esxi_guest_os_type` - Guest OS type of ESXi box.  Defaults to
  `debian11-64`.  Change to `other5xlinux-64` or `other5xlinux` if you
  want to use USB 3.1 controller with this box.
* `esxi_hardware_version` - Virtual hardware version of ESXi box.
  Defaults to `19`.
* `esxi_remote_datastore` - ESXi datastore name to create this box in.
* `esxi_remote_host` - Remote host name of the ESXi server to create
  this box on.
* `esxi_remote_password` - SSH password for the ESXi server to create
  this box.
* `esxi_remote_username` - SSH username for the ESXi server to create
  this box.
* `esxi_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for ESXi box.  Defaults to `false`.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Defaults to `false`.
* `hyperv_boot_mode` - Boot mode for Hyper-V VM, `bios` or `efi`.
  Defaults to `bios`.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created box.  Defaults to `2048` for
  minimal variant; or `4096` for `dwm`, `lxqt`, and `xfce` variants.
* `num_cpus` - The number of virtual CPUs.  Defaults to 2.
* `parallels_boot_mode` - Boot mode for Parallels box.  Defaults to
  `efi`.
* `qemu_boot_mode` - Boot mode for QEMU box.  Defaults to `efi`.
* `qemu_display` - What QEMU `-display` option to use.  Defaults to an
  empty string.
* `qemu_use_default_display` - Determines to pass a `-display` option
  to QEMU or not.  Defaults to `false`.
* `vagrant_password` - Password for `vagrant_username`.  Defaults to
  `vagrant`.
* `vagrant_ssh_public_key` - SSH public key for Vagrant user.  Defaults
  to the public key for the Vagrant insecure private key.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `virtualbox_boot_mode` - Boot mode for VirtualBox box.  Defaults to
  `efi`.
* `vm_name` - VM name of the box being created.  If this value is not
  given, VM name will be determined based on Ubuntu version, CPU name,
  and variant name.
* `vmware_boot_mode` - Boot mode for VMware box.  Defaults to `efi`.
* `vmware_cdrom_adapter_type` - CD-ROM adapter type for VMware box.
  Defaults to `ide`.
* `vmware_disk_adapter_type` - Disk adapter type for VMware box.
  Defaults to `scsi`.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Defaults to `13`.
* `vmware_network` - Network type of VMware box.  Defaults to `nat`.
* `vmware_network_adapter_type` - Network adapter type of VMware box.
  Defaults to `e1000`.
* `vmware_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for VMware box.  Defaults to `false`.

- - -

Copyright &copy; 2024, 2025 Upperstream.
