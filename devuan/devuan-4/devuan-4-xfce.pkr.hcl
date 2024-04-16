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
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      version = ">= 1.0.5"
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
  default     = "20s"
  description = "Override `boot_wait` default setting, which is 10s."
}

variable "box_version" {
  type        = string
  default     = "4.0.20211014"
  description = "Version number of this Vagrant box."
}

variable "cpu" {
  type        = string
  default     = "amd64"
  description = "CPU name.  This is used as a part of box name."
}

variable "disk_size" {
  type        = string
  default     = "51200"
  description = "The size of the primary storage."
}

variable "esxi_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for ESXi box."
}

variable "esxi_vhv_enabled" {
  type        = string
  default     = "TRUE"
  description = "Enable nested virtualisation."
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
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for Hyper-V box"
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Switch name for Hyper-V box."
}

variable "install_from_dvd" {
  type        = bool
  default     = false
  description = "true if OS is installed using DVD media."
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://mirror.leaseweb.com/devuan/devuan_chimaera/installer-iso/SHA256SUMS"
  description = "SHA256 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = "devuan_chimaera_4.0.0_amd64_server.iso"
  description = "File name of the install media."
}

variable "iso_path" {
  type        = string
  default     = "devuan_chimaera/installer-iso"
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

variable "parallels_boot_mode" {
  type        = string
  default     = "efi"
  description = "`bios` or `efi` for Parallels box."
}

variable "parallels_tools_flavor" {
  type        = string
  default     = "lin"
  description = "The flavour name of Parallels Tools."
}

variable "root_password" {
  type        = string
  default     = "vagrant"
  description = "Password for the root user of this box."
}

variable "ssh_name" {
  type        = string
  default     = "root"
  description = "SSH password to connect this box being created."
}

variable "ssh_pass" {
  type        = string
  default     = "vagrant"
  description = "SSH password to connect this box being created."
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
  description = "Password for the Vagrant user of this box."
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "Username for the Vagrant user of this box."
}

variable "virtualbox_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for VirtualBox box."
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "Debian11_64"
  description = "Guest OS type of VirtualBox box."
}

variable "virtualbox_version" {
  type        = string
  default     = "6.1.26"
  description = "Targeting VirtualBox version."
}

variable "vm_name" {
  type        = string
  default     = null
  description = "Overriding VM name"
}

variable "vmware_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for VMware box."
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
  default     = "debian11-64"
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
    "%s<wait><down><down><down><down><left> auto priority=critical preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "passwd/root-password=${var.root_password} <wait>",
    "passwd/root-password-again=${var.root_password} <wait>",
    "passwd/user-fullname=${var.vagrant_username} <wait>",
    "passwd/username=${var.vagrant_username} <wait>",
    "passwd/user-password=${var.vagrant_password} <wait>",
    "passwd/user-password-again=${var.vagrant_password} <wait>",
    "locale=en_US.UTF-8 <wait>",
    "keymap=us <wait>",
    "tasks=standard <wait>",
    "net.ifnames=0 <wait>",
    "biosdevnames=0 <wait>",
    "%s<wait>"
  ]
  iso_urls = compact([
    var.iso_url,
    "./iso/${var.iso_name}",
    "https://mirror.netzspielplatz.de/devuan/${var.iso_path}/${var.iso_name}",
    "http://devuan.unetresgrossebite.com/${var.iso_path}/${var.iso_name}",
    "https://mirror.math.princeton.edu/pub/devuan/${var.iso_path}/${var.iso_name}",
    "https://mirror.leaseweb.com/devuan/${var.iso_path}/${var.iso_name}",
    "https://files.devuan.org/${var.iso_path}/${var.iso_name}",
    "https://arm-files.devuan.org/${var.iso_path}/${var.iso_name}"
  ])
  boot_parameter_edit = {
    "bios" : "<tab>"
    "efi" : "e"
  }
  boot_parameter_submit = {
    "bios" : "<enter>"
    "efi" : "<leftCtrlOn>x<leftCtrlOff>"
  }
  vm_name = coalesce(var.vm_name, "Devuan-4-${var.cpu}-xfce")
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
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.hyperv_boot_mode],
    local.boot_parameter_submit[var.hyperv_boot_mode]
  ))
  boot_wait = var.boot_wait
  cpus      = var.num_cpus
  disk_size = var.disk_size
  headless  = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list; \\",
        "    apt-install hyperv-daemons"

      ]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-hyperv"
  shutdown_command = "sudo /sbin/shutdown -h now"
  ssh_password     = var.ssh_pass
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_name
  switch_name      = var.hyperv_switch_name
  vm_name          = local.vm_name
}

