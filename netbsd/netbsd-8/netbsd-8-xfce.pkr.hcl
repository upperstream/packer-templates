packer {
  required_version = ">= 1.7.0"
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = ">= 1.0.0"
    }
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.0.10"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.1.0"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.0.0"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = ">= 1.0.11"
    }
  }
}

variable "arch" {
  type    = string
  default = "amd64"
}

variable "boot_wait" {
  type        = string
  default     = "10s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_version" {
  type        = string
  default     = "8.3.20240504"
  description = "Version number of this Vagrant box."
}

variable "disk_size" {
  type        = string
  default     = "40960"
  description = "The size of the primary storage."
}

variable "dist_server" {
  type    = string
  default = "http://cdn.netbsd.org"
}

variable "esxi_disk_name" {
  type    = string
  default = "sd0"
}

variable "esxi_remote_datastore" {
  type        = string
  default     = "${env("ESXI_REMOTE_DATASTORE")}"
  description = "ESXi datastore name to create this box in."
}

variable "esxi_remote_host" {
  type        = string
  default     = "${env("ESXI_REMOTE_HOST")}"
  description = "Remote host name of the ESXi server to create this box on."
}

variable "esxi_remote_password" {
  type        = string
  default     = "${env("ESXI_REMOTE_PASSWORD")}"
  description = "SSH password for the ESXi server to create this box."
}

variable "esxi_remote_port" {
  type        = string
  default     = "${env("ESXI_REMOTE_PORT")}"
  description = "SSH port number for the ESXi server to connect."
}

variable "esxi_remote_username" {
  type        = string
  default     = "${env("ESXI_REMOTE_USERNAME")}"
  description = "SSH username for the ESXi server to create this box."
}

variable "esxi_vnc_over_websocket" {
  type        = string
  default     = "true"
  description = "Connect VNC server over a websocket for building ESXi box."
}

variable "headless" {
  type        = string
  default     = "false"
  description = "VM window is not displayed if false."
}

variable "hostname" {
  type    = string
  default = "vagrant"
}

variable "hyperv_disk_name" {
  type        = string
  default     = "sd0"
  description = "Disk name for Hyper-V box"
}

variable "hyperv_gateway" {
  type        = string
  default     = "192.168.1.1"
  description = "IP address of the gateway and the name server for the VM being built with Hyper-V builder"
}

variable "hyperv_host_cidr" {
  type        = string
  default     = "192.168.1.2/24"
  description = "CIDR notation of the VM IP address being built with Hyper-V builder"
}

variable "hyperv_netif" {
  type        = string
  default     = "hvn0"
  description = "Network interface name of the VM being build with Hyper-V builder"
}

variable "hyperv_ssh_host" {
  type        = string
  default     = "192.168.1.2"
  description = "IP address of the VM being built with Hyper-V builder"
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Network switch name on Hyper-V builder"
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.3/iso/SHA512"
  description = "SHA256 checksum of the install media."
}

variable "iso_file_name" {
  type        = string
  default     = "NetBSD-8.3-amd64.iso"
  description = "File name of the install media."
}

variable "iso_path" {
  type        = string
  default     = "NetBSD/NetBSD-8.3/images"
  description = "Relative path to search the install media."
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
}

variable "mem_size" {
  type        = string
  default     = "2048"
  description = "Memory size of this box."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "The number of CPUs of this box."
}

variable "os_ver" {
  type    = string
  default = "8.3"
}

variable "package_arch" {
  type        = string
  default     = "amd64"
  description = "Architecture name for binary packages."
}

variable "package_branch" {
  type        = string
  default     = "8.0_2022Q3"
  description = "pkgsrc branch name for binary packages."
}

variable "package_server" {
  type    = string
  default = "http://nyftp.netbsd.org"
}

variable "qemu_accelerator" {
  type        = string
  default     = "kvm"
  description = "QEMU accelerator name for QEMU box."
}

variable "qemu_binary" {
  type    = string
  default = "qemu-system-x86_64"
}

variable "qemu_disk_name" {
  type        = string
  default     = "sd0"
  description = "Disk name for QEMU box"
}

variable "qemu_display" {
  type        = string
  default     = ""
  description = "Display name for QEMU box."
}

variable "qemu_use_default_display" {
  type        = string
  default     = "true"
  description = "Use the default display for QEMU box if true."
}

variable "ssh_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "SSH password to connect this box being created.  Change the `sensitive` value to `true` if you want to hide the password."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "ssh_username" {
  type        = string
  default     = "root"
  description = "SSH username to connect this box being created."
}

