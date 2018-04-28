# Packer templates for Debian 8.10

Templates to create Vagrant boxes for Debian 8.10 (amd64).


## Prerequisites

* [Packer][] v1.0.3+
* [Vagrant][] v1.8.6+
* [VirtualBox][]
	* Version 5.1.22+
* [VMware][] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi][] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/ "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"


## Provisioned software tools

* VirtualBox Guest Additions or [open-vm-tools][]
* sshd
* sudo
* `vagrant` user and its insecure public key

[open-vm-tools]: https://github.com/vmware/open-vm-tools "Official repository of VMware open-vm-tools project"


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso debian-8.10-amd64-minimal.json

You will find a vagrant box file named `Debian-8-amd64-minimal-v8.10.20171210-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `Debian-8-amd64-minimal-v8.10.20171210-virtualbox` to your box list
by the following command:

    vagrant box add Debian-8-amd64-minimal-v8.10.20171210-virtualbox.box --name Debian-8-amd64-minimal-v8.10.20171210-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso debian-8.10-amd64-minimal.json

You will find a vagrant box file named `Debian-8-amd64-minimal-v8.10.20171210-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `Debian-8-amd64-minimal-v8.10.20171210-vmware` to your box list
by the following command:

    vagrant box add Debian-8-amd64-minimal-v8.10.20171210-vmware.box --name Debian-8-amd64-minimal-v8.10.20171210-vmware

In the `output` directory you will also find a VM image that can be directly imported from VMware.


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso debian-8.10-amd64-minimal.json

Created VM will be unregistered from your Inventory.


## Variants

* `debian-8.10-amd64-minimal.json` - Debian 8.10 minimal installation
* `debian-8.10-amd64-ansible.json` - Debian 8.10 with [Ansible][] + [Testinfra][].
* `debian-8.10-amd64-docker.json` - Debian 8.10 with [Docker][] + [Docker Compose][]
* `debian-8.10-amd64-xfce.json` - Debian 8.10 with [Xfce][] + [xrdp][].
* `debian-8.10-amd64-dwm.json` - Debian 8.10 with [X.org][], [suckless][] tools, [ARandR][], and [xrdp][].

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[ARandR]: https://christian.amsuess.com/tools/arandr/ "ARandR: Another XRandR GUI"
[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose"
[suckless]: http://suckless.org/ "suckless.org software that sucks less"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.7.1 documentation"
[X.org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"
[xrdp]: http://www.xrdp.org/ "xrdp"


## Installer CD images

Optional var files are provided to instruct to use alternative installer CD images, i.e.,
`vars-debian-8.10-amd64-full.json` instructs to use `debian-8.10.0-amd64-CD-1.iso` while
`vars-debian-8.10-amd64-netinst.json` does `debian-8.10.0-amd64-netinst.iso` respectively.
Without using these var files, `debian-8.10.0-amd64-*.json` templates use `mini.iso`.

Depending on situation you can specify either of var files on the command line:

    packer build -var-file=vars-debian-8.10-amd64-full.json debian-8.10-amd64-minimal.json

It is recommended to use "jigdo" to download large iso image file and put it in `iso` directory.  Templates
instruct `packer` to use the image file rather than downloading an image from a mirror site.


## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `51200` which means 50GB.
* `root_password` - Password for `root` user.  Default value is `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to `true`.  Default value is `false`.


- - -

Copyright &copy; 2017 Upper Stream Software.
