# Packer templates for Tiny Core Linux v8.2.1

Templates to create Vagrant boxes for Tiny Core Linux v8.2.1. (x86_64
and x86)


## Prerequisites

* [Packer][] v1.1.0+
* [Vagrant][] v1.9.8+
* [VirtualBox][] v5.1.30+
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

* sshd
* sudo
* NFS (installed but not enabled)
* `tc` user as a Vagrant user and its insecure public key


## How to create a box

### VirtualBox

From the terminal, invoke the following command for VirtualBox provider:

    packer build -only=virtualbox-iso -var-file=vars-corepure64-8.json tc-8-minimal.json

You will find a vagrant box file named `CorePure64-8-minimal-v8.2.20171113-virtualbox.box`
in the same directory after the command has succeeded.

Then you can add the box named `CorePure64-8-minimal-v8.2.20171113-virtualbox`
to your box list by the following command:

    vagrant box add CorePure64-8-minimal-v8.2.20171113-virtualbox.box --name CorePure64-8-minimal-v8.2.20171113-virtualbox

### VMware

From the terminal, invoke the following command for VMware provider:

    packer build -only=vmware-iso -var-file=vars-corepure64-8.json tc-8-minimal.json

You will find a vagrant box file named `CorePure64-8-minimal-v8.2.20171113-vmware.box`
in the same directory after the command has succeeded.

Then you can add the box named `CorePure64-8-minimal-v8.2.20171113-vmware`
to your box list by the following command:

    vagrant box add CorePure64-8-minimal-v8.2.20171113-vmware.box --name CorePure64-8-minimal-v8.2.20171113-vmware

In the `output` directory you will also find a VM image that can be
directly imported from VMware.


## Default settings

These default settings are done by the file `Vagrantfile.tc` which will
be included in the box.  Users can override this setting by users' own
`Vagrantfile`s.

### Synced Folder

Due to limitation of VirtualBox's support for Tiny Core Linux support,
Synced Folder of this box is disabled by default.

### SSH Shell

Because Bash is not the standard shell for Tiny Core Linux, default
shell for SSH connection of this box is set to `/bin/ash`.

### SSH User

Since `tc` is the default user of Tiny Core Linux, this box is
configured that `tc` is a Vagrant user by default.


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

    packer build -only=esxi-iso -var-file=vars-corepure64-8.json tc-8-minimal.json

(Note that created VM will be unregistered from your Inventory.)


## Variants

* x86_64
    * `packer build -var-file=vars-corepure64-8.json tc-8-minimal.json`:
      CorePure 64 v8.2.1 (x86_64)
    * `packer build -var-file=vars-corepure64-8.json tc-8-compiletc.json`:
      CorePure 64 v8.2.1 (x86_64) with build tools
    * `packer build -var-file=vars-tinycorepure64-8.json tc-8-x11.json`:
      TinyCorePure 64 v8.2.1 (x86_64)
    * `packer build -var-file=vars-tinycorepure64-8.json tc-8-compiletc+x11.json`:
      TinyCorePure 64 v8.2.1 (x86_64) with build tools
* x86
    * `packer build -var-file=vars-core-8.json tc-8.json-minimal.json`:
      Core v8.2.1 (x86)
    * `packer build -var-file=vars-core-8.json tc-8.json-compiletc.json`:
      Core v8.2.1 (x86) with build tools
    * `packer build -var-file=vars-tinycore-8.json tc-8.json-x11.json`:
      TinyCore v8.2.1 (x86)
    * `packer build -var-file=vars-tinycore-8.json tc-8.json-compiletc+x11.json`:
      TinyCore v8.2.1 (x86) with build tools

Executing `build_all.sh` (or `build_all.bat`) generates all boxes above.


## Build parameters

The following parameters can be set at build time by supplying `-var`
or `-var-file` command line options to `packer`:

* `vm_name` - VM name.  This also affects box file name and output
  directory name.
* `num_cpus` - Number of virtual CPUs.  Default value is `2`.
* `mem_size` - RAM size of the created VM.  Default value is `512`
  which means 512MB.
* `disk_size` - Disk size of the created VM.  Default value is `40960`
  which means 40GB.
* `headless` - Launch the virtual machine in headless mode if set to
  `true`.  Default value is `false`.


- - -

Copyright &copy; 2017, 2018 Upperstream Software.
