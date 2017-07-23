# Packer templates for Debian 8.0

Templates to create Vagrant boxes for Debian 8.0 (amd64).

## Prerequisites

* [Packer] v0.8.6+
* [Vagrant] v1.7.3+
* [VirtualBox]
	* Version 4.3.28+ for Windows
	* Version 4.3.28+ for Mac OS X (You may want to stay with 4.3.28 which allows [HAXM] to work in parallel.)

[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"

## Provisioned software tools

* VirtualBox Guest Additions
* curl
* sshd
* sudo
* rsync
* `vagrant` user and its insecure public key

## How to create a box

From the terminal, invoke the following command:

	packer build debian-8.0-amd64-minimal.json

and you will find a vagrant box file named `Debian-8.0-amd64-minimal-v8.0.0.box`
in the same directory after the command has succeeded.

Then you can add the box named `Debian-8.0-amd64-minimal-v8.0.0` to your box list
by the following command:

	vagrant box add Debian-8.0-amd64-minimal-v8.0.0.box --name Debian-8.0-amd64-minimal-v8.0.0

## Variants

* `debian-8.0-amd64-minimal.json` - Debian 8.0 minimal installation
* `debian-8.0-amd64-docker.json` - provided with [Docker] in addition to Debian 8.0 minimal installation.

[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"

- - -

Copyright &copy; 2015, 2016 Upper Stream Software.
