---
name: openbsd-update-packages
description: Update package versions in templates for OpenBSD
---

# Instructions for OpenBSD templates

When instructed to updata package versions in for templates for OpenBSD
(sitting in any directories in `openbsd/`) to use the latest available
version of the packages, do the following:

1. Examine the `provisioner "shell"` blocks within the relevant
   `.pkr.hcl` files.
2. Identify any packages installed with **hardcoded versions** specified
   in the `environment_vars` (e.g., `PACKAGE_NAME=package=1.2.3`).
   Packages installed without an explicit version (e.g., `pkg_add package`)
   do not need manual version updates, as `pkg_add` will fetch the
   latest during the build.
3. For each package with a hardcoded version:
   * Determine the target OpenBSD version (e.g., `7.7`) and relevant
     architecture (e.g., `amd64`, `arm64`) based on the template context.
   * Construct the URL for the package page on the OpenBSD package
     website (e.g., "${var.package_server}/${var.os_ver}/packages/${var.package_arch}").
     This page should be saved locally in order to avoid requesting the
     same page many times.
   * Determine each package's version from the package web page.
   * When requesting the package web page across os versions and
     architectures, subsequent request must be made with a minimum
     interval of 60 seconds.
4. Once all necessary latest versions are gathered, use the
   `replace_in_file` tool to update the hardcoded version strings
   within the `environment_vars` in the `.pkr.hcl` files.
