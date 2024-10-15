# Changelog

## [Unreleased][]

* Changed
  * ubuntu-22.04
    * Change naming convention for VM name and box file name so that
      box name can be easily made CPU independent:
      * VM name: `Ubuntu-22.04-{cpu}-{variant}` to `Ubuntu-22.04-{variant}`
      * Box filename: `Ubuntu-22.04-{cpu}-{variant}-{boxversion}-{provider}.box`
        to `Ubuntu-22.04-{variant}-{boxversion}-{cpu}-{provider}.box`
    * ESXi: Add `esxi_hardware_version` variable so that the virtual
      hardware version for ESXi build can be different from the one for
      VMware build.  Default value is `19`.
    * QEMU: Use default display instead of GTK
    * VMware: Virtual hardware version is now `13` as [Packer Plugin
      for VMware v1.1.0](https://github.com/hashicorp/packer-plugin-vmware/releases/tag/v1.1.0)
      requires the virtual hardware version `13` or greater.

## [20241015][]

* Added
  * OpenBSD: Add templates for OpenBSD 7.6
* Changed
  * openbsd-7.5: Rename Vagrantfile template from
    `Vagrantfile.OpenBSD-7.5` to `Vagrantfile.OpenBSD-7.5+`

## [20240919][]

* Changed
  * freebsd-13.4: Upgrade templates to FreeBSD 13.4-RELEASE with the
    following changes:
    * Change naming convention for VM name and box file name so that
      box name can be easily made architecture independent:
      * VM name: `FreeBSD-13.4-RELEASE-{arch}-{variant}-{boxversion}` to
        `FreeBSD-13.4-RELEASE-{variant}-{boxversion}`
      * Box filename:
        `FreeBSD-13.4-RELEASE-{arch}-{variant}-{boxversion}-{provider}.box`
        to `FreeBSD-13.4-RELEASE-{variant}-{boxversion}-{arch}-{provider}.box`
    * Add `ssh_timeout` to define SSH timeout, whose default value is
      `60m`.
    * Rename `iso_image` variable to `iso_name`.
    * Rename `path_to_iso` variable to `iso_path`.
    * ESXi
      * Add `esxi_hardware_version` variable so that the virtual
        hardware version for ESXi build can be different from the one
        for VMware build.  Default value is `19`.
    * VMware:
      * Virtual hardware version is now `13` as [Packer Plugin for
        VMware v1.1.0](https://github.com/hashicorp/packer-plugin-vmware/releases/tag/v1.1.0)
        requires the virtual hardware version `13` or greater.
  * ubuntu-24.04: Upgrade templates to Ubuntu 24.04.1 including the
    following changes:
    * Change naming convention for VM name and box file name so that
      box name can be easily made CPU independent:
      * VM name: `Ubuntu-24.04-{cpu}-{variant}` to
        `Ubuntu-24.04-{variant}`
      * Box filename:
        `Ubuntu-24.04-{cpu}-{variant}-{boxversion}-{provider}.box` to
        `Ubuntu-24.04-{variant}-{boxversion}-{cpu}-{provider}.box`
    * ESXi:
      * Add `esxi_guest_os_type` and `esxi_hardware_version` variables
        so that these values can be different from those for VMware
        build.  Default values are `ubuntu-64` and `19` respectively.
    * VMware:
      * Virtual hardware version is now `13` as [Packer Plugin for
        VMware v1.1.0](https://github.com/hashicorp/packer-plugin-vmware/releases/tag/v1.1.0)
        requires the virtual hardware version `13` or greater.
    * QEMU:
      * Use default display instead of GTK

## [20240908][]

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
    * VirtualBox:
      * Guest OS Type is now `Debian11_64` or `Debian11` instead of
        `Debian_64` or `Debian` respectively.
    * VMware:
      * Virtual hardware version is now `13` as Packer Plugin for
        VMware v1.1.0 requires the virtual hardware version `13` or
        greater.
  * debian-12: Upgrade templates to Debian 12.7 including the following
    changes:
    * QEMU:
      * Add `qemu_binary` variables so that QEMU binary name for
        creating x86 box can be set to `qemu-system-i386`.  Default
        value is of `qemu-system-x86_64`.
    * VirtualBox:
      * Guest OS Type is now `Debian12_64` or `Debian12` instead of
        `Debian_64` or `Debian` respectively.
    * VMware:
      * Virtual hardware version is now `13` as Packer Plugin for
        VMware v1.1.0 requires the virtual hardware version `13` or
        greater.
      * Add `biosdevnames=0` kernel parameter to VMware box.
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

[Unreleased]:
  https://github.com/upperstream/packer-templates/compare/20241015...HEAD
[20241015]:
  https://github.com/upperstream/packer-templates/compare/20240919...20241015
[20240919]:
  https://github.com/upperstream/packer-templates/compare/20240908...20240919
[20240908]:
  https://github.com/upperstream/packer-templates/compare/20240818...20240908
[20240818]:
  https://github.com/upperstream/packer-templates/compare/20240730...20240818
[20240730]:
  https://github.com/upperstream/packer-templates/compare/20240727...20240730
[20240727]:
  https://github.com/upperstream/packer-templates/releases/tag/20240727
