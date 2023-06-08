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
  default     = "2004.6.20230323"
  description = "Version number of this Vagrant box."
}

variable "disk_size" {
  type        = string
  default     = "51200"
  description = "The size of the primary storage."
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

variable "iso_checksum" {
  type        = string
  default     = "file:https://releases.ubuntu.com/20.04.6/SHA256SUMS"
  description = "SHA256 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = "ubuntu-20.04.6-live-server-amd64.iso"
  description = "File name of the install media."
}

variable "mem_size" {
  type        = string
  default     = "1024"
  description = "Memory size of this box."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "The number of CPUs of this box."
}

variable "os_version" {
  type    = string
  default = "20.04.6"
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
  default     = null
  description = "SSH public key for Vagrant user"
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "Username for the Vagrant user of this box."
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
  default     = "Ubuntu-20.04-amd64"
  description = "Base part of default VM name"
}

variable "vmware_boot_command" {
  type    = list(string)
  default = null
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
  boot_command = [
    "<wait><esc><wait0.1s><esc><wait0.5s><f6><wait0.5s><esc><wait><left><left><left><left>autoinstall <wait>ds=nocloud-net;<wait>s=http://{{.HTTPIP}}:<wait>{{.HTTPPort}}/ <wait>net.ifnames=0 biosdevnames=0 <wait5><enter>",
  ]
  iso_urls = [
    "iso/${var.iso_name}",
    "https://releases.ubuntu.com/${var.os_version}/${var.iso_name}",
    "https://cdimages.ubuntu.com/ubuntu/releases/${var.os_version}/release/${var.iso_name}"
  ]
  vm_name = coalesce(var.vm_name, "${var.vm_name_base}-minimal")
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

source "qemu" "default" {
  accelerator         = "kvm"
  boot_command        = local.boot_command
  boot_wait           = var.boot_wait
  cpus                = var.num_cpus
  disk_interface      = "virtio"
  disk_size           = var.disk_size
  display             = var.qemu_display
  format              = "qcow2"
  headless            = var.headless
  http_directory      = "./http"
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-v${var.box_version}-qemu"
  shutdown_command    = "sudo /sbin/shutdown -h now"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_username        = var.ssh_username
  ssh_wait_timeout    = "10000s"
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command         = local.boot_command
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu20_LTS_64"
  headless             = var.headless
  http_directory       = "./http"
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  output_directory     = "output/${local.vm_name}-v${var.box_version}-virtualbox"
  shutdown_command     = "sudo /sbin/shutdown -h now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_username         = var.ssh_username
  ssh_wait_timeout     = "10000s"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command         = coalesce(var.vmware_boot_command, local.boot_command)
  boot_wait            = var.boot_wait
  cdrom_adapter_type   = var.vmware_cdrom_adapter_type
  cpus                 = var.num_cpus
  disk_adapter_type    = var.vmware_disk_adapter_type
  disk_size            = var.disk_size
  disk_type_id         = "0"
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_directory       = "./http"
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-v${var.box_version}-vmware"
  shutdown_command     = "sudo /sbin/shutdown -h now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_username         = var.ssh_username
  ssh_wait_timeout     = "10000s"
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data             = local.vmware_vmx_data
}

source "vmware-iso" "esxi" {
  boot_command            = local.boot_command
  boot_wait               = var.boot_wait
  cpus                    = var.num_cpus
  disk_size               = var.disk_size
  disk_type_id            = "thin"
  guest_os_type           = var.vmware_guest_os_type
  headless                = var.headless
  http_directory          = "./http"
  insecure_connection     = true
  iso_checksum            = var.iso_checksum
  iso_urls                = local.iso_urls
  memory                  = var.mem_size
  network                 = "bridged"
  network_adapter_type    = "e1000"
  remote_datastore        = var.esxi_remote_datastore
  remote_host             = var.esxi_remote_host
  remote_output_directory = "${local.vm_name}-v${var.box_version}"
  remote_password         = var.esxi_remote_password
  remote_type             = "esx5"
  remote_username         = var.esxi_remote_username
  shutdown_command        = "sudo /sbin/shutdown -h now"
  skip_export             = true
  ssh_password            = var.ssh_password
  ssh_port                = 22
  ssh_username            = var.ssh_username
  ssh_wait_timeout        = "10000s"
  vm_name                 = local.vm_name
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
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    environment_vars = [
      "ARCHIVE_MIRROR=${var.archive_mirror}",
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "VIRTUALBOX_VERSION=${var.virtualbox_version}"
    ]
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    scripts = [
      "../provisioners/update_mirror.sh",
      "../provisioners/base_ubuntu1804+.sh",
      "../provisioners/vagrant.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "VIRTUALBOX_VERSION=${var.virtualbox_version}"
    ]
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "virtualbox-iso.default"
    ]
    script = "../provisioners/virtualbox.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmware-server.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "VAGRANT_USERNAME=${var.vagrant_username}"
    ]
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh -ex '{{ .Path }}'"
    script          = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    except = [
      "qemu.default",
      "vmware-iso.esxi"
    ]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile-ubuntu"
  }

  post-processor "vagrant" {
    keep_input_artifact  = true
    compression_level    = 9
    only                 = ["qemu.default"]
    output               = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile-ubuntu"
  }
}
