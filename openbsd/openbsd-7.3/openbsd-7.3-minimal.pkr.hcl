packer {
  required_version = ">= 1.7.0"
  required_plugins {
    hyperv = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hyperv"
    }
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

variable "boot_wait" {
  type = string
  default = "20s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_version" {
  type    = string
  default = "7.3.20230410"
}

variable "cpu" {
  type    = string
  default = "amd64"
}

variable "disk_size" {
  type        = string
  default     = "40960"
  description = "Disk size of the creating VM."
}

variable "esxi_remote_datastore" {
  type    = string
  default = "${env("ESXI_REMOTE_DATASTORE")}"
}

variable "esxi_remote_host" {
  type    = string
  default = "${env("ESXI_REMOTE_HOST")}"
}

variable "esxi_remote_password" {
  type      = string
  default   = "${env("ESXI_REMOTE_PASSWORD")}"
  sensitive = true
}

variable "esxi_remote_username" {
  type    = string
  default = "${env("ESXI_REMOTE_USERNAME")}"
}

variable "esxi_vnc_over_websocket" {
  type        = string
  default     = "true"
  description = "Controlls whether or not to use VNC over WebSocket feature for ESXi."
}

variable "headless" {
  type        = string
  default     = "false"
  description = "Launch the virtual machine in headless mode if set to `true`."
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Network switch name on Packer Hyper-V builder."
}

variable "iso_checksum" {
  type    = string
  default = "sha256:fdf1210ffe87213eeca5f1d317e8b19364cbae83545cdfc7845098a53fc79a60"
}

variable "iso_image" {
  type    = string
  default = "install73.iso"
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
}

variable "mem_size" {
  type        = string
  default     = "512"
  description = "RAM size of the creating VM."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "Number of virtual CPUs."
}

variable "os_ver" {
  type    = string
  default = "7.3"
}

variable "package_server" {
  type        = string
  default     = "http://cdn.openbsd.org/pub/OpenBSD"
  description = "URL to download packages from."
}

variable "qemu_binary" {
  type    = string
  default = "qemu-system-x86_64"
}

variable "root_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for `root` user.  This is also used for SSH password during build time."
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for `vagrant_username`."
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "User name used for runtime."
}

variable "variant" {
  type    = string
  default = "minimal"
}

variable "virtualbox_guest_os_type" {
  type    = string
  default = "OpenBSD_64"
}

variable "vm_name" {
  type        = string
  default     = "OpenBSD-7.3-amd64"
  description = "VM name of the creating box."
}

variable "vmware_guest_os_type" {
  type    = string
  default = "other-64"
}

locals {
  boot_command = [
    "<wait5>a<enter><wait>",
    "<wait10>",
    "http://{{ .HTTPIP }}:{{ .HTTPPort }}/%s<enter><wait>",
    "<wait5>",
    "i<enter><wait>"
  ]
  install_configs = {
    "without_x11" : "install.conf"
    "with_x11" : "install_with_x11.conf"
  }
  iso_urls = compact([
    var.iso_url,
    "iso/${var.cpu}/${var.iso_image}",
    "iso/${var.iso_image}",
    "http://cdn.openbsd.org/pub/OpenBSD/${var.os_ver}/${var.cpu}/${var.iso_image}"
  ])
}

source "hyperv-iso" "default" {
  boot_command     = split("\n", format(join("\n", local.boot_command), local.install_configs["without_x11"]))
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = "."
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_version}-hyperv"
  shutdown_command = "shutdown -h -p now"
  ssh_password     = var.root_password
  ssh_username     = "root"
  ssh_wait_timeout = "10000s"
  switch_name      = var.hyperv_switch_name
  vm_name          = "${var.vm_name}-${var.variant}"
}

source "qemu" "default" {
  accelerator         = "kvm"
  boot_command        = split("\n", format(join("\n", local.boot_command), local.install_configs["without_x11"]))
  boot_wait           = var.boot_wait
  cpus                = var.num_cpus
  disk_compression    = true
  disk_interface      = "virtio"
  disk_size           = var.disk_size
  format              = "qcow2"
  headless            = var.headless
  http_directory      = "."
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${var.vm_name}-${var.variant}-v${var.box_version}-qemu"
  qemu_binary         = var.qemu_binary
  shutdown_command    = "shutdown -h -p now"
  ssh_password        = var.root_password
  ssh_timeout         = "10000s"
  ssh_username        = "root"
  use_default_display = true
  vm_name             = "${var.vm_name}-${var.variant}-v${var.box_version}"
}

source "virtualbox-iso" "default" {
  boot_command         = split("\n", format(join("\n", local.boot_command), local.install_configs["without_x11"]))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_directory       = "."
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-virtualbox"
  shutdown_command     = "shutdown -h -p now"
  ssh_password         = var.root_password
  ssh_timeout          = "10000s"
  ssh_username         = "root"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  vm_name = "${var.vm_name}-${var.variant}"
}

source "vmware-iso" "default" {
  boot_command     = split("\n", format(join("\n", local.boot_command), local.install_configs["without_x11"]))
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_size        = var.disk_size
  disk_type_id     = "0"
  guest_os_type    = var.vmware_guest_os_type
  headless         = var.headless
  http_directory   = "."
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  network          = "nat"
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_version}-vmware"
  shutdown_command = "shutdown -h -p now"
  ssh_password     = var.root_password
  ssh_timeout      = "10000s"
  ssh_username     = "root"
  vm_name          = "${var.vm_name}-${var.variant}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
}

source "vmware-iso" "esxi" {
  boot_command        = split("\n", format(join("\n", local.boot_command), local.install_configs["without_x11"]))
  boot_wait           = var.boot_wait
  cpus                = var.num_cpus
  disk_size           = var.disk_size
  disk_type_id        = "thin"
  guest_os_type       = var.vmware_guest_os_type
  headless            = var.headless
  http_directory      = "."
  insecure_connection = true
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  network             = "bridged"
  output_directory    = "${var.vm_name}-${var.variant}-v${var.box_version}"
  remote_datastore    = var.esxi_remote_datastore
  remote_host         = var.esxi_remote_host
  remote_password     = var.esxi_remote_password
  remote_type         = "esx5"
  remote_username     = var.esxi_remote_username
  shutdown_command    = "shutdown -h -p now"
  skip_export         = true
  ssh_password        = var.root_password
  ssh_timeout         = "10000s"
  ssh_username        = "root"
  vm_name             = "${var.vm_name}-${var.variant}-v${var.box_version}"
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
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    environment_vars = [
      "PKG_PATH=${var.package_server}/${var.os_ver}/packages/${var.cpu}",
      "VAGRANT_USER=${var.vagrant_username}",
      "VAGRANT_GROUP=${var.vagrant_username}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "RSYNC=rsync-3.2.7"
    ]
    script = "../provisioners/vagrant_openbsd7.sh"
  }

  provisioner "shell" {
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    script = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.OpenBSD-sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.OpenBSD-sh"
  }
}
