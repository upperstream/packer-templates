# Packer templates for Alpine Linux 3.18.12

Templates to create Vagrant boxes for Alpine Linux 3.18.12. (x86_64,
x86, and aarch64)

## Prerequisites

* [Packer][] version 1.8.7+
* [Vagrant][] version 2.2.18+
* [Virtualbox][] version 7.0+
* [VMware][] Workstation version 17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) version 7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10
* [Parallels][] version 18.0+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/
  "libvirt: The virtualization API"
[Packer]: https://www.packer.io/
  "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/products/desktop/
  "Parallels Desktop18 for Mac"
[QEMU]: https://www.qemu.org/
  "QEMU"
[Vagrant]: https://www.vagrantup.com/
  "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public
  &amp; Hybrid Clouds"

## Provisioned software tools

* VirtualBox Guest Additions, [open-vm-tools][], or Hyper-V daemons
* sshd
* doas
* chronyd (NTP daemon)
* rsync
* NFS (installed but not enabled)
* `vagrant` user and its insecure public key

Note that `sudo` is not installed while `doas` is.

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

```
packer build -only=virtualbox-iso.default \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

You will find a vagrant box file named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-virtualbox.box` in
the same directory after the command has succeeded.

Then you can add the box named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64`
to your box list by the following command:

```
vagrant box add \
  Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-virtualbox.box \
  --name Alpine-standard-3.18-minimal-v18.12.20250213-x86_64 \
  --provider virtualbox
```

VirtualBox build intends to create x86_64 box and x86 box on x86_64
host.

### VMware

From the terminal, invoke the following command for VMware provider:

```
packer build -only=vmware-iso.default \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

You will find a vagrant box file named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-vmware.box` in the
same directory after the command has succeeded.

Then you can add the box named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64` to your box list
by the following command:

```
vagrant box add \
  Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-vmware.box \
  --name Alpine-standard-3.18-minimal-v18.12.20250213-x86_64 \
  --provider vmware
```

VMware build intends to create x86_64 box and x86 box on x86_64 host,
and aarch64 box on Apple Silicon Mac host.

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

```
packer build -only=vmware-iso.esxi \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

```
packer build -only=vmware-iso.esxi -var esxi_vnc_over_websocket=false \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

```
packer build -only=qemu.default \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

You will find a vagrant box file named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-libvirt.box` in the
same directory after the command has succeeded.

Then you can add the box named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64`
to your box list by the following command:

```
vagrant box add \
  Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-libvirt.box \
  --name Alpine-standard-3.18-minimal-v18.12.20250213-x86_64 \
  --provider libvirt
```

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create x86_64 box and x86 box on x86_64 Linux
host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

```
packer build -only=hyperv-iso.default \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

You will find a vagrant box file named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64`
to your box list by the following command:

```
vagrant box add \
  Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-hyperv.box \
  --name Alpine-standard-3.18-minimal-v18.12.20250213-x86_64 \
  --provider hyperv
```

Hyper-V build intends to create x86 box and x86_64 box on Windows 10
host.

### Parallels

From the terminal, invoke the following command for Parallels provider:

```
packer build -only=parallels-iso.default \
  -var-file=vars-alpine-standard-3.18-x86_64.pkrvars.hcl \
  alpine-3.18-minimal.pkr.hcl
```

You will find a vagrant box file named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-parallels.box` in
the same directory after the command has succeeded.

Then you can add the box named
`Alpine-standard-3.18-minimal-v18.12.20250213-x86_64`
to your box list by the following command:

```
vagrant box add \
  Alpine-standard-3.18-minimal-v18.12.20250213-x86_64-parallels.box \
  --name Alpine-standard-3.18-minimal-v18.12.20250213-x86_64 \
  --provider parallels
```

Parallels build intends to create aarch64 box on Apple Silicon Mac host.

## Default settings

These default settings are done by the file `Vagrantfile.Alpine3.15+`
which will be included in the box.  You can override this setting by
your own `Vagrantfile`.

### Synced Folder

Synced Folder of this box is disabled by default, although VirtualBox
Guest Additions is installed on the box.  You can enable this feature
using `config.vm.synced_folder` method in your `Vagrantfile`.

