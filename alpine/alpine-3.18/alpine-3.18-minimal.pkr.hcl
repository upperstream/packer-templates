packer {
  required_version = ">= 1.7.0"
  required_plugins {
    hyperv = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hyperv"
    }
    parallels = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/parallels"
    }
    qemu = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/qemu"
    }
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

variable "boot_wait" {
  type        = string
  default     = "30s"
  description = "Override `boot_wait` default setting, which is 30s."
}

variable "box_version" {
  type        = string
  default     = "18.12.20250213"
  description = "Version number of this Vagrant box."
}

variable "cpu" {
  type        = string
  default     = null
  description = "CPU name.  This is used as a part of box name."
}

variable "disk_size" {
  type        = string
  default     = "40960"
  description = "The size of the primary storage."
}

variable "esxi_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for ESXi box"
}

variable "esxi_guest_os_type" {
  type    = string
  default = null
}

variable "esxi_keep_registered" {
  type    = string
  default = "false"
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
  sensitive   = true
  description = "SSH password for the ESXi server to create this box."
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

variable "hyperv_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for Hyper-V box"
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Switch name for Hyper-V box."
}

variable "iso_checksum" {
  type        = string
  default     = null
  description = "SHA256 checksum of the install media."
}

variable "iso_image" {
  type        = string
  default     = null
  description = "File name of the install media."
}

variable "mem_size" {
  type        = string
  default     = "512"
  description = "Memory size of this box."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "The number of CPUs of this box."
}

variable "os_ver" {
  type    = string
  default = "3.18"
}

variable "parallels_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for Parallels box"
}

variable "qemu_disk_name" {
  type        = string
  default     = "vda"
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

variable "root_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the root user of this box.  Change the `sensitive` value to `true` if you want to hide the password."
}

variable "ssh_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "SSH password to connect this box being created."
}

variable "ssh_timeout" {
  type        = string
  default     = "1800s"
  description = "SSH timeout to connect this box being created."
}

variable "ssh_username" {
  type        = string
  default     = "root"
  description = "SSH username to connect this box being created."
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the Vagrant user of this box.  Change the `sensitive` value to `true` if you want to hide the password."
}

variable "vagrant_ssh_public_key" {
  type        = string
  default     = ""
  description = "SSH public key for Vagrant user"
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "Username for the Vagrant user of this box."
}

variable "variant" {
  type    = string
  default = "minimal"
}

variable "virtualbox_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for VirtualBox box"
}

variable "virtualbox_guest_os_type" {
  type    = string
  default = null
}

variable "vm_name" {
  type        = string
  default     = ""
  description = "Overriding VM name"
}

variable "vm_name_base" {
  type        = string
  default     = ""
  description = "Base part of default VM name"
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
  default     = "sda"
  description = "Disk name for VMware box"
}

variable "vmware_fusion_app_path" {
  type    = string
  default = "/Applications/VMware Fusion.app"
}

variable "vmware_guest_os_type" {
  type        = string
  default     = null
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

variable "vmware_usb_xhci_present" {
  type    = string
  default = "TRUE"
}

variable "vmware_vhv_enabled" {
  type        = string
  default     = "FALSE"
  description = "Enable nested virtualisation."
}

locals {
  boot_command = [
    "root<enter><wait>",
    "/sbin/setup-interfaces -i << EOF<enter>",
    "auto lo<enter>",
    "iface lo inet loopback<enter>",
    "<enter>",
    "auto eth0<enter>",
    "iface eth0 inet dhcp<enter>",
    "<tab>hostname localhost<enter>",
    "EOF<enter><wait>",
    "/etc/init.d/networking --quiet start<enter><wait10><wait10>",
    "wget -O /tmp/answers.txt http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers.txt<enter><wait>",
    "DISK=%s ERASE_DISKS=/dev/%s setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=%s sh /tmp/install.sh<enter><wait>"
  ]
  iso_urls = [
    "./iso/${var.iso_image}",
    "http://dl-cdn.alpinelinux.org/alpine/v${var.os_ver}/releases/${var.cpu}/${var.iso_image}"
  ]
  vm_name = coalesce(var.vm_name, "${var.vm_name_base}-${var.os_ver}-${var.variant}-v${var.box_version}-${var.cpu}")
}

source "hyperv-iso" "default" {
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.hyperv_disk_name, var.hyperv_disk_name, var.hyperv_disk_name
  ))
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = [
        "apk add --root=/mnt hvtools",
        "chroot /mnt sh -c \"rc-update add hv_fcopy_daemon default && \\",
        "rc-update add hv_kvp_daemon default && \\",
        "rc-update add hv_vss_daemon default\""
      ]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-hyperv"
  shutdown_command = "poweroff"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  switch_name      = var.hyperv_switch_name
  vm_name          = local.vm_name
}

