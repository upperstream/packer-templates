# Packer templates for FreeBSD 14.5-RELEASE

Templates to create Vagrant boxes for FreeBSD 14.5-RELEASE on ZFS root
file system.  (amd64, i386, and aarch64)

Packages are installed from the FreeBSD `release_5` repository, with
kernel modules from `kmods_quarterly_5`.

The architecture-specific variable files select matching package pins.
Graphical VMware guests use the `vmware` video driver on amd64, `vesa`
on i386, and `scfb` with `libinput` on aarch64.  VirtualBox additions
are provided for amd64 and i386 only.

## Prerequisites

* [Packer][] v1.10+
* [Vagrant][] v2.4+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) v7.0+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10
* [Parallels][] Desktop 19+
* [UTM][] v4.0+ (macOS only)

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]:
  https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/ "libvirt: The virtualization API"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Parallels]: https://www.parallels.com/products/desktop
  "Parallels Desktop18 for Mac"
[QEMU]: https://www.qemu.org/ "QEMU"
[UTM]: https://mac.getutm.app/
  "UTM - Universal Virtual Machine Host for macOS"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop & Server, Application,
  Public & Hybrid Cloud"

## Provisioned software tools

* VirtualBox Guest Additions, [open-vm-tools][], or Hyper-V daemons
* QEMU guest agent for QEMU and UTM builds
* sshd
* doas
* `vagrant` user and its insecure public key
* ntpd enabled

[open-vm-tools]: https://github.com/vmware/open-vm-tools
  "Official repository of VMware open-vm-tools project"

Note that `sudo` is not installed while `doas` is.

All variants use the shared `../provisioners/vmware-guest.sh` script
for VMware and ESXi builds.  For graphical guests, the script derives
X.Org driver names from the `xf86_video_vmware` and
`xf86_input_vmmouse` package selections.

## How to create a box

Run commands from this directory.  Initialise the plugins for the
chosen template before building it, for example:

    packer init freebsd-14.5-minimal.pkr.hcl

The VMware plugin is constrained to versions below 2.0.0 because these
templates retain the legacy ESXi builder configuration.

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default freebsd-14.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-virtualbox.box` in
the same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-virtualbox` to your
box list by the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64
    vagrant box add "$box-virtualbox.box" \
      --name "$box" --provider virtualbox

VirtualBox build intends to create amd64 box and i386 box on amd64 host.

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default freebsd-14.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-vmware.box` in the
same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-vmware` to your box
list by the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64
    vagrant box add "$box-vmware.box" \
      --name "$box" --provider vmware_desktop

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

    packer build -only=vmware-iso.esxi freebsd-14.5-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=vmware-iso.esxi \
      -var esxi_vnc_over_websocket=false freebsd-14.5-minimal.pkr.hcl

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default freebsd-14.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-libvirt.box` in the
same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-libvirt` to your box
list by the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64
    vagrant box add "$box-libvirt.box" \
      --name "$box" --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box and i386 box on amd64 Linux
host.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso.default freebsd-14.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-hyperv.box` in
the same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64-hyperv` to your box list by
the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-amd64
    vagrant box add "$box-hyperv.box" \
      --name "$box" --provider hyperv

Hyper-V build intends to create amd64 box and i386 box on Windows
host.

### Parallels

From the terminal, invoke the following command for Parallels provider:

    packer build -only=parallels-iso.default \
      -var-file=vars-freebsd-14.5-aarch64.pkrvars.hcl \
      freebsd-14.5-minimal.pkr.hcl

You will find a vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-aarch64-parallels.box` in
the same directory after the command has succeeded.

Then you can add the box named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-aarch64-parallels` to your
box list by the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-aarch64
    vagrant box add "$box-parallels.box" \
      --name "$box" --provider parallels

Parallels build intends to create aarch64 box on Apple Silicon Mac
host.

### UTM

From the terminal, invoke the following command for the UTM provider
on an Apple Silicon Mac:

    packer build -only=utm-iso.default \
      -var-file=vars-freebsd-14.5-aarch64.pkrvars.hcl \
      freebsd-14.5-minimal.pkr.hcl

You will find a Vagrant box file named
`FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-aarch64-utm.box` in the
same directory after the command has succeeded.

Then you can add the box to your box list with the following command:

    box=FreeBSD-14.5-RELEASE-minimal-v14.5.20260908-aarch64
    vagrant box add "$box-utm.box" --name "$box" --provider utm

UTM builds use the QEMU backend with hardware virtualisation and UEFI
boot.  The example creates an aarch64 box on an Apple Silicon Mac.
The dwm and Xfce variants also support UTM; substitute
`freebsd-14.5-dwm.pkr.hcl` or `freebsd-14.5-xfce.pkr.hcl` for the
minimal template in the build command.

The VM is unregistered from UTM after the build by default.  Set
`-var utm_keep_registered=true` to keep it registered.

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

