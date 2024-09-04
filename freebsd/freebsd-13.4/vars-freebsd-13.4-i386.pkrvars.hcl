arch = "i386"
iso_image = "FreeBSD-13.4-RC2-i386-disc1.iso"
iso_checksum = "file:https://download.freebsd.org/releases/ISO-IMAGES/13.4/CHECKSUM.SHA256-FreeBSD-13.4-RC2-i386"
qemu_binary = "qemu-system-i386"
virtualbox_guest_os_type = "FreeBSD"
vmware_guest_os_type = "freebsd"
DISTRIBUTIONS = "'base.txz kernel.txz'"
ABI = "FreeBSD:13:i386"
vm_name = "FreeBSD-13.4-RC-i386"