# Packer templates for Alpine 3.2.3

Templates creating Vagrant box for Alpine 3.2.3. (x86_64 and i686)

## Prerequisites

* [Packer] v0.7.2
* [Vagrant] v1.7.2
* [VirtualBox]
	* Version 4.3.26 for Windows
	* Version 4.2.8 for Mac OS X (which allows [HAXM] to work in parallel)

[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"

## Provisioned software tools

* sshd
* sudo
* chronyd (NTP daemon)
* rsync
* NFS (installed but not enabled)
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command:

	packer build alpine-linux-3.2-x86_64.json

and you will find a vagrant box file named `Alpine-Linux-3.2.3-x86_64-minimal.box`
in the same directory after the command has succeeded.

Then you can add the box named `Alpine-Linux-3.2.3-x86_64-minimal.box` to your box list
by the following command:

	vagrant box add Alpine-Linux-3.2.3-x86_64-minimal.box --name Alpine-Linux-3.2.3-x86_64-minimal

## Default settings

These default settings are done by the file `Vagrantfile.Alpine` which will be included in the box.
Users can override this setting by users' own `Vagrantfile`s.

### Synced Folder

Due to limitation of Vagrant's support for Alpine Linux, Synced Folder of this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for Alpine Linux, default shell for SSH connection of this box
is set to "`/bin/ash`".

## Variants

* `alpine-linux-3.2-x86_64.json` - Alpine Linux 3.2.3 (x86_64)
* `alpine-linux-3.2-x86.json` - Alpine Linux 3.2.3 (x86)

- - -

Copyright &copy; 2015 Upper Stream Software.
