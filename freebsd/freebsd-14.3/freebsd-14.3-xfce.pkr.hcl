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

variable "ABI" {
  type    = string
  default = "FreeBSD:14:amd64"
}

variable "DISTRIBUTIONS" {
  type    = string
  default = "'base.txz kernel.txz lib32.txz'"
}

variable "arandr_version" {
  type        = string
  default     = "0.1.11_2"
  description = "Version of `arandr` package."
}

variable "arch" {
  type        = string
  default     = "amd64"
  description = "Architecture name"
}

variable "boot_wait" {
  type        = string
  default     = "10s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_version" {
  type    = string
  default = "3.20250516"
}

variable "ca_root_nss_version" {
  type        = string
  default     = "3.108"
  description = "Version of `ca_root_nss` package."
}

variable "disk_size" {
  type        = string
  default     = "51200"
  description = "Disk size of the creating VM."
}

variable "doas_version" {
  type        = string
  default     = "opendoas-6.8.2"
  description = "Version of `doas` package."
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

variable "hyperv_netif" {
  type        = string
  default     = "hn0"
  description = "Network interface for Hyper-V box."
}

variable "hyperv_partition" {
  type        = string
  default     = "da0"
  description = "Disk name for Hyper-V box."
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Network switch name on Packer Hyper-V builder."
}

variable "iso_checksum" {
  type        = string
  default     = "file:https://download.freebsd.org/releases/ISO-IMAGES/14.3/CHECKSUM.SHA256-FreeBSD-14.3-BETA3-amd64"
  description = "SHA256 checksum of the install media."
}

variable "iso_name" {
  type        = string
  default     = "FreeBSD-14.3-BETA3-amd64-disc1.iso"
  description = "File name of the install media."
}

variable "iso_path" {
  type        = string
  default     = "releases/ISO-IMAGES/14.3"
  description = "Relative path to search the install media."
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

variable "open_vm_tools_version" {
  type        = string
  default     = "12.5.0_1,2"
  description = "Version of `open-vm-tools` package."
}

variable "parallels_netif" {
  type        = string
  default     = "vtnet0"
  description = "Network interface for Parallels box."
}

variable "parallels_partition" {
  type        = string
  default     = "ada0"
  description = "Disk name for Parallels box."
}

variable "qemu_accelerator" {
  type    = string
  default = "kvm"
}

variable "qemu_binary" {
  type        = string
  default     = "qemu-system-x86_64"
  description = "Name of QEMU binary"
}

variable "qemu_display" {
  type        = string
  default     = ""
  description = "Value for `-display` option for QEMU."
}

variable "qemu_machine_type" {
  type    = string
  default = "pc"
}

variable "qemu_netif" {
  type        = string
  default     = "vtnet0"
  description = "Network interface for QEMU box."
}

variable "qemu_partition" {
  type        = string
  default     = "vtbd0"
  description = "Disk name for QEMU box."
}

variable "qemu_use_default_display" {
  type        = string
  default     = "true"
  description = "Do not pass `-display` option to QEMU if `true`."
}

variable "root_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for `root` user."
}

variable "slim_version" {
  type        = string
  default     = "1.3.6_26"
  description = "Version of `slim` package."
}

variable "ssh_timeout" {
  type        = string
  default     = "60m"
  description = "SSH timeout to connect this box being created."
}

variable "vagrant_group" {
  type        = string
  default     = "vagrant"
  description = "Group name that `vagrant_username` belongs to."
}

variable "vagrant_password" {
  type        = string
  default     = "vagrant"
  sensitive   = false
  description = "Password for `vagrant_username`.  This is also used for SSH password during build time."
}

variable "vagrant_username" {
  type        = string
  default     = "vagrant"
  description = "User name used for runtime.  This is also used for SSH user name during build time."
}

variable "variant" {
  type    = string
  default = "xfce"
}

variable "virtualbox_guest_os_type" {
  type        = string
  default     = "FreeBSD_64"
  description = "Guest OS type of VirtualBox box."
}

variable "virtualbox_netif" {
  type        = string
  default     = "em0"
  description = "Network interface for VirtualBox box."
}

variable "virtualbox_partition" {
  type        = string
  default     = "ada0"
  description = "Disk name for VirtualBox box."
}

variable "vm_name" {
  type        = string
  default     = "FreeBSD-14.3-BETA"
  description = "VM name of the creating box."
}

variable "vmware_disk_adapter_type" {
  type        = string
  default     = "scsi"
  description = "Disk adapter type for VMware box."
}

variable "vmware_guest_os_type" {
  type        = string
  default     = "freebsd-64"
  description = "Guest OS type of VMware box."
}

variable "vmware_hardware_version" {
  type        = string
  default     = "13"
  description = "Hardware version for VMware box."
}

variable "vmware_netif" {
  type        = string
  default     = "em0"
  description = "Network interface name for VMware box."
}

variable "vmware_network_adapter_type" {
  type        = string
  default     = "e1000"
  description = "Network adapter type for VMware box."
}

variable "vmware_partition" {
  type    = string
  default = "da0"
}

variable "xrdp_version" {
  type        = string
  default     = "0.10.3,1"
  description = "Version of `xrdp` package."
}

variable "xterm_version" {
  type        = string
  default     = "397_2"
  description = "Version of `xterm` package."
}

locals {
  boot_command = [
    "%s",
    "<wait10><wait10><wait10><wait10>",
    "s",
    "<wait5>",
    "dhclient %s<enter><wait5>",
    "fetch -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
    "<wait>",
    "bsdinstall script /tmp/install.sh<enter>",
    "<wait10><wait10><wait10><wait10><wait10><wait10>"
  ]
  first_boot_command = (var.arch == "aarch64") ? "" : "<enter>"
  iso_urls = [
    "./iso/${var.iso_name}",
    "https://download.freebsd.org/${var.iso_path}/${var.iso_name}",
    "http://ftp.jp.freebsd.org/pub/FreeBSD/${var.iso_path}/${var.iso_name}",
    "http://ftp6.jp.freebsd.org/pub/FreeBSD/${var.iso_path}/${var.iso_name}",
    "http://ftp11.freebsd.org/pub/FreeBSD/${var.iso_path}/${var.iso_name}",
    "https://ftp4.tw.freebsd.org/pub/FreeBSD/${var.iso_path}/${var.iso_name}"
  ]
}

source "hyperv-iso" "default" {
  boot_command = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.hyperv_netif))
  boot_wait    = var.boot_wait
  cpus         = var.num_cpus
  disk_size    = var.disk_size
  headless     = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.hyperv_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.hyperv_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-hyperv"
  shutdown_command = "shutdown -p now"
  ssh_password     = var.root_password
  ssh_username     = "root"
  ssh_timeout      = var.ssh_timeout
  switch_name      = var.hyperv_switch_name
  vm_name          = "${var.vm_name}-${var.variant}-v${var.box_version}"
}

