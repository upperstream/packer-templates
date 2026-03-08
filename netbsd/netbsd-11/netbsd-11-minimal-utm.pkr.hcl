packer {
  required_version = ">= 1.7.0"
  required_plugins {
    utm = {
      version = ">=v4.0.0"
      source  = "github.com/naveenrajm7/utm"
    }
  }
}

variable "arch" {
  type    = string
  default = "amd64"
}

variable "boot_wait" {
  type        = string
  default     = "10s"
  description = "Override `boot_wait` default setting (10s)"
}

variable "box_ver" {
  type    = string
  default = "2.20260306"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "dist_server" {
  type    = string
  default = "http://cdn.netbsd.org"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "hostname" {
  type    = string
  default = "vagrant"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://cdn.netbsd.org/pub/NetBSD/images/11.0_RC2/SHA512"
}

variable "iso_file_name" {
  type    = string
  default = "NetBSD-11.0_RC2-amd64.iso"
}

variable "iso_path" {
  type    = string
  default = "NetBSD/images/11.0_RC2"
}

variable "iso_url" {
  type        = string
  default     = null
  description = "Full path to the install media.  This URL will be the first preference if set."
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
  default = "11"
}

variable "package_arch" {
  type        = string
  default     = "amd64"
  description = "Architecture for binary packages."
}

variable "package_branch" {
  type        = string
  default     = "11.0_2025Q4"
  description = "pkgsrc branch name for binary packages."
}

variable "package_server" {
  type    = string
  default = "http://cdn.netbsd.org"
}

variable "partition_name" {
  type        = string
  default     = "dk0"
  description = "Partition name of which NetBSD is install on"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "utm_keep_registered" {
  type    = bool
  default = false
  description = "Set this to true to keep the VM registered with UTM"
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
  default = "minimal"
}

variable "vm_name" {
  type    = string
  default = "NetBSD-11_RC"
}

locals {
  boot_command_common = [
    "1<wait10><wait10><wait5>",                       # Welcome message
    "a<wait><enter><wait>",                           # Installation messages in English
    "${local.selector_keyboard_type[var.arch]}",      # Keyboard type - US English; skip for aarch64
    "a<wait><enter><wait>",                           # NetBSD-11.0 Install System - Install NewtBSD to hard disk
    "b<wait><enter><wait>",                           # Shall we continue? - Yes
    "a<wait><enter><wait>",                           # Available disks - sd0
    "a<wait><enter><wait>",                           # Select a partitioning scheme - GPT
    "${local.selector_partition_geometry[var.arch]}", # Partition geometry - This is correct geometry; skip for aarch64
    "b<wait><enter><wait>",                           # Partition sizes - Use default partition sizes
    "x<wait><enter><wait>",                           # Review partition sizes - Partition sizes ok
    "b<enter><wait10><wait10><wait10>",               # Shall we continue? - Yes
    "${local.selector_bootblocks[var.arch]}",         # Select bootblocks - Use BIOS console; skip for aarch64
    "d<wait><enter><wait>",                           # Select distribution - Custom installation
    "${local.selector_manual_pages[var.arch]}",       # Distribution sets - Manual pages - i (i386: h)
    "${local.selector_text_processors[var.arch]}",    # Distribution sets - Text processing tools - m (i386: l) aarch64 - n
    "x<wait><enter><wait>",                           # Distribution sets - Install selected sets
    "a<enter><wait10><wait10><wait10><wait10>",       # Install from - CD-ROM
    #    "${local.wait_for_MAKEDEV[var.arch]}",                        # /bin/sh MAKEDEV all - Hit enter to continue; aarch64 only
    #    "${local.wait_for_certctl[var.arch]}",                        # /usr/sbin/certctl rehash - Hit enter to continue; aarch64 only
    "<wait5><enter><wait5>",                        # The extraction of the selected sets for NetBSD is complete - Hit Enter to continue
    "${var.ssh_password}<wait><enter><wait>",       # New password - root password
    "${var.ssh_password}<wait><enter><wait>",       # Weak password warning - root password
    "${var.ssh_password}<wait><enter><wait><wait>", # Retype new password - root password
    #    "${local.selector_random_number_generator[var.arch]}<wait5>", # Random number generator; not now - only for aarch64
    "g<wait><enter><wait>",  # Configure the additional items - Enable sshd
    "h<wait><enter><wait>",  # Configure the additional items - Enable ntpd
    "x<wait><enter><wait>",  # Configure the additional items - Finished configuring
    "<wait><enter><wait5>",  # Hit enter to continue
    "x<wait><enter><wait5>", # Exit Install System
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
    "amd64" : "b<wait><enter><wait>",
    "i386" : "b<wait><enter><wait>",
    "aarch64" : ""
  }
  selector_partition_geometry = {
    "amd64" : "a<wait><enter><wait>",
    "i386" : "a<wait><enter><wait>",
    "aarch64" : ""
  }
  selector_bootblocks = {
    "amd64" : "a<wait><enter><wait>",
    "i386" : "a<wait><enter><wait>",
    "aarch64" : ""
  }
  selector_manual_pages = {
    "amd64" : "j<wait><enter><wait>",
    "i386" : "h<wait><enter><wait>",
    "aarch64" : "i<wait><enter><wait>"
  }
  selector_text_processors = {
    "amd64" : "o<wait><enter><wait>",
    "i386" : "m<wait><enter><wait>",
    "aarch64" : "n<wait><enter><wait>"
  }
  selector_random_number_generator = {
    "amd64" : "",
    "i386" : "",
    "aarch64" : "x<wait><enter><wait>"
  }
  selector_install_script = {
    "generic" : [
      "cat >> /mnt/etc/rc.conf << EOF",
      "#critical_filesystems_local=/var",
      "dhcpcd=YES",
      "rpcbind=YES",
      "#nfs_client=YES",
      "no_swap=YES",
      "lockd=YES",
      "statd=YES",
      "hostname=\"$HOSTNAME\"",
      "EOF",
    ],
    "hyperv" : [
      "cat >> /mnt/etc/rc.conf << EOF",
      "#critical_filesystems_local=/var",
      "dhcpcd=YES",
      "rpcbind=YES",
      "#nfs_client=YES",
      "no_swap=YES",
      "lockd=YES",
      "statd=YES",
      "hostname=$HOSTNAME",
      "ifconfig_$NETIF=\"inet $HOST_CIDR\"",
      "defaultroute=$GATEWAY",
      "EOF",
      "echo \"nameserver $GATEWAY\" > /mnt/etc/resolv.conf"
    ]
  }
  wait_for_MAKEDEV = {
    "amd64" : "",
    "i386" : ""
    "aarch64" : "<enter><wait5>"
  }
  wait_for_certctl = {
    "amd64" : "",
    "i386" : ""
    "aarch64" : "<enter><wait5>"
  }
  vm_name = "${var.vm_name}-${var.variant}-v${var.box_ver}-${var.arch}"
}

source "utm-iso" "default" {
  boot_command = concat(
    local.boot_command_common,
    split("\n", format(join("\n", local.install_script_common), "ld4", var.partition_name))
  )
  boot_nopause          = true
  boot_wait             = var.boot_wait
  cpus                  = var.num_cpus
  display_hardware_type = "virtio-gpu-pci"
  display_nopause       = true
  disk_size             = var.disk_size
  export_nopause        = true
  guest_additions_mode  = "disable"
  http_content = {
    "/install.sh" = templatefile("${path.root}/install.sh.pkrtpl.hcl", {
      lines = local.selector_install_script["generic"]
    })
  }
  hypervisor       = true
  iso_checksum     = var.iso_checksum
  iso_urls         = local.iso_urls
  keep_registered  = var.utm_keep_registered
  memory           = var.mem_size
  output_directory = "output/${local.vm_name}-utm"
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  shutdown_command = "/sbin/shutdown -p now"
  uefi_boot        = true
  vm_backend       = "qemu"
  vm_icon          = "netbsd"
  vm_name          = "${local.vm_name}"
}

build {
  sources = [
    "source.utm-iso.default"
  ]

  provisioner "shell" {
    inline = [
      "echo \"PKG_PATH=${var.package_server}/pub/pkgsrc/packages/NetBSD/${var.package_arch}/${var.package_branch}/All\" > /etc/pkg_install.conf"
    ]
    inline_shebang = "/bin/sh -ex"
  }

  provisioner "shell" {
    environment_vars = [
      "DOAS=doas-6.3p2nb1",
      "RSYNC=rsync-3.4.1",
      "VAGRANT_GROUP=${var.vagrant_group}",
      "VAGRANT_PASSWORD=${var.vagrant_password}",
      "VAGRANT_USER=${var.vagrant_username}"
    ]
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} PATH=$PATH:/usr/sbin {{ .Path }}"
    script          = "../provisioners/vagrant_netbsd8+.sh"
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

  post-processor "utm-vagrant" {
    compression_level = 9
    only = [
      "utm-iso.default"
    ]
    output               = "./${local.vm_name}-{{ .Provider }}.box"
    vagrantfile_template = "../vagrantfiles/Vagrantfile.NetBSD-8.3+"
    architecture         = "arm64"
  }
}
