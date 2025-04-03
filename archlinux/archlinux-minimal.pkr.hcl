packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = ">= 1.1.3"
    }
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

variable "arch" {
  type        = string
  default     = "x86_64"
  description = "Architecture of this box."
}

variable "boot_wait" {
  type        = string
  default     = "10s"
  description = "Override `boot_wait` default setting, which is 10s."
}

variable "box_version" {
  type        = string
  default     = "20250401.0"
  description = "Version number of this Vagrant box."
}

variable "disk_size" {
  type        = string
  default     = "40960"
  description = "The size of the primary storage."
}

variable "esxi_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for ESXi box."
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
  default = ""
}

variable "hyperv_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for Hyper-V box."
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Switch name for Hyper-V box."
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://geo.mirror.pkgbuild.com/iso/2025.04.01/sha256sums.txt"
  description = "SHA256 checksum of the install media."
}

variable "iso_image" {
  type        = string
  default     = "archlinux-2025.04.01-x86_64.iso"
  description = "File name of the install media."
}

variable "iso_path" {
  type        = string
  default     = "iso/2025.04.01"
  description = "Relative path to search the install media."
}

variable "mem_size" {
  type        = string
  default     = "1024"
  description = "Memory size of this box."
}

variable "mirror_site" {
  type    = string
  default = "https://geo.mirror.pkgbuild.com"
  description = "Mirror site to download the install media and packages."
}

variable "num_cpus" {
  type    = string
  default = "2"
  description = "Number of virtual CPUs of this box."
}

variable "qemu_accelerator" {
  type        = string
  default     = "kvm"
  description = "QEMU accelerator name for QEMU box."
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

variable "root_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the root user of this box."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "vagrant_group" {
  type    = string
  default = "vagrant"
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the Vagrant user of this box."
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "Username for the Vagrant user of this box."
}

variable "virtualbox_disk_name" {
  type        = string
  default     = "sda"
  description = "Disk name for VirtualBox box."
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "ArchLinux_64"
  description = "Guest OS type of VirtualBox box."
}

variable "vm_name" {
  type        = string
  default     = null
  description = "Overriding VM name"
}

variable "vmware_disk" {
  type        = string
  default     = "sda"
  description = "Disk name for VMware box."
}

variable "vmware_disk_adapter_type" {
  type        = string
  default     = "scsi"
  description = "Disk adapter type for VMware box."
}

variable "vmware_guest_os_type" {
  type        = string
  default     = "otherlinux-64"
  description = "Guest OS type of VMware box."
}

variable "vmware_hardware_version" {
  type        = string
  default     = "9"
  description = "Hardware version for VMware box."
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
    "<enter><wait>",
    "<wait10><wait10><wait10><wait10><wait10>",
    "curl -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "curl -o /tmp/install-chrooted.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install-chrooted.sh<enter><wait>",
    "sh -ex /tmp/install.sh<enter>"
  ]
  iso_urls = [
    "iso/${var.iso_image}",
    "${var.mirror_site}/${var.iso_path}/${var.iso_image}"
  ]
  vm_name = coalesce(var.vm_name, "ArchLinux-minimal-v${var.box_version}-${var.arch}")
}