source "parallels-iso" "default" {
  boot_command  = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.parallels_netif))
  boot_wait     = var.boot_wait
  cpus          = "${var.num_cpus}"
  disk_size     = "${var.disk_size}"
  disk_type     = "expand"
  guest_os_type = "freebsd"
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.parallels_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.parallels_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  iso_checksum           = "${var.iso_checksum}"
  iso_urls               = local.iso_urls
  memory                 = "${var.mem_size}"
  output_directory       = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-parallels"
  parallels_tools_flavor = "other"
  parallels_tools_mode   = "disable"
  shutdown_command       = "shutdown -p now"
  ssh_password           = "${var.root_password}"
  ssh_username           = "root"
  ssh_timeout            = var.ssh_timeout
  vm_name                = "${var.vm_name}-${var.variant}-v${var.box_version}"
}

source "qemu" "default" {
  accelerator      = var.qemu_accelerator
  boot_command     = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.qemu_netif))
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
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.qemu_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.qemu_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  iso_checksum        = var.iso_checksum
  iso_urls            = local.iso_urls
  machine_type        = var.qemu_machine_type
  memory              = var.mem_size
  net_device          = "virtio-net"
  output_directory    = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-qemu"
  qemu_binary         = var.qemu_binary
  shutdown_command    = "shutdown -p now"
  ssh_password        = var.root_password
  ssh_username        = "root"
  ssh_timeout         = var.ssh_timeout
  use_default_display = var.qemu_use_default_display
  vm_name             = "${var.vm_name}-${var.variant}-v${var.box_version}"
}

source "virtualbox-iso" "default" {
  boot_command         = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.virtualbox_netif))
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = var.virtualbox_guest_os_type
  headless             = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.virtualbox_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.virtualbox_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-virtualbox"
  shutdown_command = "shutdown -p now"
  ssh_password     = var.root_password
  ssh_timeout      = var.ssh_timeout
  ssh_username     = "root"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"],
    ["modifyvm", "{{ .Name }}", "--vram", "16"]
  ]
  vm_name = "${var.vm_name}-${var.variant}-v${var.box_version}"
}

