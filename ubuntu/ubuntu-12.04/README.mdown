# Packer template for Ubuntu 12.04.5

Template to create a Vagrant box for Ubuntu 12.04.5 (x86_64).


## Prerequisites

* [Packer][] v0.6.1
* [Vagrant][] v1.6.5
* [VirtualBox][] Version 4.3.36 for Windows
* [VMware] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/ "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"


## Provisioned software tools

* VirtualBox Guest Additions
* `vagrant` user and its insecure public key


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso ubuntu-12.04-server-minimal.json

You will find a vagrant box file named `Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-virtualbox` to your box list
by the following command:

    vagrant box add Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-virtualbox.box --name Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso ubuntu-12.04-server-minimal.json

You will find a vagrant box file named `Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-vmware` to your box list
by the following command:

    vagrant box add Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-vmware.box --name Ubuntu-12.04-server-amd64-minimal-v1204.5.20170702-vmware

In the `output` directory you will also find a VM image that can be directly imported from VMware.


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso ubuntu-12.04-server-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Build parameter

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960` which means 40GB.
* `headless` - Launch the virtual machine in headless mode if set to `true`.  Default value is `false`.

- - -

Copyright &copy; 2017 Upper Stream Software.