source "parallels-iso" "default" {
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.parallels_disk_name, var.parallels_disk_name, var.parallels_disk_name
  ))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  disk_type            = "expand"
  guest_os_type        = "linux"
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = []
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  output_directory     = "output/${local.vm_name}-parallels"
  parallels_tools_mode = "disable"
  shutdown_command     = "poweroff"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  vm_name              = local.vm_name
}

source "qemu" "default" {
  accelerator = "kvm"
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.qemu_disk_name, var.qemu_disk_name, var.qemu_disk_name
  ))
  boot_wait           = var.boot_wait
  cpus                = var.num_cpus
  disk_interface      = "virtio"
  disk_size           = var.disk_size
  display             = var.qemu_display
  format              = "qcow2"
  headless            = var.headless
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = []
    })
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-qemu"
  shutdown_command    = "poweroff"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.ssh_username
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.virtualbox_disk_name, var.virtualbox_disk_name, var.virtualbox_disk_name
  ))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = []
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  output_directory     = "output/${local.vm_name}-virtualbox"
  shutdown_command     = "poweroff"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.vmware_disk_name, var.vmware_disk_name, var.vmware_disk_name
  ))
  boot_wait            = var.boot_wait
  cdrom_adapter_type   = var.vmware_cdrom_adapter_type
  cpus                 = var.num_cpus
  disk_adapter_type    = var.vmware_disk_adapter_type
  disk_size            = var.disk_size
  disk_type_id         = "0"
  fusion_app_path      = var.vmware_fusion_app_path
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = []
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-vmware"
  shutdown_command     = "poweroff"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  tools_upload_flavor  = ""
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = var.vmware_vhv_enabled
    "svga.autodetect"           = var.vmware_svga_autodetect
    "usb_xhci.present"          = var.vmware_usb_xhci_present
  }
}

source "vmware-iso" "esxi" {
  boot_command = split("\n", format(
    join("\n", local.boot_command), var.esxi_disk_name, var.esxi_disk_name, var.esxi_disk_name
  ))
  boot_wait               = var.boot_wait
  cpus                    = var.num_cpus
  disk_size               = var.disk_size
  disk_type_id            = "thin"
  guest_os_type           = var.esxi_guest_os_type
  headless                = var.headless
  http_content = {
    "/answers.txt" = file("${path.root}/answers.txt")
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      additional_lines = []
    })
  }
  insecure_connection     = true
  iso_checksum            = var.iso_checksum
  iso_urls                = local.iso_urls
  keep_registered         = var.esxi_keep_registered
  memory                  = var.mem_size
  network                 = "bridged"
  network_adapter_type    = "e1000"
  remote_datastore        = var.esxi_remote_datastore
  remote_host             = var.esxi_remote_host
  remote_output_directory = local.vm_name
  remote_password         = var.esxi_remote_password
  remote_type             = "esx5"
  remote_username         = var.esxi_remote_username
  shutdown_command        = "poweroff"
  skip_export             = true
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_timeout             = var.ssh_timeout
  ssh_username            = var.ssh_username
  tools_upload_flavor     = "linux"
  vm_name                 = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
  vnc_over_websocket = var.esxi_vnc_over_websocket
}

build {
  sources = [
    "source.hyperv-iso.default",
    "source.parallels-iso.default",
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    only = [
      "hyperv-iso.*"
    ]
    script = "../provisioners/hyperv.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "OS_VER=v${var.os_ver}",
      "VIRTUALBOX_GUEST_ADDITIONS=virtualbox-guest-additions=7.0.10-r1"
    ]
    only = [
      "virtualbox-iso.*"
    ]
    script = "../provisioners/virtualbox_alpine3.13+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "CPU=${var.cpu}",
      "OPEN_VM_TOOLS=open-vm-tools=12.3.0-r0",
      "OS_VER=v${var.os_ver}"
    ]
    only = [
      "vmware-iso.*"
    ]
    script = "../provisioners/vmware_alpine3.9+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "NFS_UTILS=nfs-utils=2.6.3-r1",
      "UTIL_LINUX=util-linux=2.38.1-r8"
    ]
    only = [
      "qemu.default"
    ]
    script = "../provisioners/nfs.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "SUDO_CMD=doas",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "VAGRANT_SSH_PUBLIC_KEY=${var.vagrant_ssh_public_key}",
      "VAGRANT_USERNAME=${var.vagrant_username}"
    ]
    script = "../provisioners/vagrant_alpine3.15+.sh"
  }

  provisioner "shell" {
    only = [
      "parallels-iso.default",
      "qemu.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    script              = "../provisioners/disk_cleanup.sh"
    start_retry_timeout = "5m"
  }

  provisioner "shell" {
    script = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default",
      "parallels-iso.default"
    ]
    output               = "${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.Alpine3.15+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.Alpine3.15+"
  }
}
