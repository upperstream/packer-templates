packer {
  required_version = ">= 1.7.0"
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = ">= 1.1.4"
    }
    parallels = {
      source  = "github.com/hashicorp/parallels"
      version = ">= 1.2.8"
    }
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.1.3"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.1.5"
    }
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.1.2"
    }
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = ">= 1.1.0"
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
  default     = "13.1.20250906"
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

variable "dwm_version" {
  type    = string
  default = "6.5-1"
}

variable "esxi_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for ESXi box."
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

variable "esxi_vhv_enabled" {
  type        = bool
  default     = true
  description = "Enable nested virtualisation on ESXi VM."
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
  default     = "sha256:bfc338e671fd5a9f6d4a65cbf728c674c468e87c063f6fb324fc04677dc0d23d"
  description = "SHA256 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = "mini.iso"
  description = "File name of the install media."
}

variable "iso_path" {
  type        = string
  default     = "Debian13.1/main/installer-amd64/20250803+deb13u1/images/netboot"
  description = "Relative path to search the install media."
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
}

variable "mem_size" {
  type        = string
  default     = "1536"
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

variable "qemu_accelerator" {
  type        = string
  default     = "kvm"
  description = "QEMU accelerator name for QEMU box."
}

variable "qemu_binary" {
  type        = string
  default     = "qemu-system-x86_64"
  description = "Name of QEMU binary"
}

variable "qemu_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for QEMU box."
}

variable "qemu_display" {
  type        = string
  default     = ""
  description = "Display name for QEMU box."
}

variable "qemu_use_default_display" {
  type        = bool
  default     = true
  description = "Use the default display for QEMU box if true."
}

variable "root_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for the root user of this box.  Change the `sensitive` value to `true` if you want to hide the password."
}

variable "ssh_pass" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "SSH password to connect this box being created."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "ssh_user" {
  type        = string
  default     = "root"
  description = "SSH username to connect this box being created."
}

variable "suckless_tools_version" {
  type    = string
  default = "48-1+b1"
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

variable "virtualbox_boot_mode" {
  type        = string
  default     = "bios"
  description = "`bios` or `efi` for VirtualBox box."
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "Debian13_64"
  description = "Guest OS type of VirtualBox box."
}

variable "virtualbox_version" {
  type        = string
  default     = "7.0.6"
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
  default     = "debian13-64"
  description = "Guest OS type of VMware box."
}

variable "vmware_hardware_version" {
  type        = string
  default     = "13"
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
  type        = bool
  default     = false
  description = "Enable nested virtualisation."
}

locals {
  boot_command = [
    "%s<wait><down><down><down><down><left> auto priority=critical preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
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
    "https://deb.debian.org/debian/dists/${var.iso_path}/${var.iso_name}",
    "http://cdimage.debian.org/debian-cd/${var.iso_path}/${var.iso_name}",
    "http://cdimage.debian.org/cdimage/archive/${var.iso_path}/${var.iso_name}"
  ])
  boot_parameter_edit = {
    "bios" : "<tab>"
    "efi" : "e"
  }
  boot_parameter_submit = {
    "bios" : "<enter>"
    "efi" : "<leftCtrlOn>x<leftCtrlOff>"
  }
  passwd = {
    "root-password"       = "string ${var.root_password}",
    "root-password-again" = "string ${var.root_password}",
    "user-fullname"       = "string ${var.vagrant_username}",
    "username"            = "string ${var.vagrant_username}",
    "user-password"       = "string ${var.vagrant_password}",
    "user-password-again" = "string ${var.vagrant_password}"
  }
  vm_name = coalesce(var.vm_name, "Debian-13-dwm-v${var.box_version}-${var.cpu}")
}

source "hyperv-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.hyperv_boot_mode],
    local.boot_parameter_submit[var.hyperv_boot_mode]
  ))
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list; \\",
        "    grep -F '^deb http://deb.debian.org/debian' /target/etc/apt/sources.list > /dev/null || sed -i '/deb cdrom/a deb http://deb.debian.org/debian stable main' /target/etc/apt/sources.list; \\",
        "    chroot /target apt update; \\",
        "    apt-install hyperv-daemons"
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/sda"
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-hyperv"
  shutdown_command = "sudo /sbin/shutdown -h now"
  ssh_password     = var.ssh_pass
  ssh_port         = 22
  ssh_timeout      = var.ssh_timeout
  ssh_username     = var.ssh_user
  switch_name      = var.hyperv_switch_name
  vm_name          = local.vm_name
}

source "parallels-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.parallels_boot_mode],
    local.boot_parameter_submit[var.parallels_boot_mode]
  ))
  boot_wait              = var.boot_wait
  cpus                   = var.num_cpus
  disk_size              = var.disk_size
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/sda"
      }
    })
  }
  iso_checksum           = var.iso_checksum
  iso_urls               = local.iso_urls
  memory                 = var.mem_size
  output_directory       = "output/${local.vm_name}-parallels"
  parallels_tools_flavor = var.parallels_tools_flavor
  shutdown_command       = "sudo /sbin/shutdown -h now"
  ssh_password           = var.ssh_pass
  ssh_port               = 22
  ssh_timeout            = var.ssh_timeout
  ssh_username           = var.ssh_user
  vm_name                = local.vm_name
}