variable "vagrant_group" {
  type    = string
  default = "vagrant"
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the Vagrant user of this box.  Change the `sensitive` value to `true` if you want to hide the password."
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "Username for the Vagrant user of this box."
}

variable "virtualbox_disk_name" {
  type        = string
  default     = "wd0"
  description = "Disk name for VirtualBox box"
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "NetBSD_64"
  description = "Guest OS type of VirtualBox box."
}

variable "vm_name" {
  type        = string
  default     = null
  description = "Overriding VM name"
}

variable "vmware_cdrom_adapter_type" {
  type        = string
  default     = "ide"
  description = "CD-ROM adapter type for VMware box."
}

variable "vmware_disk_adapter_type" {
  type        = string
  default     = "scsi"
  description = "Disk adapter type for VMware box."
}

variable "vmware_disk_name" {
  type        = string
  default     = "sd0"
  description = "Disk name for VMware box"
}

variable "vmware_guest_os_type" {
  type        = string
  default     = "other-64"
  description = "Guest OS type of VMware box."
}

variable "vmware_hardware_version" {
  type        = string
  default     = "9"
  description = "Virtual hardware version of VMware box."
}

variable "vmware_network" {
  type        = string
  default     = "nat"
  description = "Network type of VMware box.  This does not affect network for ESXi box."
}

variable "vmware_network_adapter_type" {
  type        = string
  default     = "e1000"
  description = "Network adapter type for VMware box."
}

variable "vmware_svga_autodetect" {
  type    = string
  default = "TRUE"
}

variable "vmware_vhv_enabled" {
  type        = string
  default     = "FALSE"
  description = "Enable nested virtualisation."
}

