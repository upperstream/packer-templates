# Packer templates for NetBSD 8.3

Templates to create Vagrant boxes for NetBSD 8.3 (amd64 and i386).

## Prerequisites

* [Packer][] v1.8.5+
* [Vagrant][] v2.2.18+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+
* [ESXi][] (vSphere Hypervisor) v5.5+
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
  "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* doas
* rsync
* ntpd
* `vagrant` user and its insecure public key

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default netbsd-8-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-8-amd64-minimal-v8.3.20240504-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-8-amd64-minimal-v8.3.20240504-virtualbox`
to your box list by the following command:

    vagrant box add NetBSD-8-amd64-minimal-v8.3.20240504-virtualbox.box --name NetBSD-8-amd64-minimal-v8.3.20240504-virtualbox

VirtualBox build intends to create amd64 box and i386 box on amd64 host device.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default netbsd-8-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-8-amd64-minimal-v8.3.20240504-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-8-amd64-minimal-v8.3.20240504-vmware`
to your box list by the following command:

    vagrant box add NetBSD-8-amd64-minimal-v8.3.20240504-vmware.box --name NetBSD-8-amd64-minimal-v8.3.20240504-vmware

VMware build intends to create amd64 box or i386 box on amd64 host
device using VMware Workstation.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `ESXI_REMOTE_HOST` - ESXi host name or IP address
* `ESXI_REMOTE_USERNAME` - ESXi login user name
* `ESXI_REMOTE_PASSWORD` - ESXi login password
* `ESXI_REMOTE_DATASTORE` - ESXi datastore name where a VM image will
  be created

You also have to enable SSH.

The following command will build a VM image on your ESXi:

    packer build -only=vmware-iso.esxi netbsd-8-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi_vnc_over_websocket=false netbsd-8-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default netbsd-8-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-8-amd64-minimal-v8.3.20240504-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-8-amd64-minimal-v8.3.20240504-libvirt`
to your box list by the following command:

    vagrant box add NetBSD-8-amd64-minimal-v8.3.20240504-libvirt.box --name NetBSD-8-amd64-minimal-v8.3.20240504-libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box and i386 box on amd64 Linux host
device.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default -var hyperv_ssh_host=xxx.xxx.xxx.xxx \
        -var hyperv_host_cidr=xxx.xxx.xxx.xxx/x \
        -var hyperv_gateway=xxx.xxx.xxx.xxx netbsd-8-minimal.pkr.hcl

Because Packer Hyper-V builder cannot detect IP address of a NetBSD VM,
you must provide static network settings so that the VM is configured to
have a static IP address.

You will find a vagrant box file named
`NetBSD-8-amd64-minimal-v8.3.20240504-hyperv.box` in the same
directory after the command has succeeded.

Then you can add the box named `NetBSD-8-amd64-minimal-v8.3.20240504`
to your box list by the following command:

    vagrant box add NetBSD-8-amd64-minimal-v8.3.20240504-hyperv.box \
        --name NetBSD-8-amd64-minimal-v8.3.20240504 --provider hyperv

## Default settings

These default settings are done by the file `Vagrantfile.NetBSD-8.3+`
which will be included in the box.  Users can override this setting by
users' own `Vagrantfile`s.

### Synced Folder

Due to limitation of Vagrant's support for NetBSD, Synced Folder of
this box is disabled by default.

Because `doas` command is installed in this box instead of `sudo`,
rsync path is set to `doas rsync` for `/vagrant` sync'ed folder by
default.  You still need to add `rsync__rsync_path: "doas rsync"`
option to your sync'ed folder settings when you choose rsync type
sync'ed folder for other locations than `/vagrant`.

### SSH Shell

Because Bash is not the standard shell for NetBSD, default shell for
SSH connection of this box is set to `/bin/sh`.

### Substituting a user during SSH command execution

Because `doas` command is installed in this box instead of `sudo`,
command for SSH command execution in privileged mode is configured to
use `doas`.

## Variants

* `netbsd-8-minimal.pkr.hcl` - NetBSD 8.3
* `netbsd-8-xorg.pkr.hcl` - NetBSD 8.3 + [X.Org][]
* `netbsd-8-dwm.pkr.hcl` - NetBSD 8.3 + X.Org + [dwm][] + [st][] +
  [dmenu][], with [XDM] enabled
* `netbsd-8-xfce.pkr.hcl` - NetBSD 8.3 + [Xfce][], with XDM enabled

While `netbsd-8-*.pkr.hcl` templates generate amd64 boxes by default,
using `vars-netbsd-8-i386.pkrvars.hcl` generates i386 boxes:

    packer build -var-file=vars-netbsd-8-i386.pkrvars.hcl netbsd-8-minimal.pkr.hcl

[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[XDM]: https://www.x.org/releases/X11R7.6/doc/man/man1/xdm.1.xhtml "XDM"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `boot_wait` - Override `boot_wait` default setting, which is `20s`.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
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
* `hostname` - Host name of the created VM.  Default value is `vagrant`.
* `hyperv_gateway` - IP address of the gateway and the name server for
  the VM being built with Hyper-V builder.  You must provide an
  appropriate value.
* `hyperv_netif` - Network interface name of the VM being build with
  Hyper-V builder.  Default value is `hvn0`.
* `hyperv_host_cidr` - CIDR notation of the VM IP address being built
  with Hyper-V builder.  You must provide an appropriate value.
* `hyperv_ssh_host` - IP address of the VM being built with Hyper-V
  builder.  You must provide an appropriate value.
* `hyperv_switch_name` - Network switch name on Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `num_cpus` - The number of virtual CPUs.  Default value is 2.
* `package_arch` - Architecture name for binary packages.  Default
* value is `amd64`.
* `package_server` - Host name to download packages from.  Default
  value is `http://cdn.netbsd.org`.
* `qemu_accelerator` - QEMU accelerator type to run the VM with.
  Default value is `kvm`.
* `qemu_binary` - Name of QEMU binary to invoke. Default value is
  `qemu-system-x86_64` for amd64 boxes and `qemu-system-i386` for i386
  boxes.
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `ssh_password` - SSH password for `ssh_username` during build time.
  Default value is `vagrant`.
* `ssh_timeout` - SSH timeout to connect this box being created.
  Defaults to `60m`.
* `ssh_username` - User name to login via SSH during build time.
  Default value is `root`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.
* `vagrant_username` - User name during run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vm_name` - VM name of the box being created.  If this value is not
  given, VM name will be determined based on NetBSD release version,
  architecture name, and variant name.
* `vmware_cdrom_adapter_type` - CD-ROM adapter type for VMware box.
  Defaults to `ide`.
* `vmware_disk_adapter_type` - Disk adapter type for VMware box.
  Defaults to `scsi`.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Defaults to `9`.
* `vmware_network` - Network type of VMware box.  Defaults value is
  `nat`.
* `vmware_network_adapter_type` - Network adapter type for VMware box.
  Default value is `e1000`.
* `vmware_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for VMware box.  Defaults to `FALSE`.

- - -

Copyright &copy; 2017-2019, 2020, 2024 Upperstream.
