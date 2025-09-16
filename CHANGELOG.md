# Changelog

## [20250916][]

* Added
  * [Debian 13](debian/debian-13/README.md): Add templates for Debian 13.1.
  * [Tiny Core Linux](tinycorelinux/README.md): Add templates for
    [Tiny Core Linux][] v16.1.
* Changed
  * Move [markdownlint][] settings from `.vscode/settings.json` to
    `.markdownlint.json`
  * [Alpine 3.19](alpine/alpine-3.19/README.md): Upgrade templates to
    Alpine Linux 3.19.8
  * [Alpine 3.20](alpine/alpine-3.20/README.md): Upgrade templates to
    Alpine Linux 3.20.7.
  * [Alpine 3.21](alpine/alpine-3.21/README.md): Upgrade templates to
    Alpine Linux 3.21.4.
  * [Alpine 3.22](alpine/alpine-3.22/README.md): Upgrade templates to
    Alpine Linux 3.22.1.
  * [Debian 12](debian/debian-12/README.md): Upgrade templates to
    Debian 12.12.
  * [Ubuntu 24.04](ubuntu/ubuntu-24.04/README.md): Upgrade templates to
    Ubuntu 24.04.3.
* Fixed
  * [Debian](debian/README.md): Provisioner for VMware did not work for
    amd64 VM images.

## [20250611][]

* Added
  * [Alpine](alpine/README.md): Add templates for [Alpine Linux 3.22.0](alpine/alpine-3.22/README.md).
  * [FreeBSD](freebsd/README.md): Add templates for [FreeBSD 14.3-RELEASE](freebsd/freebsd-14.3/README.md).
  * [OpenBSD](openbsd/README.md): Add templates for [OpenBSD 7.7](openbsd/openbsd-7.7/README.md).
* Changed
  * Updated Alpine Linux package version update instructions in `.clinerules`
  * [Arch Linux](archlinux/README.md) Update templates to Arch Linux
    2025.06.01.
  * [Debian 12](debian/README.md): Upgrade templates to Debian 12.11.
  * FreeBSD 14.3: Updated Packer templates to use new VM name format:
    {OS name and version}-{variant name}-v{box version}-{architecture}.
* Fixed
  * [Ubuntu](ubuntu/README.md): Fixed links for Ubuntu 24.04 in
    README.md ([GH-279]).

## [20250410][]

* Added
  * Add `.clinerules` file for Cline to work properly.
  * [Alpine](alpine/README.md): Add templates for [Alpine Linux
    3.21.3](alpine/alpine-3.21/README.md).
* Changed
  * [Alpine 3.17](alpine/alpine-3.17/README.md): Upgrade templates to
    Alpine Linux 3.17.10.  VM name format has CPU architecture last.
  * [Alpine 3.18](alpine/alpine-3.18/README.md): Upgrade templates to
    Alpine Linux 3.18.12.  VM name format has CPU architecture last.
  * [Alpine 3.19](alpine/alpine-3.19/README.md): Upgrade templates to
    Alpine Linux 3.19.7.  VM name format has CPU architecture last.
  * [Alpine 3.20](alpine/alpine-3.20/README.md): Upgrade templates to
    Alpine Linux 3.20.6.  VM name format has CPU architecture last.
  * [Arch Linux](archlinux/README.md): Hyper-V box stops using
    `hv_fcopy_daemon.service` since it was removed from Hyper-V package
    recent update.
  * Arch Linux: Upgrade templates to Arch Linux 2025.04.01.
  * [Debian 12](debian/debian-12/README.md): Upgrade templates to
    Debian 12.10.

## [20250311][]

* Changed
  * [FreeBSD 13.5](freebsd/freebsd-13.5/README.md): Upgrade templates
    to FreeBSD 13.5-RELEASE.
  * [NetBSD](netbsd/README.md): Correct typos in comments.
  * [NetBSD 10](netbsd/netbsd-10/README.md): Rename directory name from
    `netbsd-10.0` to `netbsd-10`.
  * NetBSD 10: Upgrade templates to NetBSD 10.1
  * [Debian 12](debian/debian-12/REAADME.md): Upgrade templates to
    Debian 12.9.
  * [Ubuntu 24.04](ubuntu/ubuntu-24.04/README.md): Upgrade templates to
    Ubuntu 24.04.2.

## [20250212][]

* Added
  * [FreeBSD](freebsd/README.md): Add templates for FreeBSD 13.5-BETA1.
* Changed
  * [FreeBSD 13.4](freebsd/freebsd-13.4/README.md): Fix README.md to
    correct Vagrant box filename for on Parallels.

## [20241203][]

* Changed
  * Update notation of [`CHANGELOG.md`](CHANGELOG.md) file (this file).
  * [FreeBSD 14.2](freebsd/freebsd-14.2/README.md): Upgrade templates
    to FreeBSD 14.2-RELEASE.

## [20241124][]

* Changed
  * FreeBSD: Correct the provisioner script for VMware build, which did
    not install video driver and mouse driver for amd64 VMware guest.
  * FreeBSD 14.2: Upgrade templates to FreeBSD 14.2-RC1.

## [20241106][]

* Added
  * FreeBSD: Add templates for FreeBSD 14.2-BETA1.
