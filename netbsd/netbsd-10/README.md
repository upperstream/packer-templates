# Packer templates for NetBSD 10.1

Templates to create Vagrant boxes for NetBSD 10.1 (amd64, i386, and aarch64).

## Prerequisites

* [Packer][] v1.10+
* [Vagrant][] v2.3+
* [VirtualBox][] version 7.0+
* [VMware][] Workstation version 17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) version 7.0+
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

    packer build -only=virtualbox-iso.default netbsd-10-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-10-minimal-v10.1.20241216-amd64-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-10-minimal-v10.1.20241216`
to your box list by the following command:

    vagrant box add NetBSD-10-minimal-v10.1.20241216-amd64-virtualbox.box \
        --name NetBSD-10-minimal-v10.1.20241216-amd64 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default netbsd-10-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-10-minimal-v10.1.20241216-amd64-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-10-minimal-v10.1.20241216`
to your box list by the following command:

    vagrant box add NetBSD-10-minimal-v10.1.20241216-amd64-vmware.box \
        --name NetBSD-10-minimal-v10.1.20241216-amd64 --provider vmware_desktop

VMware build is tested with amd64 and i386 guests on amd64 host, and
evbarm aarch64 guest on Apple Silicon Mac host.

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

    packer build -only=vmware-iso.esxi netbsd-10-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=esxi-iso -var esxi_vnc_over_websocket=false netbsd-10-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu netbsd-10-minimal.pkr.hcl

You will find a vagrant box file named `NetBSD-10-minimal-v10.1.20241216-amd64-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-10-minimal-v10.1.20241216`
to your box list by the following command:

    vagrant box add NetBSD-10-minimal-v10.1.20241216-amd64-libvirt.box \
        --name NetBSD-10-minimal-v10.1.20241216-amd64 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU/libvirt build is tested with only amd64 and i386 guests on amd64
host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso -var hyperv_ssh_host=192.168.1.2 \
        -var hyperv_host_cidr=192.168.1.2/24 \
        -var hyperv_gateway=192.168.1.1 netbsd-10-minimal.pkr.hcl

Because Packer Hyper-V builder cannot detect IP address of a NetBSD VM,
you must provide static network settings so that the VM is configured to
have a static IP address.

You will find a vagrant box file named `NetBSD-10-minimal-v10.1.20241216-amd64-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-10-minimal-v10.1.20241216`
to your box list by the following command:

    vagrant box add NetBSD-10-minimal-v10.1.20241216-amd64-hyperv.box \
        --name NetBSD-10-minimal-v10.1.20241216-amd64 --provider hyperv

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

* `netbsd-10-minimal.pkr.hcl` - NetBSD 10.0
* `netbsd-10-xorg.pkr.hcl` - NetBSD 10.0 + [X.Org][]
* `netbsd-10-dwm.pkr.hcl` - NetBSD 10.0 + X.Org + [dwm][] + [st][] +
  [dmenu][], with [XDM] enabled
* `netbsd-10-xfce.pkr.hcl` - NetBSD 10.0 + [Xfce][], with XDM
  enabled

While `netbsd-10-*.pkr.hcl` templates generate amd64 boxes by
default, using `vars-netbsd-10-aarch64.pkrvars.hcl` generates
aarch64 boxes:

    packer build -var-file=vars-netbsd-10-aarch64.pkrvars.hcl netbsd-10-minimal.pkr.hcl

and using `vars-netbsd-10-i386.pkrvars.hcl` generates i386
boxes:

    packer build -var-file vars-netbsd-10-i386.pkrvars.hcl netbsd-10-minimal.pkr.hcl

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

* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `esxi_disk_name`
* `esxi_remote_datastore` - ESXi datastore name where a VM image will
  be created.
* `esxi_remote_host` - ESXi host name or IP address.
* `esxi_remote_password` - ESXi login password.
* `esxi_remote_username` - ESXi login user name.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `hostname` - Host name of the created VM.  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Defaults to `false`.
* `hyperv_disk_name`
* `hyperv_gateway` - IP address of the gateway and the name server for
  the VM being built with Hyper-V builder.  You must provide an
  appropriate value.
* `hyperv_host_cidr` - CIDR notation of the VM IP address being built
  with Hyper-V builder.  You must provide an appropriate value.
* `hyperv_netif` - Network interface name of the VM being build with
  Hyper-V builder.  Default value is `hvn0`.
* `hyperv_ssh_host` - IP address of the VM being built with Hyper-V
  builder.  You must provide an appropriate value.
* `hyperv_switch_name` - Network switch name on Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `package_branch` - pkgsrc branch name for binary packages to install.
  Default value is `10.0_2023Q4`.
* `package_server` - Host name to download packages from.  Default value
  is `http://cdn.netbsd.org`.
* `partition_name` - Partition name of which NetBSD is install on.
* `qemu_accelerator` - Accelerator type to run the VM with.  Default
  value is `kvm`.
* `qemu_binary` - Name of QEMU binary to invoke. Default value is
  `qemu-system-x86_64` for amd64 boxes and `qemu-system-i386` for i386
  boxes.
* `qemu_disk_name`
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `ssh_password` - SSH password for `ssh_user` during build time.
  Default value is `vagrant`.
* `ssh_username` - User name to login via SSH during build time.
  Default value is `root`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `vagrant_username` - User name during run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `user_name`.  Default value is
  `vagrant`.
* `virtualbox_disk_name`
* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `vmware_cdrom_adapter_type` - CD-ROM adapter type for VMware box.
* `vmware_disk_adapter_type` - Disk adapter type for VMware.  Defaults
  to `scsi`.
* `vmware_disk_name`
* `vmware_hardware_version` - Hardware version for VMware.  Defaults to
  `9`.
* `vmware_network_adapter_type` - Network adapter type for VMware.
  Defaults to `e1000`.

- - -

Copyright &copy; 2024, 2025 Upperstream.