source "vmware-iso" "default" {
  boot_command      = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.vmware_netif))
  boot_wait         = var.boot_wait
  cpus              = var.num_cpus
  disk_adapter_type = var.vmware_disk_adapter_type
  disk_size         = var.disk_size
  disk_type_id      = "0"
  guest_os_type     = var.vmware_guest_os_type
  headless          = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.vmware_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.vmware_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "nat"
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-vmware"
  shutdown_command     = "shutdown -p now"
  ssh_password         = var.root_password
  ssh_timeout          = var.ssh_timeout
  ssh_username         = "root"
  usb                  = true
  version              = var.vmware_hardware_version
  vm_name              = "${var.vm_name}-${var.variant}-v${var.box_version}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "16777216"
    "usb_xhci.present"          = "TRUE"
    "vhv.enable"                = "TRUE"
  }
}

source "vmware-iso" "esxi" {
  boot_command  = split("\n", format(join("\n", local.boot_command), local.first_boot_command, var.vmware_netif))
  boot_wait     = var.boot_wait
  cpus          = var.num_cpus
  disk_size     = var.disk_size
  disk_type_id  = "thin"
  guest_os_type = var.vmware_guest_os_type
  headless      = var.headless
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      "variables" = {
        "BSDINSTALL_DISTSITE"     = "/usr/freebsd-dist"
        "DISTRIBUTIONS"           = var.DISTRIBUTIONS
        "export ZFSBOOT_DISKS"    = var.vmware_partition
        "export nonInteractive"   = "YES"
        "export ABI"              = var.ABI
        "export CA_ROOT_NSS"      = "ca_root_nss-${var.ca_root_nss_version}"
        "export DOAS"             = var.doas_version
        "export NETIF"            = var.vmware_netif
        "export ROOT_PASSWORD"    = var.root_password
        "export VAGRANT_USER"     = var.vagrant_username
        "export VAGRANT_PASSWORD" = var.vagrant_password
        "export VAGRANT_GROUP"    = var.vagrant_group
      },
      "make_conf" = {
        "WITHOUT_X11" = ""
      }
    })
  }
  insecure_connection  = true
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "bridged"
  network_adapter_type = "e1000"
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-esxi"
  remote_datastore     = var.esxi_remote_datastore
  remote_host          = var.esxi_remote_host
  remote_password      = var.esxi_remote_password
  remote_type          = "esx5"
  remote_username      = var.esxi_remote_username
  shutdown_command     = "shutdown -p now"
  skip_export          = true
  ssh_password         = var.root_password
  ssh_timeout          = var.ssh_timeout
  ssh_username         = "root"
  version              = var.esxi_hardware_version
  vm_name              = "${var.vm_name}-${var.variant}-v${var.box_version}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.networkName"     = "VM Network"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "svga.vramSize"             = "16777216"
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
      "ARANDR=arandr-${var.arandr_version}",
      "ROOT_PASSWORD=${var.root_password}",
      "SLIM=slim-${var.slim_version}",
      "SLIM_THEMES=slim-themes-1.0.1_2",
      "TWM=twm-1.0.12_1",
      "VAGRANT_GROUP=${var.vagrant_group}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "VAGRANT_USER=${var.vagrant_username}",
      "XCLOCK=xclock-1.0.9_1",
      "XFCE=xfce-4.20",
      "XORG_MINIMAL=xorg-minimal-7.5.2_3",
      "XRANDR=xrandr-1.5.2_1",
      "XRDP=xrdp-${var.xrdp_version}",
      "XTERM=xterm-${var.xterm_version}"
    ]
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    scripts = [
      "../provisioners/vagrant-11.1+.sh",
      "../provisioners/xorg.sh",
      "../provisioners/xfce.sh",
      "../provisioners/slim.sh",
      "../provisioners/xrdp.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "PARALLELS_WITH_XORG=yes",
      "XF86_VIDEO_SCFB=xf86-video-scfb-0.0.7_2"
    ]
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    only = [
      "parallels-iso.default"
    ]
    script = "../provisioners/parallels.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "VIRTUALBOX_OSE_ADDITIONS=virtualbox-ose-additions-nox11-6.1.50.1402000_1"
    ]
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    only = [
      "virtualbox-iso.default"
    ]
    script = "../provisioners/virtualbox_ose_additions-10.4+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools-nox11-${var.open_vm_tools_version}",
      "VMWARE_WITH_XORG=1",
      "XF86_INPUT_VMMOUSE=xf86-input-vmmouse-13.1.0_7",
      "XF86_VIDEO_VMWARE=xf86-video-vmware-13.3.0_8"
    ]
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    only = [
      "vmware-iso.default",
      "vmware-iso.esxi"
    ]
    script = "../provisioners/vmware-guest.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    script          = "../provisioners/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "parallels-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.FreeBSD-13.2+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_version}-${var.arch}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.FreeBSD-13.2+"
  }
}