source "qemu" "default" {
  accelerator = var.qemu_accelerator
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.qemu_boot_mode],
    local.boot_parameter_submit[var.qemu_boot_mode]
  ))
  boot_wait           = var.boot_wait
  cpus                = var.num_cpus
  disk_compression    = true
  disk_interface      = "virtio"
  disk_size           = var.disk_size
  display             = var.qemu_display
  format              = "qcow2"
  headless            = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/vda"
      }
    })
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${local.vm_name}-qemu"
  qemu_binary         = var.qemu_binary
  shutdown_command    = "sudo /sbin/shutdown -h now"
  ssh_password        = var.ssh_pass
  ssh_port            = 22
  ssh_timeout         = var.ssh_timeout
  ssh_username        = var.ssh_user
  use_default_display = var.qemu_use_default_display
  vm_name             = local.vm_name
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
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/sda"
      }
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  output_directory     = "output/${local.vm_name}-virtualbox"
  shutdown_command     = "sudo /sbin/shutdown -h now"
  ssh_password         = var.ssh_pass
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_user
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--vram", "32"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = local.vm_name
}

source "vmware-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.vmware_boot_mode],
    local.boot_parameter_submit[var.vmware_boot_mode]
  ))
  boot_wait            = var.boot_wait
  cdrom_adapter_type   = var.vmware_cdrom_adapter_type
  cpus                 = var.num_cpus
  disk_adapter_type    = var.vmware_disk_adapter_type
  disk_size            = var.disk_size
  disk_type_id         = "0"
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/sda"
      }
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = var.vmware_network
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${local.vm_name}-vmware"
  shutdown_command     = "sudo /sbin/shutdown -h now"
  ssh_password         = var.ssh_pass
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_user
  version              = var.vmware_hardware_version
  vhv_enabled          = var.vmware_vhv_enabled
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.autodetect"           = var.vmware_svga_autodetect
    "usb_xhci.present"          = var.vmware_usb_xhci_present
  }
}

source "vmware-iso" "esxi" {
  boot_command = split("\n", format(join("\n", local.boot_command),
    local.boot_parameter_edit[var.esxi_boot_mode],
    local.boot_parameter_submit[var.esxi_boot_mode]
  ))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  disk_type_id         = "thin"
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/preseed.cfg.pkrtpl.hcl", {
      late_command = [
        "d-i preseed/late_command string \\",
        "    sed -i 's/^#PermitRootLogin /PermitRootLogin /' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^PermitRootLogin .*$/PermitRootLogin yes/' /target/etc/ssh/sshd_config; \\",
        "    sed -i 's/^\\(deb cdrom:.*\\)$/#\\1/' /target/etc/apt/sources.list"
      ],
      passwd = local.passwd,
      grub-installer = {
        "bootdev" = "string /dev/sda"
      }
    })
  }
  insecure_connection  = true
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "bridged"
  network_adapter_type = "e1000"
  network_name         = "VM Network"
  output_directory     = "${local.vm_name}"
  remote_datastore     = var.esxi_remote_datastore
  remote_host          = var.esxi_remote_host
  remote_password      = var.esxi_remote_password
  remote_type          = "esx5"
  remote_username      = var.esxi_remote_username
  shutdown_command     = "sudo /sbin/shutdown -h now"
  skip_export          = true
  ssh_password         = var.ssh_pass
  ssh_port             = 22
  ssh_timeout          = var.ssh_timeout
  ssh_username         = var.ssh_user
  vhv_enabled             = var.esxi_vhv_enabled
  vm_name              = local.vm_name
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "33554432"
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
      "ARANDR=arandr=0.1.11-2",
      "DWM=dwm=${var.dwm_version}",
      "INSTALL_FROM_DVD=${var.install_from_dvd}",
      "OPTIMISE_REPOS=1",
      "STTERM=stterm=0.9.2-1",
      "SUCKLESS_TOOLS=suckless-tools=${var.suckless_tools_version}",
      "VAGRANT_SSH_PUBLIC_KEY=${var.vagrant_ssh_public_key}",
      "VAGRANT_USERNAME=${var.vagrant_username}",
      "WGET=wget -O -",
      "XORG=xorg=1:7.7+24",
      "XRDP=xrdp=0.10.1-3.1"
    ]
    scripts = [
      "../provisioners/base_debian11+.sh",
      "../provisioners/vagrant.sh",
      "../provisioners/dwm.sh",
      "../provisioners/xrdp.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "INSTALL_DKMS=true",
      "VIRTUALBOX_WITH_XORG=1",
      "VBOX_VER=${var.virtualbox_version}"
    ]
    only = ["virtualbox-iso.default"]
    scripts = [
      "../provisioners/linux-headers.sh",
      "../provisioners/virtualbox.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools-desktop=2:12.5.0-2",
      "VMWARE_WITH_XORG=1",
      "XSERVER_XORG_INPUT_VMMOUSE=xserver-xorg-input-evdev=1:2.11.0-1",
      "XSERVER_XORG_VIDEO_VMWARE=xserver-xorg-video-vmware=1:13.4.0-1"
    ]
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmtools.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "PRL_TOOLS=prl-tools-${var.parallels_tools_flavor}.iso"
    ]
    only = [
      "parallels-iso.default"
    ]
    script = "../provisioners/parallels.sh"
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
      "virtualbox-iso.default"
    ]
    output = join("", [
      coalesce(var.vm_name, "./${local.vm_name}"),
      "-{{ .Provider }}.box"
    ])
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "vmware-iso.default"
    ]
    output = join("", [
      coalesce(var.vm_name, "./${local.vm_name}"),
      "-{{ .Provider }}.box"
    ])
    vagrantfile_template = "../vagrantfiles/Vagrantfile.debian11+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only                = ["qemu.default"]
    output = join("", [
      coalesce(var.vm_name, "./${local.vm_name}"),
      "-{{ .Provider }}.box"
    ])
  }
}
