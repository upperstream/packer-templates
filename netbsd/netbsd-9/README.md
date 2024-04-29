# Packer templates for NetBSD 9.1

Templates to create Vagrant boxes for NetBSD 9.1 (amd64 and i386).

## Prerequisites

* [Packer][] v1.6.2+
* [Vagrant][] v2.2.6+
* [VirtualBox][] v6.1.10+; see the note 1 for compatibility issue
* [VMware][] Workstation v15.5+ / VMware Fusion v10.0+
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

### Notes for compatibility issues

1. Add `["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]`
   to the `vboxmanege` array in the JSON config file if you use
   VirtualBox v7.0 or later.
2. Depending on when you create a box, you may need to update the
   PKG_PATH do download packages from the NetBSD CDN and each package
   version because the designated pkgsrc branch in the JSON config file
   may be obsolete.

## Provisioned software tools

* sshd
* sudo
* rsync
* ntpd
* `vagrant` user and its insecure public key

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso netbsd-9-amd64-minimal.json

You will find a vagrant box file named `NetBSD-9.1-amd64-minimal-v9.1.20201018-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.1-amd64-minimal-v9.1.20201018`
to your box list by the following command:

    vagrant box add NetBSD-9.1-amd64-minimal-v9.1.20201018-virtualbox.box \
        --name NetBSD-9.1-amd64-minimal-v9.1.20201018 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso netbsd-9-and64-minimal.json

You will find a vagrant box file named `NetBSD-9.1-amd64-minimal-v9.1.20201018-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.1-amd64-minimal-v9.1.20201018`
to your box list by the following command:

    vagrant box add NetBSD-9.1-amd64-minimal-v9.1.20201018-vmware.box \
        --name NetBSD-9.1-amd64-minimal-v9.1.20201018 --provider vmware_desktop

In the `output` directory you will also find a VM image that can be
directly imported from VMware.

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu netbsd-9-and64-minimal.json

You will find a vagrant box file named `NetBSD-9.1-amd64-minimal-v9.1.20201018-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.1-amd64-minimal-v9.1.20201018`
to your box list by the following command:

    vagrant box add NetBSD-9.1-amd64-minimal-v9.1.20201018-libvirt.box \
        --name NetBSD-9.1-amd64-minimal-v9.1.20201018 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso -var hyperv_ssh_host=xxx.xxx.xxx.xxx \
        -var hyperv_host_cidr=xxx.xxx.xxx.xxx/x \
        -var hyperv_gateway=xxx.xxx.xxx.xxx netbsd-9-and64-minimal.json

Because Packer Hyper-V builder cannot detect IP address of a NetBSD VM,
you must provide static network settings so that the VM is configured to
have a static IP address.

You will find a vagrant box file named `NetBSD-9.1-amd64-minimal-v9.1.20201018-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.1-amd64-minimal-v9.1.20201018`
to your box list by the following command:

    vagrant box add NetBSD-9.1-amd64-minimal-v9.1.20201018-hyperv.box \
        --name NetBSD-9.1-amd64-minimal-v9.1.20201018 --provider hyperv

## Default settings

These default settings are done by the file `Vagrantfile.NetBSD-sh`
which will be included in the box.  Users can override this setting by
users' own `Vagrantfile`s.

### Synced Folder

Due to limitation of Vagrant's support for NetBSD, Synced Folder of
this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for NetBSD, default shell for
SSH connection of this box is set to `/bin/sh`.

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

    packer build -only=esxi-iso netbsd-9-amd64-minimal.json

(Note that created VM will be unregistered from your Inventory.)

## Variants

* `netbsd-9-*-minmal.json` - NetBSD 9.1
* `netbsd-9-*-ansible.json` - NetBSD 9.1 + [Ansible][] +
  [Ansible Lint][] + [Testinfra][]
* `netbsd-9-*-xorg.json` - NetBSD 9.1 + [X.Org][]
* `netbsd-9-*-dwm.json` - NetBSD 9.1 + X.Org + [dwm][] + [st][] +
  [dmenu][], with [XDM] enabled
* `netbsd-9-*-xfce.json` - NetBSD 9.1 + [Xfce][], with XDM enabled
  (amd64 only)

While `netbsd-9-amd64-*.json` templates generate amd64 boxes,
`netbsd-9-i386-*.json` templates generate i386 boxes:

    packer build netbsd-9-i386-minimal.json

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Ansible Lint]: https://docs.ansible.com/ansible-lint/
  "Ansible Lint Documentation &mdash; Ansible Documentation"
[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
  "Testinfra test your infrastructure &#8212; testinfra 5.0.1.dev2+gd9d87d8.d20200427 documentation"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[XDM]: https://www.x.org/releases/X11R7.6/doc/man/man1/xdm.1.xhtml "XDM"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `hostname` - Host name of the created VM.  Default value is `vagrant`.
* `ssh_username` - User name to login via SSH during build time.
  Default value is `root`.
* `ssh_password` - SSH password for `ssh_user` during build time.
  Default value is `vagrant`.
* `vagrant_username` - User name during run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `user_name`.  Default value is
  `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `package_server` - Host name to download pakages from.  Default value
  is `http://cdn.netbsd.org`.
* `qemu_binary` - Name of QEMU binary to invoke. Default value is
  `qemu-system-x86_64` for amd64 boxes and `qemu-system-i386` for i386
  boxes.
* `qemu_accelerator` - Accelerator type to run the VM with.  Default
  value is `kvm`.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `hyperv_switch_name` - Network switch name on Hyper-V builder.
  Default value is `Default Switch`.
* `hyperv_ssh_host` - IP address of the VM being built with Hyper-V
  builder.  You must provide an appropriate value.
* `hyperv_host_cidr` - CIDR notation of the VM IP address being built
  with Hyper-V builder.  You must provide an appropriate value.
* `hyperv_gateway` - IP address of the gateway and the name server for
  the VM being built with Hyper-V builder.  You must provide an
  appropriate value.
* `hyperv_netif` - Network interface name of the VM being build with
  Hyper-V builder.  Default value is `hvn0`.

- - -

Copyright &copy; 2019, 2020, 2024 Upperstream Software.