* Changed
  * [Ubuntu 22.04](ubuntu/ubuntu-22.04/README.md): Upgrade templates to
    Ubuntu 22.04.5 including the following changes:
    * Change naming convention for VM name and box file name so that
      box name can be easily made CPU independent:
      * VM name: `Ubuntu-22.04-{cpu}-{variant}` to `Ubuntu-22.04-{variant}`.
      * Box filename: `Ubuntu-22.04-{cpu}-{variant}-{boxversion}-{provider}.box`
        to `Ubuntu-22.04-{variant}-{boxversion}-{cpu}-{provider}.box`.
    * ESXi: Add `esxi_hardware_version` variable so that the virtual
      hardware version for ESXi build can be different from the one for
      VMware build.  Default value is `19`.
    * QEMU: Use default display instead of GTK.
    * VMware: Virtual hardware version is now `13` as [Packer Plugin
      for VMware v1.1.0][]
      requires the virtual hardware version `13` or greater.

## [20241015][]

* Added
  * [OpenBSD](openbsd/README.md): Add templates for [OpenBSD 7.6](openbsd/openbsd-7.6/README.md).
* Changed
  * [OpenBSD 7.5](openbsd/openbsd-7.5/README.md): Rename Vagrantfile
    template from `Vagrantfile.OpenBSD-7.5` to `Vagrantfile.OpenBSD-7.5+`.

## [20240919][]

* Changed
  * [FreeBSD 13.4](freebsd/freebsd-13.4/README.md): Upgrade templates to
    FreeBSD 13.4-RELEASE with the following changes:
    * Change naming convention for VM name and box file name so that
      box name can be easily made architecture independent:
      * VM name: `FreeBSD-13.4-RELEASE-{arch}-{variant}-{boxversion}` to
        `FreeBSD-13.4-RELEASE-{variant}-{boxversion}`.
      * Box filename:
        `FreeBSD-13.4-RELEASE-{arch}-{variant}-{boxversion}-{provider}.box`
        to `FreeBSD-13.4-RELEASE-{variant}-{boxversion}-{arch}-{provider}.box`.
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
        VMware v1.1.0][]
        requires the virtual hardware version `13` or greater.
  * [Ubuntu 24.04](ubuntu/ubuntu-24.04/README.md): Upgrade templates to
    Ubuntu 24.04.1 including the following changes:
    * Change naming convention for VM name and box file name so that
      box name can be easily made CPU independent:
      * VM name: `Ubuntu-24.04-{cpu}-{variant}` to
        `Ubuntu-24.04-{variant}`.
      * Box filename:
        `Ubuntu-24.04-{cpu}-{variant}-{boxversion}-{provider}.box` to
        `Ubuntu-24.04-{variant}-{boxversion}-{cpu}-{provider}.box`.
    * ESXi:
      * Add `esxi_guest_os_type` and `esxi_hardware_version` variables
        so that these values can be different from those for VMware
        build.  Default values are `ubuntu-64` and `19` respectively.
    * VMware:
      * Virtual hardware version is now `13` as [Packer Plugin for
        VMware v1.1.0][]
        requires the virtual hardware version `13` or greater.
    * QEMU:
      * Use default display instead of GTK.

## [20240908][]

* Changed
  * [Debian 11](debian/debian-11/README.md): Upgrade templates to
    Debian 11.11 including the following changes:
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
  * Debian 12: Upgrade templates to Debian 12.7 including the following
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
  * FreeBSD 13.4: Upgrade templates to FreeBSD 13.4-RC2; use
    `release_4` branch for packages instead of `quarterly`.

## [20240818][]

* Added
  * FreeBSD 13.4: Templates for FreeBSD 13.4-BETA3.
* Changed
  * [Alpine 3.17](alpine/alpine-3.17/README.md): Upgrade templates to
    Alpine Linux 3.17.9.
  * [Alpine 3.18](alpine/alpine-3.18/README.md): Upgrade templates to
    Alpine Linux 3.18.8.

## [20240730][]

* Changed
  * [Alpine 3.19](alpine/alpine-3.19/README.md): Upgrade templates to
    Alpine Linux 3.19.3.

## [20240727][]

* Added
  * Add `CHANGELOG.md` file (this file) to record notable changes.
* Changed
  * [Alpine 3.20](alpine/alpine-3.20/README.md): Upgrade templates to
    Alpine Linux 3.20.2.

[GH-279]: https://github.com/upperstream/packer-templates/pull/279
[markdownlint]: https://github.com/DavidAnson/markdownlint
[Packer Plugin for VMware v1.1.0]: https://github.com/hashicorp/packer-plugin-vmware/releases/tag/v1.1.0
[Tiny Core Linux]: http://tinycorelinux.net/

[20250916]:
  https://github.com/upperstream/packer-templates/compare/20250612...20250916
[20250611]:
  https://github.com/upperstream/packer-templates/compare/20250410...20250611
[20250410]:
  https://github.com/upperstream/packer-templates/compare/20250311...20250410
[20250311]:
  https://github.com/upperstream/packer-templates/compare/20250212...20250311
[20250212]:
  https://github.com/upperstream/packer-templates/compare/20241203...20250212
[20241203]:
  https://github.com/upperstream/packer-templates/compare/20241124...20241203
[20241124]:
  https://github.com/upperstream/packer-templates/compare/20241106...20241124
[20241106]:
  https://github.com/upperstream/packer-templates/compare/20241015...20241106
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
