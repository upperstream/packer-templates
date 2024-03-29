# Packer templates for Alpine Linux 3.12.9

Templates to create Vagrant boxes for Alpine Linux 3.12.9. (x86_64 and
i686)

## Prerequisites

* [Packer][] version 1.7.0+
* [Vagrant][] version 2.2.18+
* [VirtualBox][] version 6.1.26+
* [VMware][] Workstation version 15.5+ / VMware Fusion v10.0+
* [ESXi][] (vSphere Hypervisor) version 5.5+
* [QEMU][] version 4.2+ / [libvirt][] 6.0+
* [Hyper-V][] on Windows 10

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
    "Introduction to Hyper-V on Windows 10 | Microsoft Docs"
[libvirt]: https://libvirt.org/
  "libvirt: The virtualization API"
[Packer]: https://www.packer.io/
  "Packer by HashiCorp"
[QEMU]: https://www.qemu.org/
  "QEMU"
[Vagrant]: https://www.vagrantup.com/
  "Vagrant"
[VirtualBox]: https://www.virtualbox.org/
  "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* sudo
* chronyd (NTP daemon)
* rsync
* NFS (installed but not enabled)
* `vagrant` user and its insecure public key

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

You will find a vagrant box file named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112`
to your box list by the following command:

    vagrant box add Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-virtualbox.box --name Alpine-standard-3.12-x86_64-minimal-v12.9.20211112 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

You will find a vagrant box file named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112`
to your box list by the following command:

    vagrant box add Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-vmware.box --name Alpine-standard-3.12-x86_64-minimal-v12.9.20211112 --provider vmware

In the `output` directory you will also find a VM image that can be
directly imported to VMware.

### ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
  created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

(Note that created VM will be unregistered from your Inventory.)

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=esxi-iso -var esxi_vnc_over_websocket=false -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

You will find a vagrant box file named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112`
to your box list by the following command:

    vagrant box add Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-libvirt.box --name Alpine-standard-3.12-x86_64-minimal-v12.9.20211112 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json

You will find a vagrant box file named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `Alpine-standard-3.12-x86_64-minimal-v12.9.20211112`
to your box list by the following command:

    vagrant box add Alpine-standard-3.12-x86_64-minimal-v12.9.20211112-hyperv --name Alpine-standard-3.12-x86_64-minimal-v12.9.20211112 --provider hyperv

## Default settings

These default settings are done by the file `Vagrantfile.Alpine` which
will be included in the box.  You can override this setting by your
own `Vagrantfile`.

### Synced Folder

Synced Folder of this box is disabled by default, alhtough VirtualBox
Guest Additions is installed on the box.  You can enable this feature
using `config.vm.synced_folder` method in your `Vagrantfile`.

### SSH Shell

Because Bash is not the standard shell for Alpine Linux, default shell
for SSH connection of this box is set to `/bin/ash`.

## Variants

* `packer build -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-minimal.json` - Alpine Linux 3.12.9 (x86_64)
* `packer build -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-ansible.json` - Alpine Linux 3.12.9 with [Ansible] and [Testinfra] (x86_64)
* `packer build -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-docker.json` - Alpine Linux 3.12.9 with [Docker] + [Docker Compose] (x86_64)
* `packer build -var-file=vars-alpine-standard-3.12-x86_64.json alpine-3.12-dwm.json` - Alpine Linux 3.12.9 with [X.Org], [dwm], [dmenu], [st] and more tools (x86_64)
* `packer build -var-file=vars-alpine-standard-3.12-x86.json alpine-3.12-minimal.json` - Alpine Linux 3.12.9 (x86)
* `packer build -var-file=vars-alpine-standard-3.12-x86.json alpine-3.12-ansible.json` - Alpine Linux 3.12.9 with Ansible and Testinfra (x86)
* `packer build -var-file=vars-alpine-standard-3.12-x86.json alpine-3.12-dwm.json` - Alpine Linux 3.12.9 with X.Org, dwm, dmenu, st and more tools (x86)

[Ansible]: https://www.ansible.com/
  "Ansible is Simple IT Automation"
[Ansible Lint]: https://docs.ansible.com/ansible-lint/
  "Ansible Lint Documentation &mdash; Ansible Documentation"
[dmenu]: http://tools.suckless.org/dmenu/
  "dmenu | suckless.org tools"
[Docker]: https://www.docker.com/
  "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/
  "Docker Compose - Docker Documentation"
[dwm]: http://dwm.suckless.org/
  "suckless.org dwm - dynamic window manager"
[st]: http://st.suckless.org/
  "suckless.org st - simple terminal"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
  "Testinfra test your infrastructure &#8212; testinfra 3.4.1.dev0+gd7a7512.d20200105 documentation"
[X.Org]: https://www.x.org/wiki/
  "X.Org"

## Optimised kernel for virtual machines

Instead of `vars-alpine-standard-3.12-x86*.json` files you can use
`vars-alpine-virt-3.12-x86*.json`.  These files instruct to use ISO
images with kernels optimised for virtual machines.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `root_password` - Password for `root` user.  Default value is
  `vagrant`.
* `ssh_timeout` - Timeout value for SSH connection.  Default value is
  `1800s`.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.  This is also used for
  SSH user name during build time.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.  This is also used for SSH password during build time.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `esxi_vnc_over_websocket` - Controlls whether or not to use VNC over
  WebSocket feature for ESXi.  Default value is `true`.  Set to `false`
  if your ESXi host version is prior to 6.7 which supports VNC server.
* `qemu_use_default_display` - Do not pass `-display` option to QEMU if
  `true`.  Default value is `false`.
* `qemu_display` - Value for `-display` option for QEMU.  Default value
  is an empty string.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.

- - -

Copyright &copy; 2020, 2021, 2023 Upperstream Software.
