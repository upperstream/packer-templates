iso_checksum = "file:https://cdimages.ubuntu.com/ubuntu/releases/22.04.3/release/SHA256SUMS"
iso_name = "ubuntu-22.04.3-live-server-arm64.iso"
parallels_tools_flavor = "lin-arm"
parallels_boot_command = [
  "<wait>e<down><down><down><down><left><left><left><left><bs><bs><bs><bs><bs><bs>autoinstall <wait>ds='nocloud-net;<wait>s=http://{{.HTTPIP}}:<wait>{{.HTTPPort}}/' <wait>net.ifnames=0 biosdevnames=0 <wait5><f10>"
]
vm_name_base = "Ubuntu-22.04-arm64"
vmware_boot_mode = "efi"
vmware_cdrom_adapter_type = "sata"
vmware_disk_adapter_type = "sata"
vmware_guest_os_type = "arm-ubuntu-64"
vmware_hardware_version = "20"
vmware_network_adapter_type = "e1000e"
vmware_boot_command = [
  "<wait>e<down><down><down><down><left><left><left><left><bs><bs><bs><bs><bs><bs>autoinstall <wait>ds='nocloud-net;<wait>s=http://{{.HTTPIP}}:<wait>{{.HTTPPort}}/' <wait>net.ifnames=0 biosdevnames=0 <wait5><f10>"
]
