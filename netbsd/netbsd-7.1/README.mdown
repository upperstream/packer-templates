# Packer templates for NetBSD 7.1.2

Templates to create Vagrant boxes for NetBSD 7.1.2 (amd64 and i386).


## Prerequisites

* [Packer][] v1.1.0+
* [Vagrant][] v1.9.8+
* [VirtualBox][] 5.1.30+
* [VMware][] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi][] (vSphere Hypervisor) v5.5+

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
* ntpd
* rsync
* NFS client
* `vagrant` user and its insecure public key


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso -var-file=vars-netbsd-7.1-amd64.json netbsd-7.1-minimal.json

You will find a vagrant box file named `NetBSD-7.1-amd64-minimal-v7.1.20180319-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-7.1-amd64-minimal-v7.1.20180319-virtualbox`
to your box list by the following command:

    vagrant box add NetBSD-7.1-amd64-minimal-v7.1.20180319-virtualbox.box --name NetBSD-7.1-amd64-minimal-v7.1.20180319-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso -var-file=vars-netbsd-7.1-amd64.json netbsd-7.1-minimal.json

You will find a vagrant box file named `NetBSD-7.1-amd64-minimal-v7.1.20180319-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `NetBSD-7.1-amd64-minimal-v7.1.20180319-vmware`
to your box list by the following command:

    vagrant box add NetBSD-7.1-amd64-minimal-v7.1.20180319-vmware.box --name NetBSD-7.1-amd64-minimal-v7.1.20180319-vmware

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

    packer build -only=esxi-iso -var-file=vars-netbsd-7.1-amd64.json netbsd-7.1-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Variants

* `netbsd-7.1-minmal.json` - NetBSD 7.1.2 minimal installation
* `netbsd-7.1-ansible.json` - NetBSD 7.1.2 + [Ansible][] + [Testinfra][]
* `netbsd-7.1-xorg.json` - NetBSD 7.1.2 + [X.Org][]
* `netbsd-7.1-dwm.json` - NetBSD 7.1.2 + X.Org + [dwm][] + [st][] +
  [dmenu][]
* `netbsd-7.1-xfce.json` - NetBSD 7.1.2 + [Xfce][] + [XDM][] (amd64 only)

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
    "Testinfra test your infrastructure &#8212; testinfra 1.10.2.dev3 documentation"
[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/
    "suckless.org dwm - dynamic window manager"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[XDM]: https://www.x.org/releases/X11R7.6/doc/man/man1/xdm.1.xhtml "XDM"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

As a parameter to `-var-file` option, you can choose either
`vars-netbsd-7.1-amd64.json` for amd64 or `vars-netbsd-7.1-i386.json`
for i386 in order to specify the architecture of your box.


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
* `package_server` - URL to download binary packages from.  Default
  value is `http://ftp.NetBSD.org/pub/pkgsrc`.
* `pkgsrc_tag` - combination of OS version and tag name on pkgsrc to
  specify a directory to download binary packages from.  Default value
  is `7.0_2017Q4` for amd64 and `7.0_2017Q3` for i386.
* `ssh_username` - User name to login via SSH during build time.
  Default value is `root`.
* `ssh_password` - SSH password for `ssh_user` during build time.
  Default value is `vagrant`.
* `vagrant_username` - User name during run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value
  is `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.
  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.


## Notes

* Due to an issue with Ruby Net::SSH package, `vagrant up` a NetBSD 7.1
  box fails when you use Vagrant version prior to 1.9.6 or Net::SSH
  version prior to 4.2.0.rc1.  You need to upgrade Vagrant or Ruby
  Net::SSH, otherwise you can manually apply [this patch](../patches/net-ssh.patch).
  See the following resources for further information:

    * [vagrant up netbsd70 fails on waiting for boot (ssh) but vagrant ssh works](https://github.com/mitchellh/vagrant/issues/6640)
    * [Use default cipher list for ssh communicator](https://github.com/mitchellh/vagrant/pull/8661)
    * [Move `none` cipher to end of cipher list](https://github.com/net-ssh/net-ssh/pull/525)

- - -

Copyright &copy; 2017, 2018 Upperstream Software.
