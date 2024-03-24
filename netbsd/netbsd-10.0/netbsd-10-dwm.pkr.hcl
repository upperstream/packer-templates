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
      version = ">= 1.0.10"
      source  = "github.com/hashicorp/qemu"
    }
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
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

variable "arch" {
  type    = string
  default = "amd64"
}

variable "boot_wait" {
  type        = string
  default     = "5s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_ver" {
  type    = string
  default = "4.20240207"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "dist_server" {
  type    = string
  default = "http://cdn.netbsd.org"
}

variable "esxi_disk_name" {
  type    = string
  default = "sd0"
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
  type    = string
  default = "${env("ESXI_REMOTE_PASSWORD")}"
}

variable "esxi_remote_port" {
  type    = string
  default = "${env("ESXI_REMOTE_PORT")}"
}

variable "esxi_remote_username" {
  type    = string
  default = "${env("ESXI_REMOTE_USERNAME")}"
}

variable "esxi_vnc_over_websocket" {
  type    = string
  default = "true"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "hostname" {
  type    = string
  default = "vagrant"
}

variable "hyperv_disk_name" {
  type    = string
  default = "sd0"
}

variable "hyperv_gateway" {
  type        = string
  default     = "192.168.1.1"
  description = "IP address of the gateway and the name server for the VM being built with Hyper-V builder"
}

variable "hyperv_host_cidr" {
  type        = string
  default     = "192.168.1.2/24"
  description = "CIDR notation of the VM IP address being built with Hyper-V builder"
}

variable "hyperv_netif" {
  type        = string
  default     = "hvn0"
  description = "Network interface name of the VM being build with Hyper-V builder"
}

variable "hyperv_ssh_host" {
  type        = string
  default     = "192.168.1.2"
  description = "IP address of the VM being built with Hyper-V builder"
}

variable "hyperv_switch_name" {
  type        = string
  default     = "Default Switch"
  description = "Network switch name on Hyper-V builder"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://cdn.netbsd.org/pub/NetBSD/NetBSD-10.0_RC4/iso/SHA512"
}

variable "iso_file_name" {
  type    = string
  default = "NetBSD-10.0_RC4-amd64.iso"
}

variable "iso_path" {
  type    = string
  default = "NetBSD/NetBSD-10.0_RC4/images"
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
}

variable "mem_size" {
  type    = string
  default = "1024"
}

variable "num_cpus" {
  type    = string
  default = "2"
}

variable "os_ver" {
  type    = string
  default = "10"
}

variable "package_server" {
  type    = string
  default = "http://cdn.netbsd.org"
}

variable parallels_disk_name {
  type    = string
  default = "wd0"
}

variable "partition_name" {
  type        = string
  default     = "dk0"
  description = "Partition name of which NetBSD is install on"
}

variable "qemu_accelerator" {
  type    = string
  default = "kvm"
}

variable "qemu_binary" {
  type    = string
  default = "qemu-system-x86_64"
}

variable "qemu_disk_name" {
  type    = string
  default = "sd0"
}

variable "qemu_display" {
  type    = string
  default = ""
}

variable "qemu_use_default_display" {
  type    = string
  default = "true"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "vagrant_group" {
  type    = string
  default = "vagrant"
}

variable "vagrant_password" {
  type    = string
  default = "vagrant"
}

variable "vagrant_username" {
  type    = string
  default = "vagrant"
}

variable "variant" {
  type    = string
  default = "dwm"
}

variable "virtualbox_disk_name" {
  type    = string
  default = "wd0"
}

variable "virtualbox_guest_os_type" {
  type    = string
  default = "NetBSD_64"
}

variable "vm_name" {
  type    = string
  default = "NetBSD-10_RC-amd64"
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

variable "vmware_disk_name" {
  type    = string
  default = "sd0"
}

variable "vmware_guest_os_type" {
  type    = string
  default = "other-64"
}

variable "vmware_hardware_version" {
  type        = string
  default     = "9"
  description = "Virtual hardware verison of VMware box."
}

variable "vmware_network_adapter_type" {
  type        = string
  default     = "e1000"
  description = "Network adapter type for VMware box."
}

locals {
  boot_command_common = [
    "1<wait10><wait10><wait10><wait10>",                        # Welcome message
    "a<enter><wait>",                                           # Installation messages in English
    "${local.selector_keyboard_type[var.arch]}",                # Keyboard type - unchanged; skip for aarch64
    "a<enter><wait>",                                           # NetBSD-10.0 Install System - Install NewtBSD to hard disk
    "b<enter><wait>",                                           # Shall we continue? - Yes
    "a<enter><wait>",                                           # Available disks - sd0
    "a<enter><wait>",                                           # Select a parittioning scheme - GPT
    "${local.selector_partition_geometry[var.arch]}",           # Partition geometry - This is correct geometry; skip for aarch64
    "b<enter><wait>",                                           # Partition sizes - Use default partition sizes
    "x<enter><wait>",                                           # Review partition sizes - Partition sizes ok
    "b<enter><wait10><wait10><wait10>",                         # Shall we continue? - Yes
    "${local.selector_bootblocks[var.arch]}",                   # Select bootblocks - Use BIOS console; skip for aarch64
    "d<enter><wait>",                                           # Select distribution - Custom installation
    "${local.selector_compiler_tools[var.arch]}",               # Distribution sets - Compiler tools - f (i386: e)
    "${local.selector_manual_pages[var.arch]}",                 # Distribution sets - Manual pages - i (i386: h)
    "${local.selector_text_processors[var.arch]}",              # Distribution sets - Text processing tools - m (i386: l)
    "${local.selector_x11[var.arch]}",                          # Distribution sets - X11 sets - n (i386: m)
    "f<enter><wait>",                                           # Distribution sets - X11 sets - Select all the above sets
    "b<enter><wait>",                                           # Distribution sets - X11 sets - but X11 programming
    "x<enter><wait>",                                           # Distribution sets - X11 sets - Install selected X11 sets
    "x<enter><wait>",                                           # Distribution sets - Install selected sets
    "a<enter><wait10><wait10><wait10><wait10><wait10><wait10>", # Install from - CD-ROM
    "<wait10><wait10><wait10><wait10><wait10><wait10><wait10>", # Wait for installation
    "<enter><wait5>",                                           # Installation complete - Hit enter to continue
    "${var.ssh_password}<enter><wait>",                         # New password - root password
    "${var.ssh_password}<enter><wait>",                         # Weak password warning - root password
    "${var.ssh_password}<enter><wait5>",                        # Retype new password - root password
    "${local.selector_random_number_generator[var.arch]}",      # Random number generator; not now - only for aarch64
    "g<enter><wait>",                                           # Configure the additional items - Enable sshd
    "h<enter><wait>",                                           # Configure the additional items - Enable ntpd
    "k<enter><wait>",                                           # Configure the additional items - Enable xdm
    "x<enter><wait>",                                           # Configure the additional items - Finished configuring
    "<enter><wait10>",                                          # Hit enter to continue
    "x<enter><wait10>",                                         # Exit Install System
  ]
  install_script_common = [
    "dhcpcd<wait><enter><wait10><wait5>",
    "ftp -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<wait><enter><wait5>",
    "HTTPSERVER={{ .HTTPIP }}:{{ .HTTPPort }} DISK=%s PARTITION=%s HOSTNAME=${var.hostname} sh /tmp/install.sh<wait><enter><wait5>"
  ]
  iso_urls = compact([
    var.iso_url,
    "./iso/${var.iso_file_name}",
    "${var.dist_server}/pub/${var.iso_path}/${var.iso_file_name}"
  ])
  selector_keyboard_type = {
    "amd64" : "a<enter><wait>",
    "i386" : "a<enter><wait>",
    "aarch64" : ""
  }
  selector_partition_geometry = {
    "amd64" : "a<enter><wait>",
    "i386" : "a<enter><wait>",
    "aarch64" : ""
  }
  selector_bootblocks = {
    "amd64" : "a<enter><wait>",
    "i386" : "a<enter><wait>",
    "aarch64" : ""
  }
  selector_compiler_tools = {
    "amd64" : "f<enter><wait>",
    "i386" : "e<enter><wait>",
    "aarch64" : "f<enter><wait>"
  }
  selector_manual_pages = {
    "amd64" : "i<enter><wait>",
    "i386" : "h<enter><wait>",
    "aarch64" : "i<enter><wait>"
  }
  selector_text_processors = {
    "amd64" : "m<enter><wait>",
    "i386" : "l<enter><wait>",
    "aarch64" : "m<enter><wait>"
  }
  selector_x11 = {
    "amd64" : "n<enter><wait>",
    "i386" : "m<enter><wait>",
    "aarch64" : "n<enter><wait>"
  }
  selector_random_number_generator = {
    "amd64" : "",
    "i386" : "",
    "aarch64" : "x<enter><wait>"
  }
}

source "hyperv-iso" "default" {
  boot_command = concat(local.boot_command_common, [
    "ifconfig ${var.hyperv_netif} inet ${var.hyperv_host_cidr}<enter><wait5>",
    "ifconfig ${var.hyperv_netif} up<enter><wait10>",
    "ftp -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install_hyperv.sh<wait><enter><wait5>",
    "HTTPSERVER={{ .HTTPIP }}:{{ .HTTPPort }} DISK=${var.hyperv_disk_name} PARTITION=${var.partition_name} HOSTNAME=${var.hostname} HOST_CIDR=${var.hyperv_host_cidr} GATEWAY=${var.hyperv_gateway} NETIF=${var.hyperv_netif} sh /tmp/install.sh<wait><enter><wait5>"
  ])
  boot_wait        = var.boot_wait
  cpus             = var.num_cpus
  disk_size        = var.disk_size
  headless         = var.headless
  http_directory   = "."
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_ver}-hyperv"
  shutdown_command = "/sbin/shutdown -p now"
  ssh_host         = var.hyperv_ssh_host
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  ssh_wait_timeout = "10000s"
  switch_name      = var.hyperv_switch_name
  vm_name          = "${var.vm_name}-${var.variant}-v${var.box_ver}"
}

source "parallels-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.parallels_disk_name, var.partition_name))
  )
  boot_wait              = var.boot_wait
  cpus                   = var.num_cpus
  disk_size              = var.disk_size
  disk_type              = "expand"
  guest_os_type          = "other"
  http_directory         = "."
  iso_checksum           = var.iso_checksum
  iso_urls               = local.iso_urls
  memory                 = var.mem_size
  output_directory       = "output/${var.vm_name}-${var.variant}-v${var.box_ver}-parallels"
  parallels_tools_flavor = "other"
  parallels_tools_mode   = "disable"
  shutdown_command       = "/sbin/shutdown -p now"
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_timeout            = "10000s"
  vm_name                = "${var.vm_name}-${var.variant}-v${var.box_ver}"
}

source "qemu" "default" {
  accelerator = var.qemu_accelerator
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.qemu_disk_name, var.partition_name))
  )
  boot_wait        = var.boot_wait
  disk_interface   = "virtio-scsi"
  display          = var.qemu_display
  format           = "qcow2"
  headless         = var.headless
  http_directory   = "."
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  memory           = var.mem_size
  net_device       = "virtio-net-pci"
  output_directory = "output/${var.vm_name}-${var.variant}-v${var.box_ver}-qemu"
  qemu_binary      = var.qemu_binary
  qemuargs = [
    ["-smp", "cpus=1,maxcpus=${var.num_cpus},threads=${var.num_cpus}"],
    ["-device", "virtio-rng-pci"],
    ["-device", "virtio-scsi-pci,id=scsi0"],
    ["-device", "scsi-hd,bus=scsi0.0,drive=drive0"]
  ]
  shutdown_command    = "/sbin/shutdown -p now"
  ssh_password        = var.ssh_password
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = var.ssh_username
  use_default_display = var.qemu_use_default_display
  vm_name             = "${var.vm_name}-${var.variant}-v${var.box_ver}"
}

