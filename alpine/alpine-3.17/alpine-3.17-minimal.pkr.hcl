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
  type    = string
  default = "30s"
}

variable "box_version" {
  type    = string
  default = "17.0.20221122"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "esxi_keep_registered" {
  type    = string
  default = "false"
}

variable "esxi_vnc_over_websocket" {
  type    = string
  default = "true"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "mem_size" {
  type    = string
  default = "512"
}

variable "num_cpus" {
  type    = string
  default = "2"
}

variable "os_ver" {
  type    = string
  default = "v3.17"
}

variable "qemu_display" {
  type    = string
  default = ""
}

variable "qemu_use_default_display" {
  type    = string
  default = "true"
}

variable "remote_datastore" {
  type    = string
  default = "${env("REMOTE_DATASTORE")}"
}

variable "remote_host" {
  type    = string
  default = "${env("REMOTE_HOST")}"
}

variable "remote_password" {
  type      = string
  default   = "${env("REMOTE_PASSWORD")}"
  sensitive = true
}

variable "remote_username" {
  type    = string
  default = "${env("REMOTE_USERNAME")}"
}

variable "root_password" {
  type      = string
  default   = "vagrant"
  sensitive = true
}

variable "ssh_password" {
  type      = string
  default   = "vagrant"
  sensitive = true
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "vagrant_password" {
  type      = string
  default   = "vagrant"
  sensitive = true
}

variable "vagrant_username" {
  type    = string
  default = "vagrant"
}

variable "variant" {
  type    = string
  default = "minimal"
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = null
}

variable "cpu" {
  type    = string
  default = null
}

variable "virtualbox_guest_os_type" {
  type    = string
  default = null
}

variable "vmware_fusion_app_path" {
  type    = string
  default = "/Applications/VMware Fusion.app"
}

variable "vmware_guest_os_type" {
  type    = string
  default = null
}

variable "esxi_guest_os_type" {
  type    = string
  default = null
}

variable "hyperv_switch_name" {
  type    = string
  default = "Default Switch"
}

variable "iso_image" {
  type    = string
  default = null
}

source "hyperv-iso" "default" {
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
    "DISK=sda ERASE_DISKS=/dev/sda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install_hyperv.sh<enter><wait>",
    "DISK=sda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait        = "${var.boot_wait}"
  cpus             = "${var.num_cpus}"
  disk_size        = "${var.disk_size}"
  headless         = "${var.headless}"
  http_directory   = "."
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  memory           = "${var.mem_size}"
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_version}-hyperv"
  shutdown_command = "poweroff"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "10000s"
  ssh_username     = "${var.ssh_username}"
  switch_name      = "${var.hyperv_switch_name}"
  vm_name          = "${var.vm_name}-${var.variant}"
}

source "parallels-iso" "default" {
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
    "DISK=sda ERASE_DISKS=/dev/sda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=sda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait            = "${var.boot_wait}"
  cpus                 = "${var.num_cpus}"
  disk_size            = "${var.disk_size}"
  disk_type            = "expand"
  guest_os_type        = "linux"
  http_directory       = "."
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  memory               = "${var.mem_size}"
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-parallels"
  shutdown_command     = "poweroff"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = "${var.ssh_username}"
  parallels_tools_mode = "disable"
  vm_name              = "${var.vm_name}-${var.variant}"
}

source "qemu" "default" {
  accelerator         = "kvm"
  boot_command        = [
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
    "DISK=vda ERASE_DISKS=/dev/vda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=vda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait           = "${var.boot_wait}"
  cpus                = "${var.num_cpus}"
  disk_interface      = "virtio"
  disk_size           = "${var.disk_size}"
  display             = "${var.qemu_display}"
  format              = "qcow2"
  headless            = "${var.headless}"
  http_directory      = "."
  iso_checksum        = "${var.iso_checksum}"
  iso_urls            = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  memory              = "${var.mem_size}"
  net_device          = "virtio-net"
  output_directory    = "output/${var.vm_name}-${var.variant}-v${var.box_version}-qemu"
  shutdown_command    = "poweroff"
  ssh_password        = "${var.ssh_password}"
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = "${var.ssh_username}"
  use_default_display = "${var.qemu_use_default_display}"
  vm_name             = "${var.vm_name}-${var.variant}"
}

source "virtualbox-iso" "default" {
  boot_command            = [
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
    "DISK=sda ERASE_DISKS=/dev/sda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=sda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait               = "${var.boot_wait}"
  cpus                    = "${var.num_cpus}"
  disk_size               = "${var.disk_size}"
  guest_additions_mode    = "disable"
  guest_os_type           = "${var.virtualbox_guest_os_type}"
  headless                = "${var.headless}"
  http_directory          = "."
  iso_checksum            = "${var.iso_checksum}"
  iso_urls                = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  memory                  = "${var.mem_size}"
  output_directory        = "output/${var.vm_name}-${var.variant}-v${var.box_version}-virtualbox"
  shutdown_command        = "poweroff"
  ssh_password            = "${var.ssh_password}"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  ssh_username            = "${var.ssh_username}"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}-${var.variant}"
}

source "vmware-iso" "default" {
  boot_command         = [
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
    "DISK=sda ERASE_DISKS=/dev/sda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=sda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait            = "${var.boot_wait}"
  cpus                 = "${var.num_cpus}"
  disk_size            = "${var.disk_size}"
  disk_type_id         = "0"
  fusion_app_path      = "${var.vmware_fusion_app_path}"
  guest_os_type        = "${var.vmware_guest_os_type}"
  headless             = "${var.headless}"
  http_directory       = "."
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  memory               = "${var.mem_size}"
  network              = "nat"
  network_adapter_type = "e1000"
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-vmware"
  shutdown_command     = "poweroff"
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = "${var.ssh_username}"
  tools_upload_flavor  = ""
  vm_name              = "${var.vm_name}-${var.variant}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
}

source "vmware-iso" "esxi" {
  boot_command         = [
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
    "DISK=sda ERASE_DISKS=/dev/sda setup-alpine -f /tmp/answers.txt<enter><wait><wait10>",
    "${var.root_password}<enter><wait>",
    "${var.root_password}<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>",
    "wget -O /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "DISK=sda sh /tmp/install.sh<enter><wait>"
  ]
  boot_wait            = "${var.boot_wait}"
  cpus                 = "${var.num_cpus}"
  disk_size            = "${var.disk_size}"
  disk_type_id         = "thin"
  guest_os_type        = "${var.esxi_guest_os_type}"
  headless             = "${var.headless}"
  http_directory       = "."
  insecure_connection  = true
  iso_checksum         = "${var.iso_checksum}"
  iso_urls             = ["./iso/${var.iso_image}", "http://dl-cdn.alpinelinux.org/alpine/${var.os_ver}/releases/${var.cpu}/${var.iso_image}"]
  keep_registered      = "${var.esxi_keep_registered}"
  memory               = "${var.mem_size}"
  network              = "bridged"
  network_adapter_type = "e1000"
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-esxi"
  remote_datastore     = "${var.remote_datastore}"
  remote_host          = "${var.remote_host}"
  remote_password      = "${var.remote_password}"
  remote_type          = "esx5"
  remote_username      = "${var.remote_username}"
  shutdown_command     = "poweroff"
  skip_export          = true
  ssh_password         = "${var.ssh_password}"
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = "${var.ssh_username}"
  tools_upload_flavor  = "linux"
  vm_name              = "${var.vm_name}-${var.variant}-v${var.box_version}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
  vnc_over_websocket = "${var.esxi_vnc_over_websocket}"
}

build {
  sources = [
    "source.hyperv-iso.default",
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.esxi",
    "source.vmware-iso.default",
    "source.parallels-iso.default"
  ]

  provisioner "shell" {
    only             = ["hyperv-iso.*"]
    script           = "../provisioners/hyperv.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "VIRTUALBOX_GUEST_ADDITIONS=virtualbox-guest-additions=7.0.2-r0",
      "OS_VER=${var.os_ver}"
    ]
    only             = ["virtualbox-iso.*"]
    script           = "../provisioners/virtualbox_alpine3.13+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools=12.1.0-r0",
      "OS_VER=${var.os_ver}",
      "CPU=${var.cpu}"
    ]
    only             = ["vmware-iso.*"]
    script           = "../provisioners/vmware_alpine3.9+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "NFS_UTILS=nfs-utils=2.6.2-r0",
      "UTIL_LINUX=util-linux=2.38.1-r0"
    ]
    only             = ["qemu"]
    script           = "../provisioners/nfs.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "VAGRANT_PASSWORD=${var.vagrant_password}"
    ]
    script = "../provisioners/vagrant_alpine3.17.sh"
  }

  provisioner "shell" {
    only                = [
      "virtualbox-iso.default",
      "vmware-iso.vmware-iso",
      "qemu",
      "parallels-iso.default"
    ]
    script              = "../provisioners/disk_cleanup.sh"
    start_retry_timeout = "5m"
  }

  provisioner "shell" {
    script = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level    = 9
    only                 = [
      "hyperv-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default",
      "parallels-iso.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.Alpine3.17"
  }

  post-processor "vagrant" {
    keep_input_artifact  = true
    compression_level    = 9
    only                 = ["qemu.default"]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.Alpine3.17"
  }
}
