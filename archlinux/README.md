# Packer templates for Arch Linux 2025.08.01

Templates to create Vagrant boxes for Arch Linux.

## Prerequisites

* [Packer][] version 1.8.7+
* [Vagrant][] version 2.2.18+
* [Virtualbox][] version 7.0+
* [VMware][] Workstation version 17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) version 7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/
  "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[QEMU]: https://www.qemu.org/
  "QEMU"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default archlinux-minimal.pkr.hcl

You will find a vagrant box file named `ArchLinux-minimal-20250801.0-x86_64-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `ArchLinux-minimal-20250801.0-x86_64`
 to your box list by the following command:

    vagrant box add ArchLinux-minimal-20250801.0-x86_64-virtualbox.box \
      --name ArchLinux-minimal-20250801.0-x86_64 --provider virtualbox

VirtualBox build intends to create x86_64 box on x86_64 host.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default archlinux-minimal.pkr.hcl

You will find a vagrant box file named `ArchLinux-minimal-20250801.0-x86_64-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `ArchLinux-minimal-20250801.0-x86_64`
to your box list by the following command:

    vagrant box add ArchLinux-minimal-20250801.0-x86_64-vmware.box \
      --name ArchLinux-minimal-20250801.0-x86_64 --provider vmware_desktop

VMware build intends to create x86_64 box on x86_64 host.

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

    packer build -only=esxi-iso archlinux-minimal.json

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi_vnc_over_websocket=false archlinux-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default archlinux-minimal.pkr.hcl

You will find a vagrant box file named
`ArchLinux-minimal-20250801.0-x86_64-libvirt.box` in the
same directory after the command has succeeded.

Then you can add the box named
`ArchLinux-minimal-20250801.0-x86_64`
to your box list by the following command:

    vagrant box add \
      ArchLinux-minimal-20250801.0-x86_64-libvirt.box \
      --name ArchLinux-minimal-20250801.0-x86_64 \
      --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create x86_64 box and x86 box on x86_64 Linux
host.

### Hyper-V

NOTE: Hyper-V build is broken because hv_fcopy_daemon.service has been removed.

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default archlinux-minimal.pkr.hcl

You will find a vagrant box file named
`ArchLinux-minimal-20250801.0-x86_64-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named
`ArchLinux-minimal-20250801.0-x86_64`
to your box list by the following command:

    vagrant box add \
      ArchLinux-minimal-20250801.0-x86_64-hyperv.box \
      --name ArchLinux-minimal-20250801.0-x86_64 \
      --provider hyperv

Hyper-V build intends to create x86 box and x86_64 box on Windows 10
host.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `boot_wait` - Wait for booting virtual machine.  Default value is
  `10s`.
* `disk_size` - Disk size of the created VM.  Default value is `40960`,
  which means 40GB.
* `esxi_disk_name` - Disk name for ESXi box.
* `esxi_remote_datastore` - ESXi datastore name where a VM image will
  be created.
* `esxi_remote_host` - ESXi host name or IP address.
* `esxi_remote_password` - ESXi login password.
* `esxi_remote_username` - ESXi login user name.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `hyperv_disk_name` - Disk name for Hyper-V box.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created VM.  Default value is `1024`,
  which means 1024MB.
* `mirror_site` - Arch Linux mirror site to download Arc Linux stuff.
  Default value is `https://geo.mirror.pkgbuild.com`.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `qemu_disk_name` - Disk name for QEMU box.
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `root_password` - Password for `root` user.  Default value is
  `vagrant`.
* `ssh_timeout` - Timeout for SSH connection.  Default value is `60m`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `virtualbox_disk_name` - Disk name for VirtualBox box.
* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `vmware_disk_name` - Disk name for VMware box.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Default value is `9`.
* `vmware_network` - Network type of VMware box.  Default value is
  `nat`.
* `vmware_network_adapter_type` - Network adapter type for VMware box.
  Default value is `e1000`.
* `vmware_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for VMware box.  Default value is `FALSE`.

- - -

Copyright &copy; 2017, 2018, 2024, 2025 Upperstream.
