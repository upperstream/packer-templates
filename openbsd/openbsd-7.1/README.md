# Packer templates for OpenBSD 7.1

Templates to create Vagrant boxes for OpenBSD 7.1 (amd64 and i386).

## Prerequisites

* [Packer][] v1.7.0+
* [Vagrant][] v2.2.18+
* [VirtualBox][] version 6.1.32+
* [VMware][] Workstation version 16.2.1+ / VMware Fusion v10.0+
* [ESXi][] (vSphere Hypervisor) version 5.5+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10

[ESXi]:
  http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]:
  https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
  "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]:
  https://libvirt.org/ "libvirt: The virtualization API"
[Packer]:
  https://www.packer.io/ "Packer by HashiCorp"
[QEMU]:
  https://www.qemu.org/ "QEMU"
[Vagrant]:
  https://www.vagrantup.com/ "Vagrant"
[VirtualBox]:
  https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]:
  http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* rsync
* `vagrant` user and its insecure public key

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso openbsd-7.1-minimal.json

You will find a vagrant box file named `OpenBSD-7.1-amd64-minimal-v7.1.20220421-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-7.1-amd64-minimal-v7.1.20220421`
to your box list by the following command:

    vagrant box add OpenBSD-7.1-amd64-minimal-v7.1.20220421-virtualbox.box --name OpenBSD-7.1-amd64-minimal-v7.1.20220421 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso openbsd-7.1-minimal.json

You will find a vagrant box file named `OpenBSD-7.1-amd64-minimal-v7.1.20220421-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-7.1-amd64-minimal-v7.1.20220421`
to your box list by the following command:

    vagrant box add OpenBSD-7.1-amd64-minimal-v7.1.20220421-vmware.box --name OpenBSD-7.1-amd64-minimal-v7.1.20220421 --provider vmware_desktop

In the `output` directory you will also find a VM image that can be
directly imported to VMware.

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu openbsd-7.1-minimal.json

You will find a vagrant box file named `OpenBSD-7.1-amd64-minimal-v7.1.20220421-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-7.1-amd64-minimal-v7.1.20220421`
to your box list by the following command:

    vagrant box add OpenBSD-7.1-amd64-minimal-v7.1.20220421-libvirt.box --name OpenBSD-7.1-amd64-minimal-v7.1.20220421 -- provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso openbsd-7.1-minimal.json

You will find a vagrant box file named `OpenBSD-7.1-amd64-minimal-v7.1.20220421-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-7.1-amd64-minimal-v7.1.20220421`
to your box list by the following command:

    vagrant box add OpenBSD-7.1-amd64-minimal-v7.1.20220421-hyperv.box --name OpenBSD-7.1-amd64-minimal-v7.1.20220421 --provider hyperv

## Default settings

These default settings below are done by the file
`Vagrantfile.OpenBSD-sh` which will be included in the box.  Users can
override this setting by users' own `Vagrantfile`s.

### Synced Folder

Due to Vagrant limitation of OpenBSD support, Synced Folder of this box
is disabled by default.
You can still use other types of synced folders:

* NFS on non-Windows hosts
* RSync on any hosts.

### SSH Shell

Because Bash is not the standard shell for OpenBSD, default shell for
non-interactive SSH connection of this box is set to `/bin/sh`.

### sudo Command

Instead of `sudo`, boxes are configured to use `doas` command.

## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
  created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso openbsd-7.1-minimal.json

(Note that created VM will be unregistered from your Inventory.)

## Variants

`sudo` is enabled with all variants.

* `openbsd-7.1-minimal.json` - OpenBSD 7.1
* `openbsd-7.1-ansible.json` - OpenBSD 7.1 with [Ansible][] +
  [Ansible Lint][] + [Testinfra][]
* `openbsd-7.1-x11.json` - OpenBSD 7.1 with [X11][]
* `openbsd-7.1-dwm.json` - OpenBSD 7.1 with X11 + [dwm][] + [dmenu][] +
  [st][] + Xenodm
* `openbsd-7.1-xfce.json` - OpenBSD 7.1 with [Xfce][] + Xenodm

While `openbsd-7.1-*.json` templates generate amd64 boxes by default,
using `vars-openbsd-7.1-i386.json` generates i386 boxes:

    packer build -var-file=vars-openbsd-7.1-i386.json openbsd-7.1-minimal.json

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Ansible Lint]: https://docs.ansible.com/ansible-lint/
  "Ansible Lint Documentation &mdash; Ansible Documentation"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
  "Testinfra test your infrastructure &#8212; testinfra 3.2.1.dev2+g672a064.d20191006 documentation"
[X11]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var` or
`-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `package_server`: - URL to download packages from.  Default value is
  `http://cloudflare.cdn.openbsd.org/pub/OpenBSD/`.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `hyperv_switch_name` - Network switch name for Hyper-V provider.
  Default value is `Default Switch`.

- - -

Copyright &copy; 2022 Upperstream Software.
