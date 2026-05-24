---
name: freebsd-update-packages
description: Update package versions in templates for FreeBSD
---

# FreeBSD Update Packages

Detailed instructions for agent to follow when this skill is activated.

## Special Instruction for FreeBSD Templates

When instructed to update package versions in FreeBSD templates:

1. Enumerate all "*.pkr.hcl" template files in the current working
   directory (where you are working for the FreeBSD version).
2. Enumerate all "vars-*.pkrvars.hcl" files in the same directory.
3. For each template, determine FreeBSD version, ABI, and package branch
   from the template file and `install.sh.pkrtpl.hcl`.  Use the matching
   ABI string (for example, `FreeBSD:14:amd64`) and branch (`quarterly`
   or `latest`) when constructing package repository URLs.
4. Build the list of required ABI+branch combinations across all target
   architectures (`amd64`, `i386`, `aarch64`).
5. Download `packagesite.pkg` once per ABI+branch combination, then
   extract `packagesite.yaml` to
   `/tmp/pkgver/{ABI}/{branch}/packagesite.yaml`.  Reuse that file for
   all subsequent `pkgver.sh` calls for the same ABI+branch combination
   in the current session.
6. If downloading additional `packagesite.pkg` files for other ABI
   and/or branch combinations, keep a minimum interval of 10 minutes
   between consecutive `curl` requests.  Do not delay local reuse of an
   already downloaded `packagesite.yaml` file.
7. Identify package version management patterns in the `.pkr.hcl` files:
   a) **Variable-based** (preferred): Look for `variable` blocks with
      names like `{package}_version` (e.g., `ca_root_nss_version`,
      `doas_version`) that are referenced in `environment_vars` using
      `${var.*}` syntax.
   b) **Hardcoded in environment_vars**: Look for direct package-version
      strings in `provisioner "shell"` blocks' `environment_vars` (e.g.,
      `VIRTUALBOX_OSE_ADDITIONS=virtualbox-ose-additions-nox11-6.1.50.1500068_3`).
   c) **Hybrid**: Variables that store the full package-version string
      (e.g., `variable "doas" { default = "opendoas-6.8.2" }`)
      used directly without string interpolation.
   d) Note which variables store version-only strings vs. full package-
      version strings, as this affects how to process `pkgver.sh` output.
8. For each supported architecture (`amd64`, `i386`, `aarch64`), run
   `pkgver.sh` with the matching local `packagesite.yaml` and process
   the output:
   a) **For variable-based packages**:
      - Extract the version portion from `pkgver.sh` output
        (e.g., from `CA_ROOT_NSS=ca_root_nss-3.124`, extract `3.124`)
      - Update the corresponding `variable` definition's `default` value
      - Leave the `environment_vars` references (`${var.*}`) unchanged
   b) **For hardcoded environment_vars**:
      - Replace the entire package-version string in `environment_vars`
        with the full output from `pkgver.sh`
   c) **For hybrid variables**:
      - Determine if the variable stores version-only or full package-
        version
      - If version-only: extract and update just the version part
      - If full package-version: use the complete `pkgver.sh` output
9. For architecture-specific versions:
   a) Compare `pkgver.sh` outputs across all supported architectures
   b) If a package version differs from `amd64`:
      - Ensure a `variable` block exists for this package in the main
        `.pkr.hcl` file (create one if needed by converting hardcoded
        values to a variable first)
      - Override the variable value in
        `vars-freebsd-{freebsd_version}-{architecture}.pkrvars.hcl`
      - Use the format: `variable_name = "version_value"` (e.g.,
        `ca_root_nss_version = "3.124"` or `doas = "opendoas-6.8.2"`)
10. For templates that use inline hardcoded version strings instead of
    environment variables, manually search the `.pkr.hcl` file for
    package-version strings and replace them with versions returned by
    `pkgver.sh` for the matching ABI and branch.
11. If `pkgver.sh` produces no output for a variable, do not update that
    variable. Report the missing package name to the user and ask
    whether the package was renamed or removed.

## Package Version Discovery with `pkgver.sh`

The @/.agents/skills/freebsd-update-packages/scripts/pkgver.sh script
scans all `freebsd-*.pkr.hcl` template files in the current directory
for environment variable patterns referencing packages, generates a
series of `sed` commands to extract version numbers from `packagesite.yaml`,
and prints version numbers of packages.

### Usage

```sh
# FreeBSD (FreeBSD tar):
curl https://pkg.freebsd.org/FreeBSD:15:amd64/quarterly/packagesite.pkg |
  tar -xf - -O packagesite.yaml | pkgver.sh

# Linux (GNU tar with zstd support):
curl https://pkg.freebsd.org/FreeBSD:15:amd64/quarterly/packagesite.pkg |
  tar --zstd -xf - -O packagesite.yaml | pkgver.sh

# From a local file:
pkgver.sh /path/to/packagesite.yaml
```

In order to avoid requesting the same `packagesite.pkg` file many times,
download it once per ABI+branch combination and extract
`packagesite.yaml` to `/tmp/pkgver/{ABI}/{branch}/packagesite.yaml`.
Reuse this file for all package checks in the current session. When
downloading different ABI/branch combinations, keep a minimum interval
of 10 minutes between consecutive `curl` requests.

The script outputs lines in the format `VARIABLE_NAME=package-version`,
such as:

```
CA_ROOT_NSS=ca_root_nss-3.115_4
DOAS=opendoas-6.8.2
OPEN_VM_TOOLS=open-vm-tools-nox11-12.5.2,2
VIRTUALBOX_OSE_ADDITIONS=virtualbox-ose-additions-nox11-6.1.50.1500068_1
```

### Packages Typically Updated

The following packages are commonly referenced in FreeBSD templates:

| Variable                   | Package Name                                                   |
|----------------------------|----------------------------------------------------------------|
| `CA_ROOT_NSS`              | `ca_root_nss`                                                  |
| `DOAS`                     | `opendoas` or `doas`                                           |
| `OPEN_VM_TOOLS`            | `open-vm-tools-nox11` or `open-vm-tools`                       |
| `VIRTUALBOX_OSE_ADDITIONS` | `virtualbox-ose-additions-nox11` or `virtualbox-ose-additions` |

Note that some older templates (e.g., FreeBSD 12.x, 13.2, 13.3) use
hardcoded version strings directly in the template rather than variable
references. Update these inline values when `pkgver.sh` reports newer
versions for the matching ABI and branch.

### Architecture dependencies

* Run `pkgver.sh` for each supported architecture (`amd64`, 'aarch64`,
  and `i386` if available) and compare outputs.
* If a package version for a specific architecture differs from amd64,
  introduce a Packer user variable for such a package version so that
  the version number can be overridden for the architecture using
  `vars-freebsd-{freebsd_version}-{architecture}.pkrvars.hcl`.
