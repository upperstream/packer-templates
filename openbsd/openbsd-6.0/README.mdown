# Packer templates for OpenBSD 6.0

Templates to create Vagrant boxes for OpenBSD 6.0 (amd64 and i386).

## Prerequisites

* [Packer] v0.8.6+
* [Vagrant] v1.7.3+ which adds `config.ssh.sudo_command` configuration
* [VirtualBox]
	* Version 4.3.28+ for Windows
	* Version 4.3.28+ for Mac OS X (You may want to stay with 4.3.28 which allows [HAXM] to work in parallel.)
* [VMware] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/ "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"

## Provisioned software tools

* sshd
* rsync
* sharity-light
* sudo
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command for VirtualBox provider:

	packer build -only=virtualbox-iso -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-minimal.json

or:

	packer build -only=vmware-iso -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-minimal.json

for VMware provider.
You will find a vagrant box file named `OpenBSD-6.0-amd64-minimal-v6.0.0-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-6.0-amd64-minimal-v6.0.0-virtualbox` to your box list
by the following command:

	vagrant box add OpenBSD-6.0-amd64-minimal-v6.0.0-virtualbox.box --name OpenBSD-6.0-amd64-minimal-v6.0.0-virtualbox

## Default settings

These default settings below are done by the file `Vagrantfile.OpenBSD` which will be included in the box.
Users can override this setting by users' own `Vagrantfile`s.

### Synced Folder

Due to Vagrant limitation of OpenBSD support, Synced Folder of this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for OpenBSD, default shell for SSH connection of this box
is set to "`/bin/ksh`".

## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-minimal.json

(Note that created VM will be unregistered from your Inventory.)

## Variants

`sudo` is enabled with all variants.

* `packer build -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-minimal.json` - OpenBSD 6.0 (amd64)
* `packer build -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-ansible.json` - OpenBSD 6.0 (amd64) with [Ansible]+[Testinfra]
* `packer build -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-x11.json` - OpenBSD 6.0 (amd64) with [X11]
* `packer build -var-file=vars-openbsd-6.0-amd64-mini.json openbsd-6.0-xfce.json` - OpenBSD 6.0 (amd64) with [Xfce]
* `packer build -var-file=vars-openbsd-6.0-i386-mini.json openbsd-6.0-minimal.json` - OpenBSD 6.0 (i386)
* `packer build -var-file=vars-openbsd-6.0-i386-mini.json openbsd-6.0-ansible.json` - OpenBSD 6.0 (i386) with Ansible+Testinfra
* `packer build -var-file=vars-openbsd-6.0-i386-mini.json openbsd-6.0-x11.json` - OpenBSD 6.0 (i386) with X11
* `packer build -var-file=vars-openbsd-6.0-i386-mini.json openbsd-6.0-xfce.json` - OpenBSD 6.0 (i386) with Xfce

`vars-openbsd-6.0-{amd64|i386}-mini.json` uses `cd60.iso` installer CD while `vars-openbsd-6.0-{amd64|i386}-full.json` uses `install60.iso`.

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.1.3.dev24 documentation"
[X11]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"

## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960` which means 40GB.
* `vagrant_username` - User name used for run time.  Vagrant box is set for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value is `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.  Default value is `vagrant`.

- - -

Copyright &copy; 2016 Upper Stream Software.
