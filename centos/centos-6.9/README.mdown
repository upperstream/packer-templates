# Packer templates for CentOS 6.9

Templates to create Vagrant boxes for CentOS 6.9 (x86_64 and i386).

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

    packer build -only=virtualbox-iso -var-file=vars-centos-6.9-x86_64.json centos-6.9-minimal.json

or:

    packer build -only=vmware-iso -var-file=vars-centos-6.9-x86_64.json centos-6.9-minimal.json

for VMware provider.
You will find a vagrant box file named `CentOS-6.9-x86_64-minimal-v2017.05.06-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `CentOS-6.9-x86_64-minimal-v2017.05.06-virtualbox` to your box list
by the following command:

    vagrant box add CentOS-6.9-x86_64-minimal-v2017.05.06-virtualbox.box --name CentOS-6.9-x86_64-minimal-v2017.05.06-virtualbox


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso -var-file=vars-centos-6.9-x86_64.json centos-6.9-minimal.json

(Note that created VM will be unregistered from your Inventory.)

## Variants

### x86_64 architecture

* `packer build -var-file=vars-centos-6.9-x86_64.json centos-6.9-minimal.json` - CentOS 6.9 (x86_64) minimal installation
* `packer build -var-file=vars-centos-6.9-x86_64.json centos-6.9-ansible.json` - provided with [Ansible] and [Testinfra]
  in addition to CentOS 6.9 (x86_64) minimal installation
* `packer build -var-file=vars-centos-6.9-x86_64.json centos-6.9-docker.json` - provided with [Docker] and [Docker Compose];
  in addition to CentOS 6.9 (x86_64) minimal installation.

### i386 architecture

* `packer build -var-file=vars-centos-6.9-i386.json centos-6.9-minimal.json` - CentOS 6.9 (i386) minimal installation
* `packer build -var-file=vars-centos-6.9-i386.json centos-6.9-ansible.json` - provided with Ansible and Testinfra
  in addition to CentOS 6.9 (i386) minimal installation

[Ansible]: http://www.ansible.com/home "Ansible is Simple IT Automation"
[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose - Docker Documentation"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.5.5 documentation"


## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960` which means 40GB.
* `headless` - Launch the virtual machine in headless mode if set to `true`.  Default value is `false`.

- - -

Copyright &copy; 2017 Upper Stream Software.
