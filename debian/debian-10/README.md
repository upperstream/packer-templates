# Packer templates for Debian 10.9

Templates to create Vagrant boxes for Debian 10.9 (amd64).

## Prerequisites

* [Packer][] v1.6.2+
* [Vagrant][] v2.2.6+
* [VirtualBox][] v6.1.10+
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

## Provisioned software tools

* VirtualBox Guest Additions or [open-vm-tools][]
* sshd
* sudo
* `vagrant` user and its insecure public key

[open-vm-tools]: https://github.com/vmware/open-vm-tools
    "Official repository of VMware open-vm-tools project"

## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso debian-10-amd64-minimal.json

You will find a vagrant box file named
`Debian-10-amd64-minimal-v10.13.20220910-virtualbox.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-10-amd64-minimal-v10.13.20220910`
to your box list by the following command:

    vagrant box add Debian-10-amd64-minimal-v10.13.20220910-virtualbox.box --name Debian-10-amd64-minimal-v10.13.20220910 --provider virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso debian-10-amd64-minimal.json

You will find a vagrant box file named
`Debian-10-amd64-minimal-v10.13.20220910-vmware.box` in the same
directory after the command has succeeded.

Then you can add the box named `Debian-10-amd64-minimal-v10.13.20220910`
to your box list by the following command:

    vagrant box add Debian-10-amd64-minimal-v10.13.20220910-vmware.box --name Debian-10-amd64-minimal-v10.13.20220910 --provider vmware_desktop

In the `output` directory you will also find a VM image that can be
directly imported from VMware.

## ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
  created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso debian-10-amd64-minimal.json

When you create a box on ESXi host version prior to 6.7, you need to
enable VNC on the host and need to disable Packer's VNC over WebSocket
feature by adding `-var esxi_vnc_over_websocket=false` parameter:

    packer build -only=esxi-iso -var esxi-vnc-over-websocket=false debian-10-amd64-minimal.json

### QEMU/libvirt

From the terminal, invoke the following command for Libvirt provider:

    packer build -only=qemu debian-10-amd64-minimal.json

You will find a vagrant box file named `Debian-10-amd64-minimal-v10.13.20220910-libvirt.box`
in the same directory after the command has succeeded.

Then you can add the box named `Debian-10-amd64-minimal-v10.13.20220910`
to your box list by the following command:

    vagrant box add Debian-10-amd64-minimal-v10.13.20220910-libvirt.box --name Debian-10-amd64-minimal-v10.13.20220910 --provider libvirt

In the `output` directory you will also find a VM image that can be
directly imported to QEMU.

### Hyper-V

From the terminal, invoke the following command for Hyper-V provider:

    packer build -only=hyperv-iso debian-10-amd64-minimal.json

You will find a vagrant box file named `Debian-10-amd64-minimal-v10.13.20220910-hyperv.box`
in the same directory after the command has succeeded.

Then you can add the box named `Debian-10-amd64-minimal-v10.13.20220910`
to your box list by the following command:

    vagrant box add Debian-10-amd64-minimal-v10.13.20220910-hyperv.box --name Debian-10-amd64-minimal-v10.13.20220910 --provider hyperv

## Variants

* `debian-10-amd64-minimal.json` - Debian 10.9 minimal installation
* `debian-10-amd64-ansible.json` - Debian 10.9 with [Ansible][] +
  [Ansible Lint][] + [Testinfra][]
* `debian-10-amd64-docker.json` - Debian 10.9 with [Docker][] +
  [Docker Compose][]
* `debian-10-amd64-dwm.json` - Debian 10.9 with [X.org][], [suckless][]
  tools, [ARandR][], and [xrdp][].
* `debian-10-amd64-xfce.json` - Debian 10.9 with [Xfce][] + [xrdp][].

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Ansible Lint]: https://docs.ansible.com/ansible-lint/
  "Ansible Lint Documentation &mdash; Ansible Documentation"
[ARandR]: https://christian.amsuess.com/tools/arandr/
    "ARandR: Another XRandR GUI"
[Docker]: https://www.docker.com/
    "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose"
[SLiM]: https://sourceforge.net/projects/slim.berlios/
    "SLiM download | SourceForge.net"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
    "Testinfra test your infrastructure &#8212; testinfra 5.0.1.dev13+g37c7488.d20200507 documentation"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Installer CD images

Optional var files are provided to instruct to use alternative
installer CD images, i.e., `vars-debian-10-amd64-full.json` instructs to
use `debian-10.13.0-amd64-xfce-CD-1.iso` while
`vars-debian-10-amd64-netinst.json` does
`debian-10.13.0-amd64-netinst.iso` respectively.  Without using these
var files, `debian-10-amd64-*.json` templates use `mini.iso`.

Depending on situation you can specify either of var files on the
command line:

    packer build -var-file=vars-debian-10-amd64-full.json debian-10-amd64-minimal.json

It is recommended to use "jigdo" to download large iso image file and
put it in `./iso` directory.  Templates instruct `packer` to use the
image file rather than downloading an image from a mirror site.

## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `mem_size` - RAM size of the created VM.  Default value for CUI
  variants is `640` which means 640MB and the one for GUI variants is
  `1024` which means 1024MB.
* `disk_size` - Disk size of the created VM.  Default value is `51200`
  which means 50GB.
* `root_password` - Password for `root` user.  Default value is
  `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.
* `virtualbox_version` - VirtualBox Guest Additions version number.
  Default value is "6.1.10".
* `esxi_vnc_over_websocket` - Controlls whether or not to use VNC over
  WebSocket feature for ESXi.  Default value is `true`.  Set to `false`
  if your ESXi host version is prior to 6.7 which supports VNC server.
* `qemu_use_default_display` - Determines to pass a `-display` option
  to QEMU or not.  Default value is `false`.
* `qemu_display` - What QEMU `-display` option to use.  Default value
  is an empty string.
* `hyperv_switch_name` - Network switch name on Packer Hyper-V builder.
  Default value is `Default Switch`.

- - -

Copyright &copy; 2019-2021 Upperstream Software.
