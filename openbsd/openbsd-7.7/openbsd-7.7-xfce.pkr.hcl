packer {
  required_version = ">= 1.7.0"
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = ">= 1.1.3"
    }
    parallels = {
      source  = "github.com/hashicorp/parallels"
      version = ">= 1.0.0"
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

variable "boot_wait" {
  type        = string
  default     = "30s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_version" {
  type    = string
  default = "7.7.20250428"
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

variable "esxi_hardware_version" {
  type        = string
  default     = "19"
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

variable "esxi_vnc_over_websocket" {
  type        = string
  default     = "true"
  description = "Controls whether or not to use VNC over WebSocket feature for ESXi."
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
  type        = string
  default     = "file:https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/SHA256"
  description = "SHA256 checksum of the install media."
}

variable "iso_image" {
  type        = string
  default     = "install77.iso"
  description = "File name of the install media."
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
}

variable "mem_size" {
  type        = string
  default     = "1024"
  description = "RAM size of the creating VM."
}

variable "num_cpus" {
  type        = string
  default     = "2"
  description = "Number of virtual CPUs."
}

variable "os_ver" {
  type    = string
  default = "7.7"
}

variable "package_arch" {
  type        = string
  default     = "amd64"
  description = "Architecture for binary packages."
}

variable "package_server" {
  type        = string
  default     = "http://cdn.openbsd.org/pub/OpenBSD"
  description = "URL to download packages from."
}

variable "qemu_binary" {
  type        = string
  default     = "qemu-system-x86_64"
  description = "Name of QEMU binary"
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
  default = "xfce"
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "OpenBSD_64"
  description = "Guest OS type of VirtualBox box."
}

variable "vm_name" {
  type        = string
  default     = "OpenBSD-7.7"
  description = "VM name of the creating box."
}

variable "vmware_disk_adapter_type" {
  type        = string
  default     = "scsi"
  description = "Disk adapter type for VMware box."
}

variable "vmware_guest_os_type" {
  type    = string
  default = "other-64"
}

variable "vmware_hardware_version" {
  type        = string
  default     = "13"
  description = "Hardware version for VMware box."
}

variable "vmware_network_adapter_type" {
  type        = string
  default     = "e1000"
  description = "Network adapter type for VMware box."
}

locals {
  boot_command = [
    "<wait5>a<enter><wait>",
    "<wait10>",
    "http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.conf<enter><wait>",
    "<wait5>",
    "i<enter><wait>"
  ]
  iso_urls = compact([
    var.iso_url,
    "iso/${var.cpu}/${var.iso_image}",
    "iso/${var.iso_image}",
    "https://cdn.openbsd.org/pub/OpenBSD/${var.os_ver}/${var.cpu}/${var.iso_image}"
  ])
  vm_name = "${var.vm_name}-${var.variant}-v${var.box_version}-${var.cpu}"
}

source "hyperv-iso" "default" {
  boot_command = local.boot_command
  boot_wait    = var.boot_wait
  cpus         = var.num_cpus
  disk_size    = var.disk_size
  headless     = var.headless
  http_content = {
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-hyperv"
  shutdown_command = "/sbin/shutdown -h -p now"
  ssh_password     = var.root_password
  ssh_username     = "root"
  ssh_wait_timeout = "10000s"
  switch_name      = var.hyperv_switch_name
  vm_name          = local.vm_name
}

source "parallels-iso" "default" {
  boot_command  = local.boot_command
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type     = "expand"
  guest_os_type = "other"
  http_content = {
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  iso_checksum           = "${var.iso_checksum}"
  iso_urls               = local.iso_urls
  memory                 = var.mem_size
  output_directory       = "output/${local.vm_name}-parallels"
  parallels_tools_flavor = "other"
  parallels_tools_mode   = "disable"
  shutdown_command       = "/sbin/shutdown -h -p now"
  ssh_password           = var.root_password
  ssh_username           = "root"
  ssh_wait_timeout       = "10000s"
  vm_name                = local.vm_name
}

source "qemu" "default" {
  accelerator      = "kvm"
  boot_command     = local.boot_command
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_compression = true
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  http_content = {
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-qemu"
  qemu_binary         = var.qemu_binary
  shutdown_command    = "/sbin/shutdown -h -p now"
  ssh_password        = var.root_password
  ssh_timeout         = "10000s"
  ssh_username        = "root"
  use_default_display = true
  vm_name             = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command         = local.boot_command
  boot_wait            = var.boot_wait
  chipset              = "ich9"
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-virtualbox"
  shutdown_command = "/sbin/shutdown -h -p now"
  ssh_password     = var.root_password
  ssh_timeout      = "10000s"
  ssh_username     = "root"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--vram", "12"]
  ]
  vm_name = local.vm_name
}

source "vmware-iso" "default" {
  boot_command      = local.boot_command
  boot_wait         = var.boot_wait
  cpus              = var.num_cpus
  disk_size         = var.disk_size
  disk_type_id      = "0"
  disk_adapter_type = var.vmware_disk_adapter_type
  guest_os_type     = var.vmware_guest_os_type
  headless          = var.headless
  http_content = {
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "nat"
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-vmware"
  shutdown_command     = "/sbin/shutdown -h -p now"
  ssh_password         = var.root_password
  ssh_timeout          = "10000s"
  ssh_username         = "root"
  usb                  = true
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "12582912"
    "usb_xhci.present"          = "TRUE"
    "vhv.enable"                = "TRUE"
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
    "/install.conf" = templatefile("${path.root}/install.conf.pkrtpl.hcl", {
      install_x11 = {
        "Do you expect to run the X Window System" = "yes"
      },
      location_of_sets = {
        "Location of sets" = "cd0"
      },
      server_directory = {
        "Server directory" = "${var.os_ver}/${var.cpu}"
      },
      set_names = {
        "Set name(s)" = "-c* -game*"
      }
    })
  }
  insecure_connection = true
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  network             = "bridged"
  output_directory    = local.vm_name
  remote_datastore    = var.esxi_remote_datastore
  remote_host         = var.esxi_remote_host
  remote_password     = var.esxi_remote_password
  remote_type         = "esx5"
  remote_username     = var.esxi_remote_username
  shutdown_command    = "/sbin/shutdown -h -p now"
  skip_export         = true
  ssh_password        = var.root_password
  ssh_timeout         = "10000s"
  ssh_username        = "root"
  vm_name             = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "12582912"
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
    environment_vars = [
      "GDM=gdm-47.0p1",
      "PKG_PATH=${var.package_server}/${var.os_ver}/packages/${var.package_arch}",
      "RSYNC=rsync-3.4.1-minimal",
      "VAGRANT_USER=${var.vagrant_username}",
      "VAGRANT_GROUP=${var.vagrant_username}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "XFCE=xfce-4.20.0"
    ]
    scripts = [
      "../provisioners/vagrant_openbsd7.sh",
      "../provisioners/x11_openbsd6.5+.sh",
      "../provisioners/xfce_openbsd7.sh"
    ]
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
      "parallels-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.OpenBSD-7.5+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.OpenBSD-7.5+"
  }
}
