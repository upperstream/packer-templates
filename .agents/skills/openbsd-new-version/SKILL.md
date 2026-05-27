---
name: openbsd-new-version
description: Create Packer templates for a new OpenBSD version based on an existing version
---

# OpenBSD New Version Skill

This skill automates the process of creating Packer templates for a new
OpenBSD release based on an existing version's templates.

## Workflow Overview

When instructed to create templates for a new OpenBSD version, follow
these steps:

### 1. Gather Required Information

Ask the user for:

- **Source OpenBSD version** (e.g., `7.8`): The existing version to use
  as the base
- **Target OpenBSD version** (e.g., `7.9`): The new version to create
- **Box version date** (e.g., `20260519`): The date component for the
  box_version variable

### 2. Validate Source Directory

Verify that the source directory `openbsd/openbsd-{SOURCE_VERSION}/`
exists before proceeding.

### 3. Copy Directory Structure

Copy the entire source directory to create the target directory:

- Source: `openbsd/openbsd-{SOURCE_VERSION}/`
- Target: `openbsd/openbsd-{TARGET_VERSION}/`

### 4. Rename Template Files

Rename all files in the new directory to match the target version:

**Template files** (`.pkr.hcl`):

- `openbsd-{SOURCE_VERSION}-minimal.pkr.hcl` → `openbsd-{TARGET_VERSION}-minimal.pkr.hcl`
- `openbsd-{SOURCE_VERSION}-x11.pkr.hcl` → `openbsd-{TARGET_VERSION}-x11.pkr.hcl`
- `openbsd-{SOURCE_VERSION}-dwm.pkr.hcl` → `openbsd-{TARGET_VERSION}-dwm.pkr.hcl`
- `openbsd-{SOURCE_VERSION}-xfce.pkr.hcl` → `openbsd-{TARGET_VERSION}-xfce.pkr.hcl`

**Variable files** (`.pkrvars.hcl`):

- `vars-openbsd-{SOURCE_VERSION}-arm64.pkrvars.hcl` → `vars-openbsd-{TARGET_VERSION}-arm64.pkrvars.hcl`
- `vars-openbsd-{SOURCE_VERSION}-i386.pkrvars.hcl` → `vars-openbsd-{TARGET_VERSION}-i386.pkrvars.hcl`

### 5. Update Template Variables

For each `.pkr.hcl` file in the target directory, update the following
variables:

**Variable: `box_version`**

- Old: `{SOURCE_VERSION}.{OLD_DATE}` (e.g., `7.8.20251022`)
- New: `{TARGET_VERSION}.{BOX_VERSION_DATE}` (e.g., `7.9.20260519`)

**Variable: `iso_checksum`**

- Old: `file:https://cdn.openbsd.org/pub/OpenBSD/{SOURCE_VERSION}/amd64/SHA256`
- New: `file:https://cdn.openbsd.org/pub/OpenBSD/{TARGET_VERSION}/amd64/SHA256`

**Variable: `iso_image`**

- Old: `install{SOURCE_VERSION_NO_DOT}.iso` (e.g., `install78.iso`)
- New: `install{TARGET_VERSION_NO_DOT}.iso` (e.g., `install79.iso`)
  - Note: Remove dots from version (7.9 → 79)

**Variable: `os_ver`**

- Old: `{SOURCE_VERSION}` (e.g., `7.8`)
- New: `{TARGET_VERSION}` (e.g., `7.9`)

**Variable: `vm_name`**

- Old: `OpenBSD-{SOURCE_VERSION}` (e.g., `OpenBSD-7.8`)
- New: `OpenBSD-{TARGET_VERSION}` (e.g., `OpenBSD-7.9`)

### 6. Update Architecture-Specific Variable Files

For `vars-openbsd-{TARGET_VERSION}-arm64.pkrvars.hcl`:

- Update `iso_checksum` URL from `/{SOURCE_VERSION}/arm64/` to `/{TARGET_VERSION}/arm64/`
- Update `iso_image` from `install{SOURCE_VERSION_NO_DOT}.iso` to `install{TARGET_VERSION_NO_DOT}.iso`
- Update `os_ver` from `{SOURCE_VERSION}` to `{TARGET_VERSION}`

For `vars-openbsd-{TARGET_VERSION}-i386.pkrvars.hcl`:
- Update `iso_checksum` URL from `/{SOURCE_VERSION}/i386/` to `/{TARGET_VERSION}/i386/`
- Update `iso_image` from `install{SOURCE_VERSION_NO_DOT}.iso` to `install{TARGET_VERSION_NO_DOT}.iso`
- Update `os_ver` from `{SOURCE_VERSION}` to `{TARGET_VERSION}`

### 7. Update Package Versions

Use the `openbsd-update-packages` skill to update package versions:
- Invoke the skill with the target version directory
- This will query OpenBSD package repositories and update hardcoded
  package versions

### 8. Update README.md

Create a new `README.md` in the target directory by:

- Copying the source `README.md`
- Replacing all references to `{SOURCE_VERSION}` with `{TARGET_VERSION}`
- Replacing all references to `{OLD_BOX_VERSION}` with `{TARGET_VERSION}.{BOX_VERSION_DATE}`
- Updating example commands to use the new template filenames

### 9. Update CHANGELOG.md

Add an entry to the root `CHANGELOG.md` file under the `[Unreleased]`
section:

- Add a bullet point under the "Added" section
- Format: `* [OpenBSD](openbsd/README.md): Add templates for OpenBSD {TARGET_VERSION}.`

### 10. Verify Results

After completing all steps:

- Verify that all files have been created in `openbsd/openbsd-{TARGET_VERSION}/`
- Confirm that all version references have been updated correctly
- Check that the new templates are syntactically valid (optional: run
  `packer validate`)

## Example Usage

When a user says: "Create templates for OpenBSD 7.9 based on OpenBSD 7.8
with box version 20260519"

The skill will:

1. Ask for confirmation of source version (7.8), target version (7.9),
   and box version date (20260519)
2. Copy `openbsd/openbsd-7.8/` to `openbsd/openbsd-7.9/`
3. Rename all files to use `7.9` instead of `7.8`
4. Update all variables in the templates
5. Update architecture-specific variable files
6. Update package versions using the `openbsd-update-packages` skill
7. Update README.md and CHANGELOG.md
8. Confirm completion

## Notes

- The skill is version-agnostic and can be used for any OpenBSD version
  upgrade
- Always validate that the source directory exists before starting
- Ensure proper version number formatting (e.g., `7.9` vs `79` for ISO
  filenames)
- Coordinate with the `openbsd-update-packages` skill for package
  version updates
- The `install.conf.pkrtpl.hcl` file does not need to be renamed as it's
  a template used by all versions
