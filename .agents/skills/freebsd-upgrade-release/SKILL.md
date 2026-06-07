---
name: freebsd-upgrade-release
description: Update Packer templates for FreeBSD release changes (BETA, RC, RELEASE)
---

# FreeBSD Upgrade Release Skill

This skill automates the process of updating Packer templates when
FreeBSD releases a new version (e.g., BETA1→BETA2, BETA3→RC1,
RC1→RC2, RC2→RELEASE).

## Workflow Overview

When instructed to upgrade FreeBSD templates to a new release, follow
these steps:

### 1. Gather Required Information

Ask the user for:

- **Current FreeBSD release** (e.g., `15.1-RC1`): The existing release
  to upgrade from
- **New FreeBSD release** (e.g., `15.1-RC2`): The new release to upgrade
  to
- **New box_version** (e.g., `2.20260601`): The version number for the
  Vagrant box
- **ISO checksum URL** (optional): URL to the SHA256 checksum file
  - Default pattern: `file:https://download.freebsd.org/releases/ISO-IMAGES/{VERSION}/CHECKSUM.SHA256-FreeBSD-{VERSION}-{ARCH}`
  - Example: `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC2-amd64`
- **ISO name** (optional): Name of the ISO image file
  - Default pattern: `FreeBSD-{VERSION}-{ARCH}-dvd1.iso`
  - Example: `FreeBSD-15.1-RC2-amd64-dvd1.iso`

### 2. Validate Source Directory

Verify that the source directory `freebsd/freebsd-{MAJOR.MINOR}/` exists
before proceeding (e.g., `freebsd/freebsd-15.1/`).

### 3. Update Template Files

For each `.pkr.hcl` file in the FreeBSD version directory:

**Variable: `box_version`**

- Update the default value to the new box_version provided by the user
- Example: `1.20260523` → `2.20260601`

**Variable: `iso_checksum`**

- Update the URL to point to the new release's checksum file
- Replace old version string with new version string
- For amd64: Update `CHECKSUM.SHA256-FreeBSD-{OLD_VERSION}-amd64` to
  `CHECKSUM.SHA256-FreeBSD-{NEW_VERSION}-amd64`
- Example: `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC1-amd64`
  → `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC2-amd64`

**Variable: `iso_name`**

- Update the ISO filename to match the new release
- Replace old version string with new version string
- Example: `FreeBSD-15.1-RC1-amd64-dvd1.iso` → `FreeBSD-15.1-RC2-amd64-dvd1.iso`

**Variable: `os_version`**

- Update the OS version string to match the new release
- Example: `15.1-RC1` → `15.1-RC2`

**Note:** The `vm_name` variable typically remains unchanged (e.g.,
`FreeBSD-15.1-RC`) as it represents the base version, not the specific
revision.

### 4. Update Architecture-Specific Variable Files

For `vars-freebsd-{VERSION}-aarch64.pkrvars.hcl`:

**Variable: `iso_checksum`**

- Update the URL to point to the new release's checksum file
- Replace old version string with new version string
- For aarch64: Update `CHECKSUM.SHA256-FreeBSD-{OLD_VERSION}-arm64-aarch64`
  to `CHECKSUM.SHA256-FreeBSD-{NEW_VERSION}-arm64-aarch64`
- Example: `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC1-arm64-aarch64`
  → `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC2-arm64-aarch64`

**Variable: `iso_name`**

- Update the ISO filename to match the new release
- For aarch64: Use `arm64-aarch64` in the filename
- Example: `FreeBSD-15.1-RC1-arm64-aarch64-dvd1.iso` → `FreeBSD-15.1-RC2-arm64-aarch64-dvd1.iso`

### 5. Update README.md

Update the `README.md` file in the FreeBSD version directory:

- Replace all references to the old version with the new version
  - Example: `FreeBSD 15.1-RC1` → `FreeBSD 15.1-RC2`
- Update box version examples in build commands
  - Example: `v1.20260523` → `v2.20260601`
- Update variant descriptions to reference the new version
- Update example box filenames to use the new version

### 6. Update Package Versions

Invoke the `freebsd-update-packages` skill to update package versions:

- Change to the FreeBSD version directory (e.g., `freebsd/freebsd-15.1/`)
- Activate the `freebsd-update-packages` skill
- This will query FreeBSD package repositories and update any outdated
  packages
- The skill will verify that all packages are at their latest available
  versions

### 7. Update CHANGELOG.md

Add an entry to the root `CHANGELOG.md` file under the `[Unreleased]`
section:

- Add a bullet point under the "Changed" section
- Format: `* [FreeBSD {MAJOR.MINOR}](freebsd/freebsd-{MAJOR.MINOR}/README.md): Upgrade templates to FreeBSD {NEW_VERSION}.`
- If package versions were updated, add a sub-bullet: `* Verify package versions are at latest available in FreeBSD {NEW_VERSION} {BRANCH} branch.`
- Example:

  ```
  * [FreeBSD 15.1](freebsd/freebsd-15.1/README.md): Upgrade templates to
    FreeBSD 15.1-RC2.
  * [FreeBSD 15.1](freebsd/freebsd-15.1/README.md): Verify package
    versions are at latest available in FreeBSD 15.1-RC2 release_1
    branch.
  ```

### 8. Verify Results

After completing all steps:

- Verify that all `.pkr.hcl` files have been updated with the new
  version
- Confirm that all version references in `README.md` have been updated
- Check that the `vars-freebsd-{VERSION}-aarch64.pkrvars.hcl` file has
  been updated
- Verify that `CHANGELOG.md` has been updated with the upgrade entry
- Optionally, run `packer validate` on the updated templates to ensure
  they are syntactically valid

## Example Usage

When a user says: "Update FreeBSD 15.1 templates from RC1 to RC2 with
box version 2.20260601"

The skill will:

1. Ask for confirmation of:

   - Current version: `15.1-RC1`
   - New version: `15.1-RC2`
   - Box version: `2.20260601`
   - ISO checksum URL: `file:https://download.freebsd.org/releases/ISO-IMAGES/15.1/CHECKSUM.SHA256-FreeBSD-15.1-RC2-amd64`
   - ISO name: `FreeBSD-15.1-RC2-amd64-dvd1.iso`

2. Update all `.pkr.hcl` files:

   - `freebsd-15.1-minimal.pkr.hcl`
   - `freebsd-15.1-dwm.pkr.hcl`
   - `freebsd-15.1-xfce.pkr.hcl`

3. Update `vars-freebsd-15.1-aarch64.pkrvars.hcl` with aarch64-specific
   values

4. Update `README.md` with new version references and box version
   examples

5. Invoke `freebsd-update-packages` skill to verify/update package
   versions

6. Update `CHANGELOG.md` with the upgrade entry

7. Confirm completion

## Notes

- The skill is version-agnostic and can be used for any FreeBSD version
  upgrade
- Always validate that the source directory exists before starting
- Ensure proper version number formatting:
  - Full version: `15.1-RC2` (with hyphen and revision)
  - ISO filename: `FreeBSD-15.1-RC2-amd64-dvd1.iso`
  - For aarch64: `FreeBSD-15.1-RC2-arm64-aarch64-dvd1.iso`
- The `install.sh.pkrtpl.hcl` file does not need to be updated as it
  uses variables
- Coordinate with the `freebsd-update-packages` skill for package
  version updates
- The `vm_name` variable typically remains as the base version (e.g.,
  `FreeBSD-15.1-RC`) and does not change with revision updates
