# Packer templates for OpenBSD 5.7

Templates to create Vagrant boxes for OpenBSD 5.7 (amd64 and i386).

## Prerequisites

* [Packer] v0.8.6+
* [Vagrant] v1.7.2+
* [VirtualBox]
	* Version 4.3.28+ for Windows
	* Version 4.3.28+ for Mac OS X (You may want to stay with 4.3.28 which allows [HAXM] to work in parallel.)

[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"

## Provisioned software tools

* sshd
* rsync
* sharity-light
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command:

	packer build openbsd-5.7-amd64.json

and you will find a vagrant box file named `OpenBSD-5.7-amd64-v1.1.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-5.7-amd64-v1.1` to your box list
by the following command:

	vagrant box add OpenBSD-5.7-amd64-v1.1.box --name OpenBSD-5.7-amd64-v1.1

## Default settings

These default settings are done by the file `Vagrantfile.OpenBSD` which will be included in the box.
Users can override this setting by users' own `Vagrantfile`s.

### Synced Folder

Due to Vagrant limitation of OpenBSD support, Synced Folder of this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for OpenBSD, default shell for SSH connection of this box
is set to "`/bin/ksh`".

## Variants

* `openbsd-5.7-amd64.json` - OpenBSD 5.7 (amd64)
* `openbsd-5.7-i386.json` - OpenBSD 5.7 (i386)

## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `root_password` - Password for `root` user.  Default value is `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value is `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.  Default value is `vagrant`.

- - -

Copyright &copy; 2015, 2016 Upper Stream Software.
