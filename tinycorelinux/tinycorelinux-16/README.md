# Packer templates for Tiny Core Linux v16.2

Templates to create Vagrant boxes for Tiny Core Linux v16.2. (x86_64 and
x86)

## Prerequisites

* [Packer][] v1.8.5+
* [Vagrant][] v2.3.7+
* [VirtualBox][] v7.0+
* [VMware][] Workstation v17.0+ / VMware Fusion v13.0+
* [ESXi][] (vSphere Hypervisor) v7.0 U2+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
    "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
    "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* sudo
* NFS (installed but not enabled)
* `tc` user as a Vagrant user and its insecure public key

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso.default \
        -var-file=vars-corepure64-16.pkrvars.hcl tc-16-minimal.pkr.hcl

You will find a vagrant box file named `CorePure64-16-minimal-v16.2.20250929-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `CorePure64-16-minimal-v16.2.20250929`
to your box list by the following command:

    vagrant box add CorePure64-16-minimal-v16.2.20250929-virtualbox.box \
        --name CorePure64-16-minimal-v16.2.20250929

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso.default \
        -var-file=vars-corepure64-16.pkrvars.hcl tc-16-minimal.pkr.hcl

You will find a vagrant box file named `CorePure64-16-minimal-v16.2.20250929-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `CorePure64-16-minimal-v16.2.20250929`
to your box list by the following command:

    vagrant box add CorePure64-16-minimal-v16.2.20250929-vmware.box \
        --name CorePure64-16-minimal-v16.2.20250929

In the `output` directory you will also find a VM image that can be
directly imported from VMware.

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

    packer build -only=vmware_iso.esxi \
        -var-file=vars-corepure64-16.pkrvars.hcl tc-16-minimal.pkr.hcl

(Note that created VM will be unregistered from your Inventory.)

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu.default -var-file=vars-corepure64-16.pkrvars.hcl \
        tc-16-minimal.pkr.hcl

You will find a vagrant box file named
`CorePure64-16-minimal-v16.2.20250929-libvirt.box` in the
same directory after the command has succeeded.

Then you can add the box named
`CorePure64-16-minimal-v16.2.20250929` to your box list by
the following command:

    vagrant box add CorePure64-16-minimal-v16.2.20250929-libvirt.box \
        --name CorePure64-16-minimal-v16.2.20250929

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

QEMU build intends to create amd64 box and i386 box on amd64 Linux
host.

## Default settings

These default settings are done by the file `Vagrantfile.tc16` which will
be included in the box.  Users can override this setting by users' own
`Vagrantfile`s.

### Synced Folder

Due to limitation of VirtualBox's support for Tiny Core Linux support,
Synced Folder of this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for Tiny Core Linux, default
shell for SSH connection of this box is set to `/bin/ash`.

### SSH User

Since `tc` is the default user of Tiny Core Linux, this box is
configured that `tc` is a Vagrant user by default.

## Variants

* x86_64
  * `packer build -var-file=vars-corepure64-16.pkrvars.hcl tc-16-minimal.pkr.hcl`:
    CorePure 64 v16.2 (x86_64)
  * `packer build -var-file=vars-corepure64-16.pkrvars.hcl tc-16-compiletc.pkr.hcl`:
    CorePure 64 v16.2 (x86_64) with build tools
  * `packer build -var-file=vars-corepure64-16.pkrvars.hcl tc-16-kernel.pkr.hcl`:
    CorePure 64 v16.2 (x86_64) with kernel source code
  * `packer build -var-file=vars-tinycorepure64-16.pkrvars.hcl tc-16-x11.pkr.hcl`:
    TinyCorePure 64 v16.2 (x86_64)
  * `packer build -var-file=vars-tinycorepure64-16.pkrvars.hcl tc-16-compiletc+x11.pkr.hcl`:
    TinyCorePure 64 v16.2 (x86_64) with build tools
* x86
  * `packer build -var-file=vars-core-16.pkrvars.hcl tc-16-minimal.json`:
    Core v16.2 (x86)
  * `packer build -var-file=vars-core-16.pkrvars.hcl tc-16-compiletc.pkr.hcl`:
    Core v16.2 (x86) with build tools
  * `packer build -var-file=vars-core-16.pkrvars.hcl tc-16-kernel.pkr.hcl`:
    Core v16.2 (x86) with kernel source code
  * `packer build -var-file=vars-tinycore-16.pkrvars.hcl tc-16-x11.pkr.hcl`:
    TinyCore v16.2 (x86)
  * `packer build -var-file=vars-tinycore-16.pkrvars.hcl tc-16-compiletc+x11.pkr.hcl`:
    TinyCore v16.2 (x86) with build tools

Executing `build_all.sh` (or `build_all.bat`) generates all boxes above.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `boot_wait` - Override `boot_wait` default setting, which is `10s`.
  directory name.
* `cpu` - CPU name.  This is used as a part of box name.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `esxi_hardware_version` - Virtual hardware version of ESXi box.
  Defaults to `19`.
* `esxi_remote_datastore` - ESXi datastore name where a VM image will
  be created.
* `esxi_remote_host` - ESXi host name or IP address.
* `esxi_remote_password` - ESXi login password.
* `esxi_remote_username` - ESXi login user name.
* `esxi_vhv_enabled` - Enable nested virtualisation.
* `esxi_vnc_over_websocket` - Controls whether or not to use VNC over
  WebSocket feature for ESXi.  Defaults to `true`.  Set to `false` if
  your ESXi host version is prior to 6.7 which supports VNC server.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `num_cpus` - Number of virtual CPUs.  Default value is `2`.
* `ssh_password` - SSH password to connect this box being created.
* `qemu_binary` - QEMU binary name.  Defaults to `qemu-system-x86_64`.
* `qemu_display` - Value for `-display` option for QEMU.  Defaults to
  an empty string.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Defaults to `false`.
* `ssh_timeout` - SSH timeout to connect this box being created.
* `ssh_username` - SSH username to connect this box being created.
* `vm_name` - Overriding VM name.
* `vmware_disk_adapter_type` - Disk adapter type for VMware and ESXi.
  Defaults to `sata`.
* `vmware_hardware_version` - Hardware version for VMware.  Defaults to
  `19`.
* `vmware_vhv_enabled` - Enable nested virtualisation.

- - -

Copyright &copy; 2025, 2026 Upperstream.
