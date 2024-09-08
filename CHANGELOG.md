# Changelog

## [Unreleased][]

* Changed
  * debian-11: Upgrade templates to Debian 11.11 including the
    following changes:
    * ESXi:
      * Add `esxi_guest_os_type` and `esxi_hardware_version` variables
        so that these values can be different from those for VMware
        build.  Default values are `debian11-64` and `19` respectively.
    * QEMU:
      * Add `qemu_binary` variables so that QEMU binary name for
        creating x86 box can be set to `qemu-system-i386`.  Default
        value is of `qemu-system-x86_64`.
  * debian-12: Upgrade templates to Debian 12.7 including the following
    changes:
    * QEMU:
      * Add `qemu_binary` variables so that QEMU binary name for
        creating x86 box can be set to `qemu-system-i386`.  Default
        value is of `qemu-system-x86_64`.
    * VMware:
      * Virtual hardware version is now `13` as [Packer Plugin for
        VMware v1.1.0](https://github.com/hashicorp/packer-plugin-vmware/releases/tag/v1.1.0)
        requires the virtual hardware version `13` or greater.
      * Add `biosdevnames=0` kernel parameter to VMware box.
    * VirtualBox:
      * Guest OS Type is now `Debian12_64` or `Debian12` instead of
        `Debian_64` or `Debian` respectively.
  * freebsd-13.4: Upgrade templates to FreeBSD 13.4-RC2; use
    `release_4` branch for packages instead of `quarterly`.

## [20240818][]

* Added
  * freebsd-13.4: Templates for FreeBSD 13.4-BETA3.

* Changed
  * alpine-3.17: Upgrade templates to Alpine Linux 3.17.9.
  * alpine-3.18: Upgrade templates to Alpine Linux 3.18.8.

## [20240730][]

* Changed
  * alpine-3.19: Upgrade templates to Alpine Linux 3.19.3.

## [20240727][]

* Added
  * Add `CHANGELOG.md` file (this file) to record notable changes.

* Changed
  * alpine-3.20: Upgrade templates to Alpine Linux 3.20.2.

[Unreleased]: https://github.com/upperstream/packer-templates/compare/20240818...HEAD
[20240818]: https://github.com/upperstream/packer-templates/compare/20240730...20240818
[20240730]: https://github.com/upperstream/packer-templates/compare/20240727...20240730
[20240727]: https://github.com/upperstream/packer-templates/releases/tag/20240727