source "hyperv-iso" "default" {
  boot_command = local.boot_command
  boot_wait    = var.boot_wait
  cpus         = var.num_cpus
  disk_size    = var.disk_size
  headless     = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      variables = {
        DISK      = var.hyperv_disk_name
        MIRROR    = "${var.mirror_site}/\\$repo/os/\\$arch"
        SWAP_SIZE = "500M"
      }
    }),
    "/install-chrooted.sh" = templatefile("${path.root}/install-chrooted.sh.pkrtpl.hcl", {
      variables = {
        CONFIG_HYPERV_GUEST = "yes"
        DISK                = var.hyperv_disk_name
        ROOT_PASSWORD       = var.root_password
        VAGRANT_GROUP       = var.vagrant_group
        VAGRANT_HOSTNAME    = var.hostname
        VAGRANT_PASSWORD    = var.vagrant_password
        VAGRANT_USERNAME    = var.vagrant_username
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-hyperv"
  shutdown_command = "sudo /sbin/shutdown -h now"
  ssh_password     = var.vagrant_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.vagrant_username
  switch_name      = var.hyperv_switch_name
  vm_name          = "${local.vm_name}"
}

source "qemu" "default" {
  accelerator      = var.qemu_accelerator
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
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      variables = {
        DISK      = var.qemu_disk
        MIRROR    = "${var.mirror_site}/\\$repo/os/\\$arch"
        SWAP_SIZE = "500M"
      }
    }),
    "/install-chrooted.sh" = templatefile("${path.root}/install-chrooted.sh.pkrtpl.hcl", {
      variables = {
        DISK             = var.qemu_disk
        ROOT_PASSWORD    = var.root_password
        VAGRANT_GROUP    = var.vagrant_group
        VAGRANT_HOSTNAME = var.hostname
        VAGRANT_PASSWORD = var.vagrant_password
        VAGRANT_USERNAME = var.vagrant_username
      }
    })
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-qemu"
  shutdown_command    = "sudo /sbin/shutdown -h now"
  ssh_password        = var.vagrant_password
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.vagrant_username
  use_default_display = var.qemu_use_default_display
  vm_name             = "${local.vm_name}"
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
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      variables = {
        DISK      = var.virtualbox_disk_name
        MIRROR    = "${var.mirror_site}/\\$repo/os/\\$arch"
        SWAP_SIZE = "500M"
      }
    }),
    "/install-chrooted.sh" = templatefile("${path.root}/install-chrooted.sh.pkrtpl.hcl", {
      variables = {
        DISK             = var.virtualbox_disk_name
        ROOT_PASSWORD    = var.root_password
        VAGRANT_GROUP    = var.vagrant_group
        VAGRANT_HOSTNAME = var.hostname
        VAGRANT_PASSWORD = var.vagrant_password
        VAGRANT_USERNAME = var.vagrant_username
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-virtualbox"
  shutdown_command = "sudo poweroff"
  ssh_password     = var.vagrant_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.vagrant_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]
  ]
  vm_name = "${local.vm_name}"
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
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      variables = {
        DISK      = var.vmware_disk
        MIRROR    = "${var.mirror_site}/\\$repo/os/\\$arch"
        SWAP_SIZE = "500M"
      }
    }),
    "/install-chrooted.sh" = templatefile("${path.root}/install-chrooted.sh.pkrtpl.hcl", {
      variables = {
        DISK             = var.vmware_disk
        ROOT_PASSWORD    = var.root_password
        VAGRANT_GROUP    = var.vagrant_group
        VAGRANT_HOSTNAME = var.hostname
        VAGRANT_PASSWORD = var.vagrant_password
        VAGRANT_USERNAME = var.vagrant_username
      }
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-vmware"
  shutdown_command     = "sudo poweroff"
  ssh_password         = var.vagrant_password
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.vagrant_username
  version              = var.vmware_hardware_version
  vm_name              = "${local.vm_name}"
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
  boot_command  = local.boot_command
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type_id  = "thin"
  guest_os_type = var.vmware_guest_os_type
  headless      = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      variables = {
        DISK      = var.esxi_disk_name
        MIRROR    = "${var.mirror_site}/\\$repo/os/\\$arch"
        SWAP_SIZE = "500M"
      }
    }),
    "/install-chrooted.sh" = templatefile("${path.root}/install-chrooted.sh.pkrtpl.hcl", {
      variables = {
        DISK             = var.esxi_disk_name
        ROOT_PASSWORD    = var.root_password
        VAGRANT_GROUP    = var.vagrant_group
        VAGRANT_HOSTNAME = var.hostname
        VAGRANT_PASSWORD = var.vagrant_password
        VAGRANT_USERNAME = var.vagrant_username
      }
    })
  }
  insecure_connection = true
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  output_directory    = "${local.vm_name}"
  remote_datastore    = var.esxi_remote_datastore
  remote_host         = var.esxi_remote_host
  remote_password     = var.esxi_remote_password
  remote_type         = "esx5"
  remote_username     = var.esxi_remote_username
  shutdown_command    = "sudo poweroff"
  ssh_password        = var.vagrant_password
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.vagrant_username
  vm_name             = "${local.vm_name}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.connectionType"  = "bridged"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.virtualDev"      = "e1000"
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
    execute_command = "chmod +x {{ .Path }}; sh -ex {{ .Path }}"
    inline = [
      "echo y | sudo pacman -S virtualbox-guest-utils-nox"
    ]
    only = [
      "virtualbox-iso.default"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sh -ex {{ .Path }}"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "provisioners/vmware.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sh -ex {{ .Path }}"
    except = [
      "vmware-esxi.default"
    ]
    script = "provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sh -ex {{ .Path }}"
    script          = "provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output = "./${local.vm_name}-{{ .Provider }}.box"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output = "./${local.vm_name}-{{ .Provider }}.box"
  }
}
