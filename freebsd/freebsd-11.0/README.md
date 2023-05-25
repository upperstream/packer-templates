# Packer templates for FreeBSD 11.0-RELEASE

Templates to create Vagrant boxes for FreeBSD 11.0-RELEASE (amd64 and i386).


## Prerequisites

* [Packer][] v0.8.6+
* [Vagrant][] v1.7.2+
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

* curl
* sshd
* sudo
* rsync
* `vagrant` user and its insecure public key
* NFS client enabled
* ntpd enabled


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-minimal.json

You will find a vagrant box file named `FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox` to your box list
by the following command:

    vagrant box add FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox.box --name FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-minimal.json

You will find a vagrant box file named `FreeBSD-11.0-RELEASE-amd64-v11.0.20170904-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox` to your box list
by the following command:

    vagrant box add FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox.box --name FreeBSD-11.0-RELEASE-amd64-minimal-v11.0.20170904-virtualbox

In the `output` directory you will also find a VM image that can be directly imported from VMware.


## Default settings

These default settings are done by the file `Vagrantfile.FreeBSD-11+` which will be included in the box.
Users can override this setting by users' own `Vagrantfile`s.

### Synced Folder

Due to Vagrant limitation for FreeBSD guest, VirtualBox Synced Folder is disabled by default.
You can still use other types of synced folders:

* NFS on non-Windows hosts
* RSync on any hosts.

SMB synced folder is not supported for FreeBSD guest.

### SSH Shell

Because Bash is not the standard shell for FreeBSD, default shell for SSH connection of this box
is set to `/bin/sh`.


## Building a VM image on ESXi

In order to build a VM image on ESXi, you need to provide the following environment variables:

* `REMOTE_HOST` - ESXi host name or IP address
* `REMOTE_USERNAME` - ESXi login user name
* `REMOTE_PASSWORD` - ESXi login password
* `REMOTE_DATASTORE` - ESXi datastore name where a VM image will be created

You also have to enable SSH and VNC on ESXi host.

The following command will build a VM image on your ESXi:

    packer build -only=esxi-iso -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Variants

* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-minimal.json` - FreeBSD 11.0-RELEASE (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-ansible.json` - FreeBSD 11.0-RELEASE + [Ansible][] + [Testinfra][] (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-docker.json` - FreeBSD 11.0-RELEASE + [Docker][] + [Docker Compose][] (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-x11.json` - FreeBSD 11.0-RELEASE + [X.Org][] (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-dwm.json` - FreeBSD 11.0-RELEASE + X.Org + [dwm][] + [dmenu][] + [st][] + [SLiM][] (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-xfce.json` - FreeBSD 11.0-RELEASE + [Xfce][] + [SLiM][] (amd64)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-zfs.json` - FreeBSD 11.0-RELEASE on ZFS root file system (amd64)
* `packer build -var-file=vars-freebsd-11-i386.json freebsd-11.0-release-minimal.json` - FreeBSD 11.0-RELEASE (i386)
* `packer build -var-file=vars-freebsd-11-i386.json freebsd-11.0-release-ansible.json` - FreeBSD 11.0-RELEASE + Ansible + Testinfra (i386)
* `packer build -var-file=vars-freebsd-11-i386.json freebsd-11.0-release-x11.json` - FreeBSD 11.0-RELEASE + X.Org (i386)
* `packer build -var-file=vars-freebsd-11-amd64.json freebsd-11.0-release-dwm.json` - FreeBSD 11.0-RELEASE + X.Org + dwm + dmenu + st + SLiM (i386)
* `packer build -var-file=vars-freebsd-11-i386.json freebsd-11.0-release-xfce.json` - FreeBSD 11.0-RELEASE + Xfce (i386)
* `packer build -var-file=vars-freebsd-11-i386.json freebsd-11.0-release-zfs.json` - FreeBSD 11.0-RELEASE on ZFS root file system (i386)

[Ansible]: https://www.ansible.com/ "Ansible is Simple IT Automation"
[dmenu]: http://tools.suckless.org/dmenu/ "dmenu | suckless.org tools"
[Docker]: https://www.docker.com/ "Docker - Build, Ship and Run Any App, Anywhere"
[Docker Compose]: https://docs.docker.com/compose/ "Docker Compose - Docker Documentation"
[dwm]: http://dwm.suckless.org/ "suckless.org dwm - dynamic window manager"
[SLiM]: https://sourceforge.net/projects/slim.berlios/ "SLiM download | SourceForge.net"
[st]: http://st.suckless.org/ "suckless.org st - simple terminal"
[Testinfra]: https://testinfra.readthedocs.io/en/latest/ "Testinfra test your infrastructure &mdash; testinfra 1.4.2 documentation"
[X.Org]: https://www.x.org/wiki/ "X.Org"
[Xfce]: http://www.xfce.org/ "Xfce Desktop Environment"


## Build parameters

The following parameters can be set at build time by supplying `-var` or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is `2`.
* `mem_size` - RAM size of the created VM.  Default value is `512` which means 1GB.
* `disk_size` - Disk size of the created VM.  Default value is `40960` which means 50GB.
* `root_password` - Password for `root` user.  Default value is `vagrant`.
* `vagrant_username` - User name used for run time.  Vagrant box is set for this user.  Default value is `vagrant`.
  This is also used for SSH user name during build time.
* `vagrant_password` - Password for `vagrant_username`.  Default value is `vagrant`.
  This is also used for SSH password during build time.
* `vagrant_group` - Group name that `vagrant_username` belongs to.  Default value is `vagrant`.
* `headless` - Launch the virtual machine in headless mode if set to `true`.  Default value is `false`.


- - -

Copyright &copy; 2016, 2017 Upperstream Software.