source "virtualbox-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.virtualbox_disk_name, var.partition_name))
  )
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
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_ver}-virtualbox"
  shutdown_command     = "/sbin/shutdown -p now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = var.ssh_username
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{ .Name }}", "--natdnsproxy1", "on"],
    ["modifyvm", "{{ .Name }}", "--rtcuseutc", "on"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}-${var.variant}-v${var.box_ver}"
}

source "vmware-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.vmware_disk_name, var.partition_name))
  )
  boot_wait            = var.boot_wait
  cdrom_adapter_type   = var.vmware_cdrom_adapter_type
  cpus                 = var.num_cpus
  disk_adapter_type    = var.vmware_disk_adapter_type
  disk_size            = var.disk_size
  disk_type_id         = "0"
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_directory       = "."
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "nat"
  network_adapter_type = var.vmware_network_adapter_type
  output_directory     = "output/${var.vm_name}-${var.variant}-v${var.box_ver}-vmware"
  shutdown_command     = "/sbin/shutdown -p now"
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = var.ssh_username
  version              = var.vmware_hardware_version
  vm_name              = "${var.vm_name}-${var.variant}-v${var.box_ver}"
  vmx_data = {
    "ethernet0.addressType"     = "generated"
    "ethernet0.present"         = "TRUE"
    "ethernet0.wakeOnPcktRcv"   = "FALSE"
    "remotedisplay.vnc.enabled" = "TRUE"
    "vhv.enable"                = "TRUE"
  }
}