locals {
  boot_command_common = [
    "1<wait10><wait10><wait5>",                                 # Welcome message
    "a<enter><wait>",                                           # Installation messages in English
    "a<enter><wait>",                                           # Keyboard type - unchanged
    "a<enter><wait>",                                           # NetBSD-8.3 Install System - Install NewtBSD to hard disk
    "b<enter><wait>",                                           # Shall we continue? - Yes
    "a<enter><wait>",                                           # Available disks - sd0
    "a<enter><wait>",                                           # This disk matches the following BIOS disk - This is the correct geometry
    "b<enter><wait>",                                           # We are going to install NetBSD o the disk sd0 - Use the entire disk
    "a<enter><wait>",                                           # Do you want to install the NetBSD bootcode? - Yes
    "b<enter><wait>",                                           # Choose your installation - Use the existing partition sizes
    "x<enter><wait>",                                           # Review partition sizes - Partition sizes ok
    "<enter><wait>",                                            # Please enter a name for your NetBSD disk - Hit enter to continue with default name
    "b<enter><wait10><wait10><wait10><wait10>",                 # Shall we continue? - Yes
    "a<enter><wait>x<enter><wait>",                             # Select bootblocks - Use BIOS console
    "d<enter><wait>",                                           # Select distribution - Custom installation
    "${local.selector_compiler_tools[var.arch]}",               # Distribution sets - Compiler tools - e (i386: e)
    "${local.selector_manual_pages[var.arch]}",                 # Distribution sets - Manual pages - g (i386: g)
    "${local.selector_text_processors[var.arch]}",              # Distribution sets - Text processing tools - j (i386: j)
    "${local.selector_x11[var.arch]}",                          # Distribution sets - X11 sets - k (i386: k)
    "f<enter><wait>",                                           # Distribution sets - X11 sets - Select all the above sets
    "b<enter><wait>",                                           # Distribution sets - X11 sets - but X11 programming
    "x<enter><wait>",                                           # Distribution sets - X11 sets - Install selected X11 sets
    "x<enter><wait>",                                           # Distribution sets - Install selected sets
    "a<enter><wait10><wait10><wait10><wait10><wait10><wait10>", # Install from - CD-ROM
    "<wait10>",                                                 # Wait for installation
    "<enter><wait5>",                                           # Installation complete - Hit enter to continue
    "d<enter><wait>",                                           # Change root password
    "a<enter><wait>",                                           # Do you want to set a root password for the system now? - Yes
    "${var.ssh_password}<enter><wait>",                         # New password - root password
    "${var.ssh_password}<enter><wait>",                         # Weak password warning - root password
    "${var.ssh_password}<enter><wait5>",                        # Retype new password - root password
    "g<enter><wait>",                                           # Configure the additional items - Enable sshd
    "h<enter><wait>",                                           # Configure the additional items - Enable ntpd
    "k<enter><wait>",                                           # Configure the additional items - Enable xdm
    "x<enter><wait>",                                           # Configure the additional items - Finished configuring
    "<enter><wait10>",                                          # Hit enter to continue
    "x<enter><wait10>",                                         # Exit Install System
  ]
  install_script_common = [
    "dhcpcd<wait><enter><wait10><wait5>",
    "ftp -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<wait><enter><wait5>",
    "HTTPSERVER={{ .HTTPIP }}:{{ .HTTPPort }} PARTITION=%sa HOSTNAME=${var.hostname} sh /tmp/install.sh<wait><enter><wait5>"
  ]
  iso_urls = compact([
    var.iso_url,
    "./iso/${var.iso_file_name}",
    "${var.dist_server}/pub/${var.iso_path}/${var.iso_file_name}"
  ])
  selector_compiler_tools = {
    "amd64" : "e<enter><wait>",
    "i386" : "e<enter><wait>"
  }
  selector_manual_pages = {
    "amd64" : "g<enter><wait>",
    "i386" : "g<enter><wait>"
  }
  selector_text_processors = {
    "amd64" : "j<enter><wait>",
    "i386" : "j<enter><wait>"
  }
  selector_x11 = {
    "amd64" : "k<enter><wait>",
    "i386" : "k<enter><wait>"
  }
  selector_install_script = {
    "generic" : [
      "cat >> /mnt/etc/rc.conf << EOF",
      "#critical_filesystems_local=/var",
      "dhcpcd=YES",
      "rpcbind=YES",
      "#nfs_client=YES",
      "no_swap=YES",
      "lockd=YES",
      "statd=YES",
      "hostname=\"$HOSTNAME\"",
      "EOF",
    ],
    "hyperv" : [
      "cat >> /mnt/etc/rc.conf << EOF",
      "#critical_filesystems_local=/var",
      "dhcpcd=YES",
      "rpcbind=YES",
      "#nfs_client=YES",
      "no_swap=YES",
      "lockd=YES",
      "statd=YES",
      "hostname=$HOSTNAME",
      "ifconfig_$NETIF=\"inet $HOST_CIDR\"",
      "defaultroute=$GATEWAY",
      "EOF",
      "echo \"nameserver $GATEWAY\" > /mnt/etc/resolv.conf"
    ]
  }
  vm_name = coalesce(var.vm_name, "NetBSD-8-${var.arch}-xfce")
}

source "hyperv-iso" "default" {
  boot_command = concat(local.boot_command_common, [
    "ifconfig ${var.hyperv_netif} inet ${var.hyperv_host_cidr}<enter><wait5>",
    "ifconfig ${var.hyperv_netif} up<enter><wait10>",
    "ftp -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<wait><enter><wait5>",
    "HTTPSERVER={{ .HTTPIP }}:{{ .HTTPPort }} PARTITION=${var.hyperv_disk_name}a HOSTNAME=${var.hostname} HOST_CIDR=${var.hyperv_host_cidr} GATEWAY=${var.hyperv_gateway} NETIF=${var.hyperv_netif} sh /tmp/install.sh<wait><enter><wait5>"
  ])
  boot_wait = var.boot_wait
  cpus      = var.num_cpus
  disk_size = var.disk_size
  headless  = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["hyperv"]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-hyperv"
  shutdown_command = "/sbin/shutdown -p now"
  ssh_host         = var.hyperv_ssh_host
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  switch_name      = var.hyperv_switch_name
  vm_name          = local.vm_name
}

