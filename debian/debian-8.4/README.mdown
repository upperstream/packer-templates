# Packer templates for Debian 8.4

Templates to create Vagrant boxes for Debian 8.4 (amd64).

## Prerequisites

* [Packer] v0.8.6+
* [Vagrant] v1.7.3+
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

* VirtualBox Guest Additions or [open-vm-tools]
* curl
* sshd
* sudo
* rsync
* `vagrant` user and its insecure public key
* ... and their dependencies

[open-vm-tools]: https://github.com/vmware/open-vm-tools "Official repository of VMware open-vm-tools project"

## How to create a box

From the terminal, invoke the following command for VirtualBox provider:

	packer build -only=virtualbox-iso debian-8.4-amd64-minimal.json

or:

	packer build -only=vmware-iso debian-8.4-amd64-minimal.json

for [VMware] provider.
You will find a vagrant box file named `Debian-8.4-amd64-minimal-v1.1-virtualbox.box`
or `Debian-8.4-amd64-minimal-v1.1-vmware.box` in the same directory after the command has succeeded.

Then you can add the box named `Debian-8.4-amd64-minimal-v1.1-virtualbox` to your box list
by the following command:

	vagrant box add Debian-8.4-amd64-minimal-v1.1-virtualbox.box --name Debian-8.4-amd64-minimal-v1.1-virtualbox

## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi (Created VM will be unregistered from your Inventory):

    packer build -only=esxi-iso debian-8.4-amd64-minimal.json

## Variants

* `debian-8.4-amd64-minimal.json` - Debian 8.4 minimal installation
* `debian-8.4-amd64-docker.json` - provided with [Docker] in addition to Debian 8.4 minimal installation.
* `debian-8.4-amd64-xfce.json` - provided with [Xfce] and [xrdp] in addition to Debian 8.4 minimal installation.

[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"

## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `mem_size` - RAM size of the created VM.
* `disk_size` - Disk size of the created VM.

- - -

Copyright &copy; 2016 Upper Stream Software.