Because `doas` command is installed in this box instead of `sudo`, the
rsync path needs to be `doas rsync` for rsync type sync'ed folder.  You
can add `rsync__rsync_path: "doas rsync"` option to your sync'ed folder
settings when you choose rsync type sync'ed folder to implement this
requirement.

### SSH Shell

Because Bash is not the standard shell for Alpine Linux, default shell
for SSH connection of this box is set to `/bin/ash`.

### Substituting a user during SSH command execution

Because `doas` command is installed in this box instead of `sudo`,
command for SSH command execution in privileged mode is configured to
use `doas`.

## Variants

* `alpine-3.18-minimal.pkr.hcl` - Alpine Linux 3.18.12
* `alpine-3.18-docker.pkr.hcl` - Alpine Linux 3.18.12 with [Docker] and
  [Docker Compose]
* `alpine-3.18-dwm.pkr.hcl` - Alpine Linux 3.18.12 with [X.org][],
  [dwm][], [dmenu][], [st][], [SLiM][], and [xrdp][].
* `alpine-3.18-xfce.pkr.hcl` - Alpine Linux 3.18.12 with [Xfce][] and
  [xrdp][].

[dmenu]: http://tools.suckless.org/dmenu/
  "dmenu | suckless.org tools"
[Docker]: https://www.docker.com/
  "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/
  "Docker Compose - Docker Documentation"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/
  "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Supported CPUs

Templates support various CPUs.  The following list describes which
`vars-*.pkrvars.hcl` file is for which CPU:

* x86_64 - `vars-alpine-*-x86_64.pkrvars.hcl`
* x86 - `vars-alpine-*-x64.pkrvars.hcl`
* aarch64 - `vars-alpine-*-aarch64.pkrvars.hcl`

## Optimised kernel for virtual machines

Instead of `vars-alpine-standard-3.18-*.pkrvars.hcl` files you can use
`vars-alpine-virt-3.18-*.pkrvars.hcl`.  These files instruct to use ISO
images with kernels optimised for virtual machines.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `boot_wait` - Wait for booting virtual machine.  `1m` denotes 1
  minutes while `15s` denotes 15 seconds.  Defaults to 30 seconds.
* `disk_size` - Disk size of the created VM.  Defaults to `40960`
  which means 40GB.
* `esxi_disk_name` - Disk name for ESXi box.
* `esxi_keep_registered` - instructs whether build artefact should be
  kept in the inventory on ESXi.  Defaults to `false`.
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
* `hyperv_disk_name` - Disk name for Hyper-V box.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created VM.  Defaults to `512`
  which means 512MB.
* `num_cpus` - The number of CPUs.  Defaults to `2`.
* `parallels_disk_name` - Disk name for Parallels box.
* `qemu_disk_name` - Disk name for QEMU box.
* `qemu_display` - Value for `-display` option for QEMU.  Defaults to an
  empty string.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Defaults to `false`.
* `root_password` - Password for `root` user.  Defaults to `vagrant`.
* `ssh_timeout` - Timeout for SSH connection.  Defaults to `1800s`.
* `vagrant_password` - Password for `vagrant_username`.  Defaults to
  `vagrant`.  This is also used for SSH password during build time.
* `vagrant_ssh_public_key` - SSH public key for Vagrant user.  Defaults
  to the public key for the Vagrant insecure private key.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Defaults to `vagrant`.  This is also used for SSH
  user name during build time.
* `virtualbox_disk_name` - Disk name for VirtualBox box.
* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `vmware_cdrom_adapter_type` - CD-ROM adapter type for VMware box.
  Defaults to `ide`.
* `vmware_disk_name` - Disk name for VMware box.  Defaults to `scsi`.
* `vmware_fusion_app_path` - Path name to the VMware Fusion on Mac.
  Defaults to `/Applications/VMware Fusion.app`.
* `vmware_hardware_version` - Virtual hardware version of VMware box.
  Defaults to `9`.
* `vmware_network` - Network type of VMware box.  Defaults to `nat`.
* `vmware_network_adapter_type` - Network adapter type for VMware box.
  Defaults to `e1000`.
* `vmware_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for VMware box.  Defaults to `FALSE`.

- - -

Copyright &copy; 2023-2025 Upperstream Software.