* `freebsd-14.5-minimal.pkr.hcl` - FreeBSD 14.5-RELEASE
* `freebsd-14.5-dwm.pkr.hcl` - FreeBSD 14.5-RELEASE + [X.Org][] +
  [dwm][] + [dmenu][] + [st][]
* `freebsd-14.5-xfce.pkr.hcl` - FreeBSD 14.5-RELEASE + [Xfce][] +
  [SLiM][]

While `freebsd-14.5-*.pkr.hcl` templates generate amd64 boxes by
default, using `vars-freebsd-14.5-aarch64.pkrvars.hcl` generates
aarch64 boxes:

    packer build -var-file=vars-freebsd-14.5-aarch64.pkrvars.hcl freebsd-14.5-minimal.pkr.hcl

and using `vars-freebsd-14.5-i386.pkrvars.hcl` generates i386
boxes:

    packer build -var-file=vars-freebsd-14.5-i386.pkrvars.hcl freebsd-14.5-minimal.pkr.hcl

[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/
  "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "st | suckless.org st - simple terminal"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `ABI` - Package ABI.  Defaults to `FreeBSD:14:amd64`.
* `DISTRIBUTIONS` - Distribution sets to install.  Defaults to
  `base.txz kernel.txz lib32.txz` on amd64, or `base.txz kernel.txz`
  with the architecture-specific variable files.
* `arch` - Architecture name.  Defaults to `amd64`.
* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
* `box_version` - Vagrant box version.  Defaults to `14.5.20260908`.
* `disk_size` - Disk size of the creating VM.  Defaults to `51200`
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
* `iso_checksum` - SHA256 checksum or checksum file URL for the media.
* `iso_name` - Installation media filename.  Defaults to
  `FreeBSD-14.5-RELEASE-amd64-disc1.iso`.
* `iso_path` - Installation media path on the mirrors.  Defaults to
  `releases/ISO-IMAGES/14.5`.
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
  `true`.  Defaults to `true`.
* `root_password` - Password for `root` user.  Defaults to `vagrant`.
* `ssh_timeout` - SSH timeout to connect this box being created.
  Defaults to `60m`.
* `utm_keep_registered` - Keep the VM registered with UTM after build
  completion.  Defaults to `false`.
* `utm_netif` - Network interface for UTM box.  Defaults to `vtnet1`.
* `utm_partition` - Disk name for UTM box.  Defaults to `vtbd0`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Defaults to `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Defaults to
  `vagrant`.  This is also used for SSH password during build time.
* `vagrant_username` - User name used for runtime.  Vagrant box is set
  for this user.  Defaults to `vagrant`.
  This is also used for SSH user name during build time.
* `variant` - Variant name used in VM and box names.  Defaults to
  `minimal`, `dwm`, or `xfce`, according to the template.
* `virtualbox_guest_os_type` - VirtualBox guest OS type.  Defaults to
  `FreeBSD_64`.
* `virtualbox_ose_additions_version` - VirtualBox additions version.
  Defaults to `7.2.16.1404000`, or `7.2.14.1404000` on i386.
* `virtualbox_netif` - Network interface for VirtualBox box.  Defaults
  to `em0`.
* `virtualbox_partition` - Disk name for VirtualBox box.  Defaults to
  `ada0`.
* `vm_name` - VM name.  This also affects box file name and output
  directory name.  Defaults to `FreeBSD-14.5-RELEASE`.
* `vmware_disk_adapter_type` - Disk adapter type for VMware.  Defaults
  to `scsi`.
* `vmware_guest_os_type` - VMware guest OS type.  Defaults to
  `freebsd-64`.
* `vmware_hardware_version` - Hardware version for VMware.  Defaults to
  `13`.
* `vmware_netif` - Network interface name for VMware box.  Defaults to
  `em0`.
* `vmware_network_adapter_type` - Network adapter type for VMware.
  Defaults to `e1000`.
* `vmware_partition` - Disk name for VMware box.  Defaults to `da0`.
* `xf86_input_vmmouse` - Input driver package for graphical VMware
  guests.  Defaults to `xf86-input-vmmouse-13.1.0_7`, or
  `xf86-input-libinput-1.5.0` on aarch64.
* `xf86_video_vmware` - Video driver package for graphical VMware
  guests.  Defaults to `xf86-video-vmware-13.4.0`,
  `xf86-video-vesa-2.6.0` on i386, or `xf86-video-scfb-0.0.7_2` on
  aarch64.  The VMware graphics parameters are accepted but unused by
  the minimal variant, so the same variable files work for all variants.

Package pins can also be overridden with `ca_root_nss_version`,
`doas_version`, and `open_vm_tools_version`.  The graphical variants
also expose `arandr_version` and `xrdp_version`; the dwm variant adds
`ncurses_version` and `xorg_fonts`, and the Xfce variant adds
`slim_version` and `xterm_version`.  The `doas_version` and
`xorg_fonts` values include the package name; the other values contain
only the version.

- - -

Copyright &copy; 2026 Upperstream.
