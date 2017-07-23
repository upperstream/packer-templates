# Packer templates for CentOS 6.7

Templates creating Vagrant boxes for CentOS 6.7 minimal installation (x86_64 and i386).

## Prerequisites

* [Packer] v0.6.1
* [Vagrant] v1.6.5
* [VirtualBox]
	* Version 4.3.16 for Windows
	* Version 4.2.8 for Mac OS X (which allows [HAXM] to work in parallel)

[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"

## Provisioned software tools

* VirtualBox Guest Additions
* curl
* sshd
* sudo
* rsync
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command:

	packer build centos-6.7-x86_64-minimal.json

and you will find a vagrant box file named `CentOS-6.7-x86_64-minimal-v2017.05.03.box`
in the same directory after the command has succeeded.

Then you can add the box named `CentOS-6.7-x86_64-minimal-v2017.05.03` to your box list
by the following command:

	vagrant box add CentOS-6.7-x86_64-minimal-v2017.05.03.box --name CentOS-6.7-x86_64-minimal-v2017.05.03

## Variants

### x86_64 architecture

* `centos-6.7-x86_64-minimal.json` - CentOS 6.7 (x86_64) minimal installation
* `centos-6.7-x86_64-ansible.json` - provided with [Ansible]
  in addition to CentOS 6.7 (x86_64) minimal installation
* `centos-6.7-x86_64-docker.json` - provided with [Docker], [Docker Compose], and [Fig];
  in addition to CentOS 6.7 (x86_64) minimal installation.
  (Fig has been officially replaced by Docker Compose.) 

### i386 architecture

* `centos-6.7-i386-minimal.json` - CentOS 6.7 (i386) minimal installation
* `centos-6.7-i386-ansible.json` - provided with [Ansible]
  in addition to CentOS 6.7 (i386) minimal installation

[Ansible]: http://www.ansible.com/home "Ansible is Simple IT Automation"
[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose - Docker Documentation"
[Fig]: http://www.fig.sh/ "Fig | Fast, isolated development environments using Docker"

- - -

Copyright &copy; 2014, 2015, 2017 Upper Stream Software.
