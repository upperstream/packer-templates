# Packer templates for NetBSD 9.0

Templates to create Vagrant boxes for NetBSD 9.0 (amd64 and i386).


## Prerequisites

* [Packer][] v1.4.1 - v1.5.6; see the note 1 for compatibility issue
* [Vagrant][] v2.2.6+
* [VirtualBox][] v5.2.32 - v6.x; see the note 2 for compatibility issue
* [VMware][] Workstation v15.0+ / VMware Fusion v10.0+
* [ESXi][] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
  "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
  "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

### Notes for compatibility issues

1. Delete `iso_checksum_type` from the JSON config file if you use
   Packer later than v1.5.6, or run `packer fix` command to update the
   config file.
2. Add `["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]`
   to the `vboxmanege` array in the JSON config file if you use
   VirtualBox v7.0 or later.
3. Depending on when you create a box, you may need to update the
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

You will find a vagrant box file named `NetBSD-9.0-amd64-minimal-v9.0.20200428-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.0-amd64-minimal-v9.0.20200428-virtualbox`
to your box list by the following command:

    vagrant box add NetBSD-9.0-amd64-minimal-v9.0.20200428-virtualbox.box --name NetBSD-9.0-amd64-minimal-v9.0.20200428-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso netbsd-9-and64-minimal.json

You will find a vagrant box file named `NetBSD-9.0-amd64-minimal-v9.0.20200428-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-9.0-amd64-minimal-v9.0.20200428-vmware`
to your box list by the following command:

    vagrant box add NetBSD-9.0-amd64-minimal-v9.0.20200428-vmware.box --name NetBSD-9.0-amd64-minimal-v9.0.20200428-vmware

In the `output` directory you will also find a VM image that can be
directly imported from VMware.


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

* `netbsd-9-minmal.json` - NetBSD 9.0
* `netbsd-9-ansible.json` - NetBSD 9.0 + [Ansible][] +
  [Ansible Lint][] + [Testinfra][]
* `netbsd-9-xorg.json` - NetBSD 9.0 + [X.Org][]
* `netbsd-9-dwm.json` - NetBSD 9.0 + X.Org + [dwm][] + [st][]
  + [dmenu][], with [XDM] enabled
* `netbsd-9-xfce.json` - NetBSD 9.0 + [Xfce][], with XDM enabled
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

- - -

Copyright &copy; 2019, 2020, 2024 Upperstream Software.
