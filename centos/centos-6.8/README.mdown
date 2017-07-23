# Packer templates for CentOS 6.8

Templates to create Vagrant boxes for CentOS 6.8 (x86_64 and i386).

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

* VirtualBox Guest Additions
* curl
* sshd
* sudo
* rsync
* `vagrant` user and its insecure public key
* ... and their dependencies

## How to create a box

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso -var-file=vars-centos-6.8-x86_64.json centos-6.8-minimal.json

or:

    packer build -only=vmware-iso -var-file=vars-centos-6.8-x86_64.json centos-6.8-minimal.json

for VMware provider.
You will find a vagrant box file named `CentOS-6.8-x86_64-minimal-v2017.05.03-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `CentOS-6.8-x86_64-minimal-v2017.05.03-virtualbox` to your box list
by the following command:

    vagrant box add CentOS-6.8-x86_64-minimal-v2017.05.03-virtualbox.box --name CentOS-6.8-x86_64-minimal-v2017.05.03-virtualbox


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso -var-file=vars-centos-6.8-x86_64.json centos-6.8-minimal.json

(Note that created VM will be unregistered from your Inventory.)

## Variants

### x86_64 architecture

* `packer build -var-file=vars-centos-6.8-x86_64.json centos-6.8-minimal.json` - CentOS 6.8 (x86_64) minimal installation
* `packer build -var-file=vars-centos-6.8-x86_64.json centos-6.8-ansible.json` - provided with [Ansible] and [Testinfra]
  in addition to CentOS 6.8 (x86_64) minimal installation
* `packer build -var-file=vars-centos-6.8-x86_64.json centos-6.8-docker.json` - provided with [Docker] and [Docker Compose];
  in addition to CentOS 6.8 (x86_64) minimal installation.

### i386 architecture

* `packer build -var-file=vars-centos-6.8-i386.json centos-6.8-minimal.json` - CentOS 6.8 (i386) minimal installation
* `packer build -var-file=vars-centos-6.8-i386.json centos-6.8-ansible.json` - provided with Ansible and Testinfra
  in addition to CentOS 6.8 (i386) minimal installation

[Ansible]: http://www.ansible.com/home "Ansible is Simple IT Automation"
[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose - Docker Documentation"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.1.3.dev24 documentation"

- - -

Copyright &copy; 2016, 2017 Upper Stream Software.
