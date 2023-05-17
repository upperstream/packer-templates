# Packer templates for Ubuntu 18.04 LTS

Templates to create Vagrant boxes for Ubuntu 18.04 LTS (x86_64).


## Prerequisites

* [Packer][] v1.1.3+
* [Vagrant][] v1.9.8+
* [VirtualBox][] Version 5.1.34+
* [VMware][] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi][] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/
    "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"


## Provisioned software tools

* VirtualBox Guest Additions
* `vagrant` user and its insecure public key


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso ubuntu-18.04-minimal.json

You will find a vagrant box file named `Ubuntu-18.04-amd64-minimal-v1804.0.20180427-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-18.04-amd64-minimal-v1804.0.20180427-virtualbox`
to your box list by the following command:

    vagrant box add Ubuntu-18.04-amd64-minimal-v1804.0.20180427-virtualbox.box --name Ubuntu-18.04-amd64-minimal-v1804.0.20180427-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso ubuntu-18.04-minimal.json

You will find a vagrant box file named `Ubuntu-18.04-amd64-minimal-v1804.0.20180427-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `Ubuntu-18.04-amd64-minimal-v1804.0.20180427-vmware`
to your box list by the following command:

    vagrant box add Ubuntu-18.04-amd64-minimal-v1804.0.20180427-vmware.box --name Ubuntu-18.04-amd64-minimal-v1804.0.20180427-vmware

In the `output` directory you will also find a VM image that can be
directly imported from VMware.


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be
  created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso ubuntu-18.04-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Variants

* `ubuntu-18.04-minimal.json` - Ubuntu Server 18.04 LTS
* `ubuntu-18.04-ansible.json` - Ubuntu Server 18.04 LTS + [Ansible][]
  + [Testinfra][]
* `ubuntu-18.04-dwm.json` - Ubuntu 18.04 LTS + [X.org][], [suckless][]
  tools, [ARandR][], and [xrdp][].
* `ubuntu-18.04-lxde.json` - Ubuntu 18.04 LTS + [LXDE][]
* `ubuntu-18.04-xfce.json` - Ubuntu 18.04 LTS + [Xfce][]

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[ARandR]: https://christian.amsuess.com/tools/arandr/
    "ARandR: Another XRandR GUI"
[LXDE]: http://lxde.org/ "LXDE"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/
    "Testinfra test your infrastructure &mdash; testinfra 1.10.2.dev3 documentation"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: https://xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"


## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `archive_mirror`: - URL to download packages from.  Default value is
  `http://archive.ubuntu.com/ubuntu`.
* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `vagrant_username` - User name used for run time.  Vagrant box is set
  for this user.  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.


- - -

Copyright &copy; 2018 Upperstream Software.