source "qemu" "default" {
  accelerator = var.qemu_accelerator
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.qemu_disk_name))
  )
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_compression = true
  disk_interface   = "virtio-scsi"
  disk_size        = var.disk_size
  display          = var.qemu_display
  format           = "qcow2"
  headless         = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["generic"]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  net_device       = "virtio-net-pci"
  output_directory = "output/${local.vm_name}-v${var.box_version}-qemu"
  qemu_binary      = var.qemu_binary
  qemuargs = [
    ["-smp", "cpus=1,maxcpus=${var.num_cpus},threads=${var.num_cpus}"],
    ["-display", "gtk"]
  ]
  shutdown_command    = "/sbin/shutdown -p now"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.ssh_username
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.virtualbox_disk_name))
  )
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["generic"]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-virtualbox"
  shutdown_command = "/sbin/shutdown -p now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--natdnsproxy1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.vmware_disk_name))
  )
  boot_wait          = var.boot_wait
  cdrom_adapter_type = var.vmware_cdrom_adapter_type
  cpus               = var.num_cpus
  disk_adapter_type  = var.vmware_disk_adapter_type
  disk_size          = var.disk_size
  disk_type_id       = "0"
  guest_os_type      = var.vmware_guest_os_type
  headless           = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["generic"]
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-v${var.box_version}-vmware"
  shutdown_command     = "/sbin/shutdown -p now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
}

source "vmware-iso" "esxi" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.esxi_disk_name))
  )
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type_id  = "thin"
  guest_os_type = var.vmware_guest_os_type
  headless      = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["generic"]
    })
  }
  insecure_connection  = true
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "bridged"
  network_adapter_type = "e1000"
  output_directory     = "${local.vm_name}-v${var.box_version}"
  remote_datastore     = var.esxi_remote_datastore
  remote_host          = var.esxi_remote_host
  remote_password      = var.esxi_remote_password
  remote_type          = "esx5"
  remote_username      = var.esxi_remote_username
  shutdown_command     = "/sbin/shutdown -p now"
  skip_export          = true
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
  vnc_disable_password = true
  vnc_over_websocket   = var.esxi_vnc_over_websocket
}

build {
  sources = [
    "source.hyperv-iso.default",
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    inline = [
      "echo \"PKG_PATH=${var.package_server}/pub/pkgsrc/packages/NetBSD/${var.package_arch}/${var.package_branch}/All\" > /etc/pkg_install.conf"
    ]
    inline_shebang = "/bin/sh -ex"
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools-11.3.5nb4"
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} PATH=$PATH:/usr/sbin {{ .Path }}"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmware-xorg_netbsd8+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "DOAS=doas-6.3p2nb1",
      "FAM=fam-2.7.0nb9",
      "HAL=hal-0.5.14nb30",
      "RSYNC=rsync-3.2.6",
      "VAGRANT_GROUP=${var.vagrant_group}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "VAGRANT_USER=${var.vagrant_username}",
      "X11VNC=x11vnc-0.9.16nb11",
      "XRANDR=xrandr-1.5.1",
      "XFCE4=xfce4-4.16.0nb7"
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} PATH=$PATH:/usr/sbin {{ .Path }}"
    scripts = [
      "../provisioners/vagrant_netbsd8+.sh",
      "../provisioners/xfce_netbsd8.2+.sh"
    ]
  }

  provisioner "shell" {
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "ENABLE_DHCP=yes"
    ]
    script = "../provisioners/finalise.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.NetBSD-8.3+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.NetBSD-8.3+"
  }
}
