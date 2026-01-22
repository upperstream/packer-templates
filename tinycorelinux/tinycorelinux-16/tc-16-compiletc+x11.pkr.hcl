packer {
  required_version = ">= 1.7.0"
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.1.0"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.1.4"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.0.5"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = ">= 1.0.11"
    }
  }
}

variable "boot_wait" {
  type        = string
  default     = "5s"
  description = "Override `boot_wait` default setting, which is 5s."
}

variable "box_version" {
  type        = string
  default     = "16.2.20250929"
  description = "Version number of this Vagrant box."
}

variable "cpu" {
  type        = string
  default     = ""
  description = "CPU name.  This is used as a part of box name."
}

variable "disk_size" {
  type        = string
  default     = ""
  description = "The size of the primary storage."
}

variable "esxi_hardware_version" {
  type        = number
  default     = 19
  description = "Virtual hardware version of ESXi box."
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

variable "esxi_vhv_enabled" {
  type        = string
  default     = "TRUE"
  description = "Enable nested virtualisation."
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

variable "iso_checksum" {
  type        = string
  default     = ""
  description = "MD5 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = ""
  description = "File name of the install media."
}

variable "kernel_image" {
  type        = string
  default     = ""
  description = "Kernel image name"
}

variable "mem_size" {
  type        = string
  default     = ""
  description = "Memory size of this box."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "The number of CPUs of this box."
}

variable "os_name" {
  type    = string
  default = ""
}

variable "qemu_binary" {
  type        = string
  default     = "qemu-system-x86_64"
  description = "Name of QEMU binary"
}

variable "qemu_disk" {
  type        = string
  default     = "vda"
  description = "Disk name for QEMU box."
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

variable "os_ver" {
  type    = string
  default = ""
}

variable "ramdisk" {
  type        = string
  default     = ""
  description = "Ramdisk file name"
}

variable "ssh_password" {
  type        = string
  default     = ""
  description = "SSH password to connect this box being created."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "ssh_username" {
  type        = string
  default     = "tc"
  description = "SSH username to connect this box being created."
}

variable "variant" {
  type    = string
  default = "compiletc+x11"
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = ""
  description = "Guest OS type of VirtualBox box."
}

variable "virtualbox_disk" {
  type        = string
  default     = "sda"
  description = "Disk name for VirtualBox box."
}
variable "vm_name" {
  type        = string
  default     = null
  description = "Overriding VM name."
}

variable "vm_name_base" {
  type        = string
  default     = null
  description = "Base name of this VM image."
}

variable "vmware_disk_adapter_type" {
  type        = string
  default     = "sata"
  description = "Disk adapter type for VMware box."
}

variable "vmware_guest_os_type" {
  type        = string
  default     = ""
  description = "Guest OS type of VMware box."
}

variable "vmware_disk" {
  type    = string
  default = "sda"
}

variable "vmware_hardware_version" {
  type        = number
  default     = 19
  description = "Hardware version for VMware box."
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
    "<enter><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "GRUB_ENTRY_NAME='${var.os_name} ${var.os_ver}' sh -x /tmp/install.sh<enter><wait>"
  ]
  disk = {
    "qemu" : var.qemu_disk
    "virtualbox" : var.virtualbox_disk
    "vmware" : var.vmware_disk
  }
  iso_urls = [
    "./iso/${var.iso_name}",
    "http://tinycorelinux.net/16.x/${var.cpu}/release/${var.iso_name}"
  ]
  vm_name = coalesce(var.vm_name, "${var.vm_name_base}-${var.variant}-v${var.box_version}")
}

source "qemu" "default" {
  accelerator      = "kvm"
  boot_command     = local.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_compression = true
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  display          = var.qemu_display
  format           = "qcow2"
  headless         = var.headless
  http_content = {
    "/install.sh" = templatefile("../http/install.sh.pkrtpl.hcl",
      {
        disk         = var.qemu_disk,
        kernel_image = var.kernel_image,
        ramdisk      = var.ramdisk
      }
    )
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-qemu"
  qemu_binary         = var.qemu_binary
  shutdown_command    = "sudo filetool.sh -b; sudo poweroff"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.ssh_username
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command         = local.boot_command
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/install.sh" = templatefile("../http/install.sh.pkrtpl.hcl",
      {
        disk         = var.virtualbox_disk,
        kernel_image = var.kernel_image,
        ramdisk      = var.ramdisk
      }
    )
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-virtualbox"
  shutdown_command = "sudo filetool.sh -b; sudo poweroff"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--nictype1", "virtio"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--vram", "32"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command      = local.boot_command
  boot_wait         = var.boot_wait
  cpus              = var.num_cpus
  disk_adapter_type = var.vmware_disk_adapter_type
  disk_size         = var.disk_size
  disk_type_id      = "0"
  guest_os_type     = var.vmware_guest_os_type
  headless          = var.headless
  http_content = {
    "/install.sh" = templatefile("../http/install.sh.pkrtpl.hcl",
      {
        disk         = var.vmware_disk,
        kernel_image = var.kernel_image,
        ramdisk      = var.ramdisk
      }
    )
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "nat"
  network_adapter_type = "e1000"
  output_directory     = "output/${local.vm_name}-vmware"
  shutdown_command     = "sudo filetool.sh -b; sudo poweroff"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmdk_name            = "disk"
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
  boot_command      = local.boot_command
  boot_wait         = var.boot_wait
  cpus              = var.num_cpus
  disk_adapter_type = var.vmware_disk_adapter_type
  disk_size         = var.disk_size
  disk_type_id      = "thin"
  guest_os_type     = var.vmware_guest_os_type
  headless          = var.headless
  http_content = {
    "/install.sh" = templatefile("../http/install.sh.pkrtpl.hcl",
      {
        disk         = var.vmware_disk,
        kernel_image = var.kernel_image,
        ramdisk      = var.ramdisk
      }
    )
  }
  insecure_connection     = true
  iso_checksum            = var.iso_checksum
  iso_urls                = local.iso_urls
  memory                  = var.mem_size
  network                 = "bridged"
  network_adapter_type    = "e1000"
  remote_datastore        = var.esxi_remote_datastore
  remote_host             = var.esxi_remote_host
  remote_output_directory = local.vm_name
  remote_password         = var.esxi_remote_password
  remote_type             = "esx5"
  remote_username         = var.esxi_remote_username
  shutdown_command        = "sudo filetool.sh -b; sudo poweroff"
  skip_export             = true
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_timeout             = var.ssh_timeout
  ssh_username            = var.ssh_username
  version                 = var.esxi_hardware_version
  vm_name                 = local.vm_name
  vmdk_name               = "disk"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "33554432"
    "vhv.enable"                = var.esxi_vhv_enabled
  }
  vnc_disable_password = true
  vnc_over_websocket   = var.esxi_vnc_over_websocket
}

build {
  sources = [
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools-desktop"
    ]
    script = "../provisioners/vmware_tc16.sh"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "DISK=${local.disk[replace(source.type, "-iso", "")]}",
      "LINUX_API=6.12"
    ]
    scripts = [
      "../provisioners/compiletc_tc16.sh",
      "../provisioners/x11.sh",
      "../provisioners/vagrant.sh",
      "../provisioners/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    compression_level = "9"
    only = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "./${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.tc16"
  }

  post-processor "vagrant" {
    keep_input_artifact  = true
    compression_level    = 9
    only                 = ["qemu.default"]
    output               = "./${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.tc16"
  }
}
