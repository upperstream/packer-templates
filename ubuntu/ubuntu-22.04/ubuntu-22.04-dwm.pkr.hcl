packer {
  required_version = ">= 1.7.0"
  required_plugins {
    parallels = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/parallels"
    }
    qemu = {
      version = ">= 1.0.9"
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

variable "archive_mirror" {
  type    = string
  default = "http://archive.ubuntu.com/ubuntu"
}

variable "boot_wait" {
  type        = string
  default     = "4s"
  description = "Override `boot_wait` default setting, which is 10s."
}

variable "box_version" {
  type        = string
  default     = "2204.3.20230811"
  description = "Version number of this Vagrant box."
}

variable "disk_size" {
  type        = string
  default     = "51200"
  description = "The size of the primary storage."
}

variable "esxi_boot_mode" {
  type    = string
  default = "efi"
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

variable "hyperv_boot_mode" {
  type    = string
  default = "efi"
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Switch name for Hyper-V box."
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://releases.ubuntu.com/22.04.3/SHA256SUMS"
  description = "SHA256 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = "ubuntu-22.04.3-live-server-amd64.iso"
  description = "File name of the install media."
}

variable "mem_size" {
  type        = string
  default     = "4096"
  description = "Memory size of this box."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "The number of CPUs of this box."
}

variable "os_version" {
  type    = string
  default = "22.04.3"
}

variable "parallels_boot_mode" {
  type    = string
  default = "efi"
}

variable "parallels_tools_flavor" {
  type        = string
  default     = "lin"
  description = "The flavour name of Parallels Tools."
}

variable "qemu_boot_mode" {
  type    = string
  default = "efi"
}

variable "qemu_display" {
  type    = string
  default = "gtk"
}

variable "qemu_use_default_display" {
  type    = bool
  default = false
}

variable "ssh_password" {
  type        = string
  default     = "vagrant"
  description = "Password for the root user of this box."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "ssh_username" {
  type        = string
  default     = "vagrant"
  description = "SSH username to connect this box being created."
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = true
  description = "Password for the Vagrant user of this box."
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

variable "virtualbox_boot_mode" {
  type    = string
  default = "efi"
}

variable "virtualbox_version" {
  type        = string
  default     = "7.0.8"
  description = "Targeting VirtualBox version."
}

variable "vm_name" {
  type        = string
  default     = ""
  description = "Overriding VM name"
}

variable "vm_name_base" {
  type        = string
  default     = "Ubuntu-22.04-amd64"
  description = "Base part of default VM name"
}

variable "vmware_boot_mode" {
  type    = string
  default = "efi"
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

variable "vmware_guest_os_type" {
  type        = string
  default     = "ubuntu-64"
  description = "Guest OS type of VMware box."
}

variable "vmware_hardware_version" {
  type        = string
  default     = "9"
  description = "Virtual hardware verison of VMware box."
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
  boot_command_edit = {
    "bios" = "<wait><esc><wait0.1s><esc><wait0.5s><f6><wait0.5s><esc>"
    "efi"  = "e<down><down><down><down>"
  }
  boot_command_exec = {
    "bios" = "<enter>"
    "efi"  = "<f10>"
  }
  boot_command = [
    "%s<left><left><left><left>autoinstall <wait>ds='nocloud-net;<wait>s=http://{{.HTTPIP}}:<wait>{{.HTTPPort}}/' <wait>net.ifnames=0 biosdevnames=0 <wait5>%s",
  ]
  iso_urls = [
    "iso/${var.iso_name}",
    "https://releases.ubuntu.com/${var.os_version}/${var.iso_name}",
    "https://cdimages.ubuntu.com/ubuntu/releases/${var.os_version}/release/${var.iso_name}"
  ]
  vm_name = coalesce(var.vm_name, "${var.vm_name_base}-dwm")
  vmware_vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = var.vmware_vhv_enabled
    "svga.autodetect"           = var.vmware_svga_autodetect
    "usb_xhci.present"          = var.vmware_usb_xhci_present
  }
}

source "hyperv-iso" "default" {
  boot_command         = split("\n", format(join("\n", concat(["<down>"], local.boot_command)), local.boot_command_edit[var.hyperv_boot_mode], local.boot_command_exec[var.hyperv_boot_mode]))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  headless             = var.headless
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = [
        "curtin in-target --target=/target apt install linux-cloud-tools-common",
        "curtin in-target --target=/target -- apt install -y linux-tools-$(ls /target/boot/vmlinuz-* | cut -f2- -d- | sort -t- -k1nr,2nr | head -n1) linux-cloud-tools-$(ls /target/boot/vmlinuz-* | cut -f2- -d- | sort -t- -k1nr,2nr | head -n1)"
      ]
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-hyperv"
  shutdown_command = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vm_name          = local.vm_name
}

source "parallels-iso" "default" {
  boot_command  = split("\n", format(join("\n", local.boot_command), local.boot_command_edit[var.parallels_boot_mode], local.boot_command_exec[var.parallels_boot_mode]))
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  guest_os_type = "ubuntu"
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = []
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  iso_checksum               = var.iso_checksum
  iso_urls                   = local.iso_urls
  memory                     = var.mem_size
  output_directory           = "output/${local.vm_name}-v${var.box_version}-parallels"
  parallels_tools_flavor     = var.parallels_tools_flavor
  parallels_tools_guest_path = "/tmp/prl-tools-{{.Flavor}}.iso"
  shutdown_command           = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  ssh_password               = var.ssh_password
  ssh_port                   = 22
  ssh_timeout                = var.ssh_timeout
  ssh_username               = var.ssh_username
  vm_name                    = local.vm_name
}

source "qemu" "default" {
  accelerator    = "kvm"
  boot_command   = split("\n", format(join("\n", local.boot_command), local.boot_command_edit[var.qemu_boot_mode], local.boot_command_exec[var.qemu_boot_mode]))
  boot_wait      = var.boot_wait
  cpus           = var.num_cpus
  disk_interface = "virtio"
  disk_size      = var.disk_size
  display        = var.qemu_display
  format         = "qcow2"
  headless       = var.headless
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = []
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-v${var.box_version}-qemu"
  shutdown_command    = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.ssh_username
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command         = split("\n", format(join("\n", local.boot_command), local.boot_command_edit[var.virtualbox_boot_mode], local.boot_command_exec[var.virtualbox_boot_mode]))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu22_LTS_64"
  headless             = var.headless
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = []
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-virtualbox"
  shutdown_command = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--vram", "16"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command       = split("\n", format(join("\n", local.boot_command), local.boot_command_edit[var.vmware_boot_mode], local.boot_command_exec[var.vmware_boot_mode]))
  boot_wait          = var.boot_wait
  cdrom_adapter_type = var.vmware_cdrom_adapter_type
  cpus               = var.num_cpus
  disk_adapter_type  = var.vmware_disk_adapter_type
  disk_size          = var.disk_size
  disk_type_id       = "0"
  guest_os_type      = var.vmware_guest_os_type
  headless           = var.headless
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = []
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-v${var.box_version}-vmware"
  shutdown_command     = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_username
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data             = local.vmware_vmx_data
}

source "vmware-iso" "esxi" {
  boot_command  = split("\n", format(join("\n", local.boot_command), local.boot_command_edit[var.esxi_boot_mode], local.boot_command_exec[var.esxi_boot_mode]))
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type_id  = "thin"
  guest_os_type = var.vmware_guest_os_type
  headless      = var.headless
  http_content = {
    "/user-data" = templatefile("${path.root}/http/user-data.pkrtpl", {
      identity = {
        "username" = var.vagrant_username
        "password" = bcrypt(var.vagrant_password)
      }
      additional_command_lines = []
    })
    "/meta-data" = file("${path.root}/http/meta-data")
  }
  insecure_connection     = true
  iso_checksum            = var.iso_checksum
  iso_urls                = local.iso_urls
  memory                  = var.mem_size
  network                 = "bridged"
  network_adapter_type    = "e1000"
  remote_datastore        = var.esxi_remote_datastore
  remote_host             = var.esxi_remote_host
  remote_output_directory = coalesce(var.vm_name, "${local.vm_name}-v${var.box_version}")
  remote_password         = var.esxi_remote_password
  remote_type             = "esx5"
  remote_username         = var.esxi_remote_username
  shutdown_command        = "echo ${var.vagrant_password} | sudo -S /sbin/shutdown -h now"
  skip_export             = true
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_timeout             = var.ssh_timeout
  ssh_username            = var.ssh_username
  vm_name                 = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "16777216"
    "vhv.enable"                = "TRUE"
  }
  vnc_disable_password = true
  vnc_over_websocket   = var.esxi_vnc_over_websocket
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
    environment_vars = [
      "ARANDR=arandr=0.1.10-1.1",
      "ARCHIVE_MIRROR=${var.archive_mirror}",
      "DEBIAN_FRONTEND=noninteractive",
      "DWM=dwm=6.3-0.1",
      "STTERM=stterm=0.8.4-1",
      "SUCKLESS_TOOLS=suckless-tools=46-1",
      "VAGRANT_SSH_PUBLIC_KEY=${var.vagrant_ssh_public_key}",
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "VIRTUALBOX_VERSION=${var.virtualbox_version}",
      "XROG=xorg=1:7.7+23ubuntu2"
    ]
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    scripts = [
      "../provisioners/update_mirror.sh",
      "../provisioners/base_ubuntu1804+.sh",
      "../provisioners/vagrant.sh",
      "../provisioners/dwm.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "USE_VIRTUALBOX_UBUNTU_PACKAGE=yes",
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "VIRTUALBOX_VERSION=${var.virtualbox_version}",
      "VIRTUALBOX_WITH_XORG=yes"
    ]
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "virtualbox-iso.default"
    ]
    script = "../provisioners/virtualbox.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmware-desktop.sh"
  }

  provisioner "shell" {
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "hyperv-iso.default"
    ]
    script = "../provisioners/hyperv.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "PRL_TOOLS=/tmp/prl-tools-${var.parallels_tools_flavor}.iso"
    ]
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "parallels-iso.default"
    ]
    script = "../provisioners/parallels.sh"
  }

  provisioner "shell" {
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "VAGRANT_USERNAME=${var.vagrant_username}"
    ]
    execute_command = "echo '${var.vagrant_password}' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    script          = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    except = [
      "qemu.default",
      "vmware-iso.esxi"
    ]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.ubuntu"
  }

  post-processor "vagrant" {
    keep_input_artifact  = true
    compression_level    = 9
    only                 = ["qemu.default"]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.ubuntu"
  }
}
