# Packer templates for FreeBSD 13.1-RELEASE

Templates to create Vagrant boxes for FreeBSD 13.1-RELEASE

## Prerequisites

* [Packer][] version 1.7.0+
* [Vagrant][] version 2.2.18+
* [VirtualBox][] version 6.1.32+
* [VMware][] Workstation version 16.2.1+ / VMware Fusion v10.0+
* [ESXi][] (vSphere Hypervisor) version 5.5+
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
    "VMware Virtualization for Desktop &amp; Server, Application,
    Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* sudo
* `vagrant` user and its insecure public key
* ntpd enabled

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso freebsd-13.1-minimal.json

You will find a vagrant box file named `FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512`
to your box list by the following command:

    vagrant box add FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512-virtualbox.box --name FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso freebsd-13.1-minimal.json

You will find a vagrant box file named `FreeBSD-13.1-RELEASE-amd64-v13.1.20220512-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512`
to your box list by the following command:

    vagrant box add FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512-vmware.box --name FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512 --provider vmware_desktop

In the `output` directory you will also find a VM image that can be
directly imported from VMware.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
   created

You also have to enable SSH on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso freebsd-13.1-minimal.json

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=esxi-iso --var esxi_vnc_over_websocket=false freebsd-13.1-minimal.json

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu freebsd-13.1-minimal.json

You will find a vagrant box file named `FreeBSD-13.1-RELEASE-amd64-v13.1.20220512-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512`
to your box list by the following command:

    vagrant box add FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512-libvirt.box --name FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso freebsd-13.1-minimal.json

You will find a vagrant box file named `FreeBSD-13.1-RELEASE-amd64-v13.1.20220512-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512`
to your box list by the following command:

    vagrant box add FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512-hyperv.box --name FreeBSD-13.1-RELEASE-amd64-minimal-v13.1.20220512 --provider hyperv

## Default settings

These default settings are done by the file `Vagrantfile.FreeBSD-11+`
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

### SSH Shell

Because Bash is not the standard shell for FreeBSD, default shell for
SSH connection of this box is set to `/bin/sh`.

## Variants

* `freebsd-13.1-minimal.json` - FreeBSD 13.1-RC
* `freebsd-13.1-ansible.json` - FreeBSD 13.1-RC +
  [Ansible][] + [Ansible Lint] + [Testinfra][]
* `freebsd-13.1-dwm.json` - FreeBSD 13.1-RC + [X.Org][] +
  [dwm][] + [dmenu][] + [st][]
* `freebsd-13.1-xfce.json` - FreeBSD 13.1-RC + [Xfce][] +
  [SLiM][]
* `freebsd-13.1-zfs.json` - FreeBSD 13.1-RC on ZFS root
  file system

While `freebsd-13.1-*.json` templates generate amd64 boxes by
default, using `vars-freebsd-13.1-i386.json` generates i386 boxes:

    packer build -var-file=vars-freebsd-13.1-i386.json freebsd-13.1-minimal.json

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Ansible Lint]: https://docs.ansible.com/ansible-lint/
  "Ansible Lint Documentation &mdash; Ansible Documentation"
[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/
  "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
  "Testinfra test your infrastructure &#8212; testinfra 6.6.1.dev6+g13cc9d8.d20220412 documentation"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is `2`.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 1GB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 50GB.
* `root_password` - Password for `root` user.  Default value is
  `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
  This is also used for SSH user name during build time.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.  This is also used for SSH password during build time.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.
* `esxi_vnc_over_websocket` - Controlls whether or not to use VNC over
  WebSocket feature for ESXi.  Default value is `true`.  Set to `false`
  if your ESXi host version is prior to 6.7 which supports VNC server.

- - -

Copyright &copy; 2022 Upperstream Software.
