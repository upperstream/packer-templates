# Packer templates for OpenBSD 6.3

Templates to create Vagrant boxes for OpenBSD 6.3 (amd64 and i386).


## Prerequisites

* [Packer][] v0.8.6+
* [Vagrant][] v1.7.3+ which adds `config.ssh.sudo_command` configuration
* [VirtualBox][]
	* Version 4.3.28+ for Windows
	* Version 4.3.28+ for Mac OS X (You may want to stay with 4.3.28 which allows [HAXM][] to work in parallel.)
* [VMware][] Workstation v11.1.0+ / VMware Fusion v8.0+
* [ESXi][] (vSphere Hypervisor) v5.5+

[ESXi]: http://www.vmware.com/products/vsphere-hypervisor
        "Free VMware vSphere Hypervisor, Free Virtualization (ESXi)"
[HAXM]: https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager
        "Intel&reg; Hardware Accelerated Execution Manager"
[Packer]: https://www.packer.io/ "Packer by HashiCorp"
[Vagrant]: https://www.vagrantup.com/ "Vagrant"
[VirtualBox]: https://www.virtualbox.org/ "Oracle VM VirtualBox"
[VMware]: http://www.vmware.com/ "VMware Virtualization for Desktop &amp; Server, Application, Public &amp; Hybrid Clouds"


## Provisioned software tools

* sshd
* rsync
* `vagrant` user and its insecure public key


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso openbsd-6.3-minimal.json

You will find a vagrant box file named `OpenBSD-6.3-amd64-minimal-v6.3.20180403-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-6.3-amd64-minimal-v6.3.20180403-virtualbox`
to your box list by the following command:

    vagrant box add OpenBSD-6.3-amd64-minimal-v6.3.20180403-virtualbox.box --name OpenBSD-6.3-amd64-minimal-v6.3.20180403-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso openbsd-6.3-minimal.json

You will find a vagrant box file named `OpenBSD-6.3-amd64-minimal-v6.3.20180403-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `OpenBSD-6.3-amd64-minimal-v6.3.20180403-vmawre`
to your box list by the following command:

    vagrant box add OpenBSD-6.3-amd64-minimal-v6.3.20180403-vmware.box --name OpenBSD-6.3-amd64-minimal-v6.3.20180403-vmware

In the `output` directory you will also find a VM image that can be directly
imported to VMware.


## Default settings

These default settings below are done by the file `Vagrantfile.OpenBSD-sh`
which will be included in the box.  Users can override this setting by users'
own `Vagrantfile`s.

### Synced Folder

Due to Vagrant limitation of OpenBSD support, Synced Folder of this box is
disabled by default.
You can still use other types of synced folders:

* NFS on non-Windows hosts
* RSync on any hosts.

### SSH Shell

Because Bash is not the standard shell for OpenBSD, default shell for non-
interactive SSH connection of this box is set to `/bin/sh`.

### sudo Command

Instead of `sudo`, boxes are configured to use `doas` command.


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following
environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso openbsd-6.3-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Variants

`sudo` is enabled with all variants.

* `openbsd-6.3-minimal.json` - OpenBSD 6.3
* `openbsd-6.3-ansible.json` - OpenBSD 6.3 with [Ansible][]+[Testinfra][]
* `openbsd-6.3-x11.json` - OpenBSD 6.3 with [X11][]
* `openbsd-6.3-dwm.json` - OpenBSD 6.3 with X11 + [dwm][] + [dmenu][] + [st][] + [SLiM][]
* `openbsd-6.3-xfce.json` - OpenBSD 6.3 with [Xfce][] + SLiM

While `openbsd-6.3-*.json` templates generate amd64 boxes by default, using `vars-openbsd-6.3-i386.json`
generates i386 boxes:

    packer build -var-file=vars-openbsd-6.3-i386.json openbsd-6.3-minimal.json

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[dwm]: http://dwm.suckless.org/ "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/ "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.10.2.dev3 documentation"
[X11]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"


## Build parameters

The following parameters can be set at build time by supplying `-var` or
`-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is 2.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960` which means 40GB.
* `package_server`: - URL to download packages from.  Default value is `http://cloudflare.cdn.openbsd.org/pub/OpenBSD/`.
* `vagrant_username` - User name used for run time.  Vagrant box is set for this user.  Default value is `vagrant`.
* `vagrant_password` - Password for `vagrant_username`.  Default value is `vagrant`.
* `vagrant_group` - Group name that `vagrant_username` belongs to.  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to `true`.  Default value is `false`.


- - -

Copyright &copy; 2018, 2019 Upperstream Software.