source "parallels-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.parallels_boot_mode],
    local.boot_parameter_submit[var.parallels_boot_mode]
  ))
  boot_wait = var.boot_wait
  cpus      = var.num_cpus
  disk_size = var.disk_size
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ]
    })
  }
  iso_checksum           = var.iso_checksum
  iso_urls               = local.iso_urls
  memory                 = var.mem_size
  output_directory       = "output/${local.vm_name}-v${var.box_version}-parallels"
  parallels_tools_flavor = var.parallels_tools_flavor
  shutdown_command       = "sudo /sbin/shutdown -h now"
  ssh_password           = var.ssh_pass
  ssh_port               = 22
  ssh_timeout            = var.ssh_timeout
  ssh_username           = var.ssh_name
  vm_name                = local.vm_name
}

source "virtualbox-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.virtualbox_boot_mode],
    local.boot_parameter_submit[var.virtualbox_boot_mode]
  ))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ]
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-v${var.box_version}-virtualbox"
  shutdown_command = "/sbin/shutdown -h now"
  ssh_password     = var.ssh_pass
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_name
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.vmware_boot_mode],
    local.boot_parameter_submit[var.vmware_boot_mode]
  ))
  boot_wait          = var.boot_wait
  cdrom_adapter_type = var.vmware_cdrom_adapter_type
  cpus               = var.num_cpus
  disk_adapter_type  = var.vmware_disk_adapter_type
  disk_size          = var.disk_size
  disk_type_id       = "0"
  guest_os_type      = var.vmware_guest_os_type
  headless           = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ]
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-v${var.box_version}-vmware"
  shutdown_command     = "/sbin/shutdown -h now"
  ssh_password         = var.ssh_pass
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_name
  version              = var.vmware_hardware_version
  vm_name              = local.vm_name
  vmx_data             = local.vmware_vmx_data
}

source "vmware-iso" "esxi" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.esxi_boot_mode],
    local.boot_parameter_submit[var.esxi_boot_mode]
  ))
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type_id  = "thin"
  guest_os_type = var.vmware_guest_os_type
  headless      = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ]
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "bridged"
  network_adapter_type = "e1000"
  network_name         = "VM Network"
  output_directory     = "${local.vm_name}-v${var.box_version}"
  remote_datastore     = var.esxi_remote_datastore
  remote_host          = var.esxi_remote_host
  remote_password      = var.esxi_remote_password
  remote_type          = "esx5"
  remote_username      = var.esxi_remote_username
  shutdown_command     = "/sbin/shutdown -h now"
  skip_export          = true
  ssh_password         = var.ssh_pass
  ssh_port             = 22
  ssh_username         = var.ssh_name
  ssh_wait_timeout     = "10000s"
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
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
    "source.parallels-iso.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    environment_vars = [
      "DEVUAN_MIRROR_SERVER=deb.devuan.org",
      "DEVUAN_VERSION=chimaera",
      "INSTALL_FROM_DVD=${var.install_from_dvd}",
      "VAGRANT_GROUP=${var.vagrant_group}",
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "XRDP=xrdp=0.9.12-1.1+devuan2"
    ]
    scripts = [
      "../provisioners/base.sh",
      "../provisioners/vagrant.sh",
      "../provisioners/xrdp.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "PRL_TOOLS=prl-tools-${var.parallels_tools_flavor}.iso"
    ]
    only = [
      "parallels-iso.default"
    ]
    script       = "../provisioners/parallels.sh"
    pause_before = "10s"
  }

  provisioner "shell" {
    environment_vars = [
      "VBOX_VER=${var.virtualbox_version}",
      "VIRTUALBOX_WITH_XORG=1"
    ]
    only = [
      "virtualbox-iso.default"
    ]
    script       = "../provisioners/virtualbox.sh"
    pause_before = "10s"
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS_DESKTOP=open-vm-tools-desktop=2:11.2.5-2+deb11u3",
      "VMWARE_WITH_XORG=1",
      "XSERVER_XORG_INPUT_VMMOUSE=xserver-xorg-input-evdev=1:2.10.6-2",
      "XSERVER_XORG_VIDEO_VMWARE=xserver-xorg-video-vmware=1:13.3.0-3"
    ]
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmtools.sh"
  }

  provisioner "shell" {
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    script = "../provisioners/finalise.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    except = [
      "vmware-iso.esxi"
    ]
    output = "./${local.vm_name}-v${var.box_version}-{{ .Provider }}.box"
  }
}