source "vmware-iso" "esxi" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), var.esxi_disk_name, var.partition_name))
  )
  boot_wait            = var.boot_wait
  cpus                 = var.num_cpus
  disk_size            = var.disk_size
  disk_type_id         = "thin"
  guest_os_type        = var.vmware_guest_os_type
  headless             = var.headless
  http_directory       = "."
  insecure_connection  = true
  iso_checksum         = var.iso_checksum
  iso_urls             = local.iso_urls
  memory               = var.mem_size
  network              = "bridged"
  network_adapter_type = "e1000"
  output_directory     = "${var.vm_name}-${var.variant}-v${var.box_ver}"
  remote_datastore     = var.esxi_remote_datastore
  remote_host          = var.esxi_remote_host
  remote_password      = var.esxi_remote_password
  remote_type          = "esx5"
  remote_username      = var.esxi_remote_username
  shutdown_command     = "/sbin/shutdown -p now"
  skip_export          = true
  ssh_password         = var.ssh_password
  ssh_port             = 22
  ssh_timeout          = "10000s"
  ssh_username         = var.ssh_username
  vm_name              = "${var.vm_name}-${var.variant}-v${var.box_ver}"
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
    "source.parallels-iso.default",
    "source.qemu.default",
    "source.virtualbox-iso.default",
    "source.vmware-iso.default",
    "source.vmware-iso.esxi"
  ]

  provisioner "shell" {
    inline = [
      "echo \"PKG_PATH=${var.package_server}/pub/pkgsrc/packages/NetBSD/`uname -m`/10.0/All\" > /etc/pkg_install.conf"
    ]
    inline_shebang = "/bin/sh -ex"
  }

  provisioner "shell" {
    environment_vars = [
      "OPEN_VM_TOOLS=open-vm-tools-12.1.5nb1"
      #      "XF86_INPUT_VMMOUSE=xf86-input-vmmouse",
      #      "XF86_VIDEO_VMWARE=xf86-video-vmware"
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} PATH=$PATH:/usr/sbin {{ .Path }}"
    only = [
      "vmware-iso.*"
    ]
    script = "../provisioners/vmware-xorg_netbsd8+.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "DOAS=doas-6.3p2nb1",
      "DMENU=dmenu-5.2nb2",
      "DWM=dwm-6.4nb2",
      "RSYNC=rsync-3.2.7nb2",
      "ST_TERM=st-term-0.9nb2",
      "VAGRANT_GROUP=${var.vagrant_group}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "VAGRANT_USER=${var.vagrant_username}",
      "X11VNC=x11vnc-0.9.16nb15",
      "XRANDR=xrandr-1.5.2"
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} PATH=$PATH:/usr/sbin {{ .Path }}"
    scripts = [
      "../provisioners/vagrant_netbsd8+.sh",
      "../provisioners/dwm+st+dmenu_netbsd9.3+.sh"
    ]
  }

  provisioner "shell" {
    except = [
      "vmware-iso.esxi"
    ]
    script = "../provisioners/disk_cleanup.sh"
  }

  provisioner "shell" {
    environment_vars = [
      "ENABLE_DHCP=yes"
    ]
    script = "../provisioners/finalise.sh"
  }

  post-processor "vagrant" {
    compression_level = 9
    only = [
      "hyperv-iso.default",
      "parallels-iso.default",
      "virtualbox-iso.default",
      "vmware-iso.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_ver}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.NetBSD-9.3+"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    compression_level   = 9
    only = [
      "qemu.default"
    ]
    output               = "./${var.vm_name}-${var.variant}-v${var.box_ver}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.NetBSD-9.3+"
  }
}
