# Packer templates for Ubuntu 15.10

Templates creating Vagrant boxes for Ubuntu 15.10 (x86_64).

## Prerequisites

* [Packer] v0.8.6+
* [Vagrant] v1.7.3+
* [VirtualBox]
	* Version 4.3.28+ for Windows
	* Version 4.3.28+ for Mac OS X (You may want to stay with 4.3.28 which allows [HAXM] to work in parallel.)

[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"

## Provisioned software tools

* VirtualBox Guest Additions
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command:

	packer build ubuntu-15.10-server-minimal.json

and you will find a vagrant box file named `Ubuntu-15.10-server-amd64-minimal.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-15.10-server-amd64-minimal` to your box list
by the following command:

	vagrant box add Ubuntu-15.10-server-amd64-minimal.box --name Ubuntu-15.10-server-amd64-minimal

## Variants

* `ubuntu-15.10-desktop-minimal.json` - Ubuntu Desktop 15.10
* `ubuntu-15.10-server-minimal.json` - Ubuntu Server 15.10
* `xubuntu-15.10-minimal.json` - Xubuntu 15.10


- - -

Copyright &copy; 2016 Upper Stream Software.
