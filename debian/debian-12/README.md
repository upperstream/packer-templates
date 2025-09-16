# Packer templates for Debian 12.12

Templates to create Vagrant boxes for Debian 12.12 (amd64, arm64, and i386).

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
[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
    "Introduction to Hyper-V on Windows 10"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/ "Run Windows on Mac - Parallels Desktop"
[QEMU]: https://www.qemu.org/ "QEMU"
[Vagrant]: https://developer.hashicorp.com/vagrant
    "Vagrant | HashiCorp Developer"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/ "VMware Virtualization for Desktop & Server, Application, Public & Hybrid Clouds"

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

    packer build -only=virtualbox-iso.default debian-12-minimal.pkr.hcl

You will find a vagrant box file named
`Debian-12-amd64-minimal-v12.12.20250906-virtualbox.box` in the
same directory after the command has succeeded.

Then you can add the box named `Debian-12-amd64-minimal-v12.12.20250906`
to your box list by the following command:

    vagrant box add Debian-12-amd64-minimal-v12.12.20250906-virtualbox.box \
      --name Debian-12-amd64-minimal-v12.12.20250906 --provider virtualbox

VirtualBox build intends to create amd64 box and i386 box on amd64 host.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default debian-12-minimal.pkr.hcl

You will find a vagrant box file named
`Debian-12-amd64-minimal-v12.12.20250906-vmware.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-12-amd64-minimal-v12.12.20250906`
to your box list by the following command:

    vagrant box add Debian-12-amd64-minimal-v12.12.20250906-vmware.box \
      --name Debian-12-amd64-minimal-v12.12.20250906 --provider vmware_desktop

VMware build intends to create amd64 box or i386 box on amd64 host
using VMware Workstation, or create arm64 box on Apple Silicon Mac
host using VMware Fusion.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `ESXI_REMOTE_HOST` - ESXi host name or IP address
* `ESXI_REMOTE_USERNAME` - ESXi login user name
* `ESXI_REMOTE_PASSWORD` - ESXi login password
* `ESXI_REMOTE_DATASTORE` - ESXi datastore name where a VM image will
  be created

The following command will build a VM image on your ESXi:

    packer build -only=vmware-iso.esxi debian-12-minimal.pkr.hcl

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi -var esxi-vnc-over-websocket=false debian-12-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default debian-12-minimal.pkr.hcl

You will find a vagrant box file named
`Debian-12-amd64-minimal-v12.12.20250906-libvirt.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-12-amd64-minimal-v12.12.20250906`
to your box list by the following command:

    vagrant box add Debian-12-amd64-minimal-v12.12.20250906-libvirt.box \
      --name Debian-12-amd64-minimal-v12.12.20250906 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box and i386 box on amd64 Linux
host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default debian-12-minimal.pkr.hcl

You will find a vagrant box file named
`Debian-12-amd64-minimal-v12.12.20250906-hyperv.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-12-amd64-minimal-v12.12.20250906`
to your box list by the following command:

    vagrant box add Debian-12-amd64-minimal-v12.12.20250906-hyperv.box \
      --name Debian-12-amd64-minimal-v12.12.20250906 --provider hyperv

Hyper-V build intends to create amd64 box and i386 box on Windows
host.

### Parallels

From the terminal, invoke the following command for Parallels provider:

    packer build -only=parallels-iso.default debian-12-minimal.pkr.hcl

You will find a vagrant box file named
`Debian-12-arm64-minimal-v12.12.20250906-parallels.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-12-arm64-minimal-v12.12.20250906`
to your box list by the following command:

    vagrant box add Debian-12-arm64-minimal-v12.12.20250906-parallels.box \
      --name Debian-12-arm64-minimal-v12.12.20250906 --provider parallels

Parallels build intends to create arm64 box on Apple Silicon Mac host.

## Variants

* `debian-12-minimal.pkr.hcl` - Debian 12.12 minimal installation
* `debian-12-docker.pkr.hcl` - Debian 12.12 with [Docker][] +
  [Docker Compose][]
* `debian-12-dwm.pkr.hcl` - Debian 12.12 with [X.org][], [suckless][]
  tools, [ARandR][], and [xrdp][].
* `debian-12-desktop.pkr.hcl` - Debian 12.12 with [xrdp][] + various
  desktop environment such as:
  * `xfce` - [Xfce][] (default)
  * `cinnamon` - [Cinnamon][]
  * `gnome` - [GNOME][]
  * `gnome-flashback` - [GNOME Flashback][]
  * `kde` - [KDE Plasma][]
  * `lxde` - [LXDE][]
  * `lxqt` - [LXQt][]
  * `mate` - [MATE][]

  Adding `-var 'desktop=xfce'` to the command line can specify the
  desktop environment.

[ARandR]: https://christian.amsuess.com/tools/arandr/
    "ARandR: Another XRandR GUI"
[Cinnamon]: https://projects.linuxmint.com/cinnamon/
    "Linux Mint Projects by linuxmint"
[Docker]: https://www.docker.com/
    "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose"
[GNOME]: https://www.gnome.org/ "GNOME"
[GNOME Flashback]: https://wiki.gnome.org/Projects/GnomeFlashback
    "Gnome Flashback"
[KDE Plasma]: https://kde.org/plasma-desktop/ "KDE Plasma Desktop"
[LXDE]: https://lxde.org/ "LXDE"
[LXQt]: https://lxqt-project.org/ "LXQt"
[MATE]: https://mate-desktop.org/ "MATE Desktop Environment"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[Xfce]: https://xfce.org/ "Xfce Desktop Environment"
[X.org]: https://www.x.org/wiki/ "X.Org"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Installer CD images

Optional var files are provided to instruct to use alternative
installer CD images, i.e., `vars-debian-12-amd64-dvd.pkrvars.hcl` instructs to
use `debian-12.12.0-amd64-DVD-1.iso` while
`vars-debian-12-amd64-netinst.pkrvars.hcl` does
`debian-12.12.0-amd64-netinst.iso` respectively.  Without using these
var files, `debian-12-*.pkr.hcl` templates use netboot `mini.iso` for
amd64.

Depending on situation you can specify either of var files on the
command line:

    packer build -var-file=vars-debian-12-amd64-full.pkrvars.hcl debian-12-minimal.pkr.hcl

* amd64 ISO images
  * `vars-debian-12-amd64-dvd.pkrvars.hcl` - `debian-12.12.0-amd64-DVD-1.iso`
  * `vars-debian-12-amd64-netinst.pkrvars.hcl` - `debian-12.12.0-amd64-netinst.iso`
* arm64 ISO images
  * `vars-debian-12-arm64-dvd.pkrvars.hcl` - `debian-12.12.0-arm64-DVD-1.iso`
  * `vars-debian-12-arm64-netinst.pkrvars.hcl` - `debian-12.12.0-arm64-netinst.iso`
  * `vars-debian-12-arm64-mini.pkrvars.hcl` - netboot CD `mini.iso`
* i386 ISO images
  * `vars-debian-12-i386-dvd.pkrvars.hcl` - `debian-12.12.0-i386-DVD-1.iso`
  * `vars-debian-12-i386-netinst.pkrvars.hcl` - `debian-12.12.0-i386-netinst.iso`
  * `vars-debian-12-i386-mini.pkrvars.hcl` - netboot CD `mini.iso`

It is recommended to use "jigdo" to download large iso image file and
put it in `./iso` directory.  Templates instruct `packer` to use the
image file rather than downloading an image from a mirror site.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `desktop` - Specify the desktop environment to install.  Defaults to
  `xfce`.  (Only valid for `debian-11-desktop.pkr.hcl` variant)
* `disk_size` - Disk size of the created box.  Defaults to `51200`,
  which means 50GB.
* `esxi_boot_mode` - Boot mode for ESXi VM, `bios` or `efi`.  Defaults
  to `bios`.
* `esxi_vhv_enabled` - Instruct whether nested virtualisation is
  enabled for ESXi box.  Defaults to `TRUE`.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Defaults to `false`.
* `hyperv_boot_mode` - Boot mode for Hyper-V VM, `bios` or `efi`.
  Defaults to `bios`.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.
* `mem_size` - RAM size of the created box.  Defaults to `1024`, `1536`
  for `dwm` variant, and `2048` for `xfce` variant.
* `num_cpus` - The number of CPUs of the box.  Defaults to `2`.
* `parallels_boot_mode` - Boot mode for Parallels VM, `bios` or `efi`.
  Defaults to `efi`.
* `qemu_accelerator` - QEMU accelerator name for QEMU VM.  Defaults to
  `kvm`.
* `qemu_boot_mode` - Boot mode for QEMU VM, `bios` or `efi`.  Defaults
  to `bios`.
* `qemu_display` - What QEMU `-display` option to use.  Defaults to an
  empty string.
* `qemu_use_default_display` - Determines to pass a `-display` option
  to QEMU or not.  Defaults to `false`.
* `root_password` - Password for `root` user.  Defaults to `vagrant`.
  Set `sensitive` attribute to `true` when you change this password.
* `ssh_timeout` - SSH timeout to connect this box being created.
  Defaults to `60m`.
* `vagrant_password` - Password for `vagrant_username`.  Defaults to
  `vagrant`.  Set `sensitive` attribute to `true` when you change this
  password.
* `vagrant_ssh_public_key` - SSH public key for Vagrant user.  Defaults
  to the public key for the Vagrant insecure private key.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `virtualbox_boot_mode` - Boot mode for VirtualBox VM, `bios` or
  `efi`.  Defaults to `bios`.
* `virtualbox_version` - VirtualBox Guest Additions version number.
  Defaults to `7.0.6`.
* `vmware_boot_mode` - Boot mode for VMware VM, `bios` or `efi`.
  Defaults to `bios`.
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
* `vm_name` - VM name of the box being created.  If this value is not
  given, VM name will be determined based on Debian release version, CPU
  name, and variant name.

- - -

Copyright &copy; 2023, 2025, Upperstream.
