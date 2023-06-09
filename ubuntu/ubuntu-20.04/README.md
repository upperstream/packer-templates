# Packer templates for Ubuntu 20.04.6 LTS

Templates to create Vagrant boxes for Ubuntu 20.04.6 LTS (amd64 and arm64).

## Prerequisites

* [Packer][] v1.6.6+
* [Vagrant][] v2.3.6+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) v7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Parallels][] Desktop 18+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/products/desktop/ "Run Windows on Mac - Parallels Desktop 18 Virtual Machine for Mac"
[QEMU]: https://www.qemu.org/ "QEMU"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
    "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

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

    packer build -only=virtualbox-iso.default ubuntu-20.04-minimal.pkr.hcl

You will find a vagrant box file named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323`
to your box list by the following command:

    vagrant box add Ubuntu-20.04-amd64-minimal-v2004.6.20230323-virtualbox.box --name Ubuntu-20.04-amd64-minimal-v2004.6.20230323 --provider virtualbox

VirtualBox build intends to create amd64 box on amd64 device.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default ubuntu-20.04-minimal.pkr.hcl

You will find a vagrant box file named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323`
to your box list by the following command:

    vagrant box add Ubuntu-20.04-amd64-minimal-v2004.6.20230323-vmware.box --name Ubuntu-20.04-amd64-minimal-v2004.6.20230323 --provider vmware_desktop

VMware build intends to create amd64 box on amd64 device using VMware
Workstation, or create arm64 box on Apple Silicon Mac device using
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

    packer build -only=vmware-iso.esxi ubuntu-20.04-minimal.pkr.hcl

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi-vnc-over-websocket=false ubuntu-20.04-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default ubuntu-20.04-minimal.pkr.hcl

You will find a vagrant box file named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323-libvirt.box` in the same
directory after the command has succeeded.

Then you can add the box named `Ubuntu-20.04-amd64-minimal-v2004.6.20230323`
to your box list by the following command:

    vagrant box add Ubuntu-20.04-amd64-minimal-v2004.6.20230323-libvirt.box --name Ubuntu-20.04-amd64-minimal-v2004.6.20230323 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box on amd64 Linux device.

### Parallels

From the terminal, invoke the following command for Parallels provider:

    packer build -only=parallels-iso.default -var-file vars-ubuntu-20.04-arm64.pkrvars.hcl ubuntu-20.04-minimal.pkr.hcl

You will find a vagrant box file named `Ubuntu-20.04-arm64-minimal-v2004.5.20220901-parallels.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-20.04-arm64-minimal-v2004.5.20220901`
to your box list by the following command:

    vagrant box add Ubuntu-20.04-arm64-minimal-v2004.5.20220901-parallels.box --name Ubuntu-20.04-arm64-minimal-v2004.5.20220901 --provider parallels

Parallels build intends to create arm64 box on Apple Silicon Mac device.

## Variants

* `ubuntu-20.04-minimal.pkr.hcl` - Ubuntu Server 20.04 LTS
* `ubuntu-20.04-dwm.pkr.hcl` - Ubuntu 20.04 LTS + [X.org][],
  [suckless][] tools, [ARandR][], and [xrdp][].
* `ubuntu-20.04-lxqt.pkr.hcl` - Ubuntu 20.04 LTS + [LXQt][]
* `ubuntu-20.04-xfce.pkr.hcl` - Ubuntu 20.04 LTS + [Xfce][]

[ARandR]: https://christian.amsuess.com/tools/arandr/
    "ARandR: Another XRandR GUI"
[LXQt]: https://lxqt-project.org/ "LXQt - The Lightweight Qt Desktop
    Environment"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: https://xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Installer CD images

While `ubuntu-20.04-*.pkr.hcl` templates use `ubuntu-20.04.6-live-server-amd64.iso`
ISO image to create amd64 boxes by default, using `vars-ubuntu-20.04-arm64.pkrvars.hcl`
creates arm64 boxes with `ubuntu-20.04.5-live-server-arm64.iso` ISO
image:

    packer build -var-file=vars-ubuntu-20.04-arm64.pkrvars.hcl ubuntu-20.04-minimal.pkr.hcl

Note that arm64 ISO image stays with version 20.04.5 rather than
version 20.04.6.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `archive_mirror` - URL to download packages from.  Default value is
  `http://archive.ubuntu.com/ubuntu`.
* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `disk_size` - Disk size of the created box.  Defaults to `51200`,
  which means 50GB.
* `esxi_remote_datastore` - ESXi datastore name to create this box in.
* `esxi_remote_host` - Remote host name of the ESXi server to create
  this box on.
* `esxi_remote_password` - SSH password for the ESXi server to create
  this box.
* `esxi_remote_username` - SSH username for the ESXi server to create
  this box.
* `esxi_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for ESXi box.  Defaults to `TRUE`.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Defaults to `false`.
* `mem_size` - RAM size of the created box.  Defaults to `1024`, `1536`
  for `dwm` variant, and `2048` for `xfce` variant.
* `num_cpus` - The number of virtual CPUs.  Defaults to 2.
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
* `vm_name` - VM name of the box being created.  If this value is not
  given, VM name will be determined based on Ubuntu version, CPU name,
  and variant name.
* `vmware_cdrom_adapter_type` - CD-ROM adapter type for VMware box.
  Defaults to `ide`.
* `vmware_disk_adapter_type` - Disk adapter type for VMware box.
  Defaults to `scsi`.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Defaults to `9`.
* `vmware_network` - Network type of VMware box.  Defaults to `nat`.
* `vmware_network_adapter_type` - Network adapter type of VMware box.
  Defaults to `e1000`.
* `vmware_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for VMware box.  Defaults to `FALSE`.

- - -

Copyright &copy; 2023 Upperstream Software.
