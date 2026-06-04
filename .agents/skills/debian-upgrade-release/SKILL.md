---
name: debian-upgrade-release
description: Update Packer templates for Debian minor release changes (e.g., 13.4 → 13.5)
---

# Debian Upgrade Release Skill

This skill automates the process of updating Packer templates when
Debian releases a new minor version (e.g., Debian 13.4 → 13.5).

**Important:** This skill is for **minor version upgrades only** within
the same major Debian release. For creating templates for a new major
release (e.g., Debian 14.0), refer to a separate skill designed for that
purpose.

## Workflow Overview

When instructed to upgrade Debian templates to a new minor release,
follow these steps:

### 1. Gather Required Information

Ask the user for:

- **Current Debian version** (e.g., `13.4`): The existing minor release
- **New Debian version** (e.g., `13.5`): The target minor release to
  upgrade to
- **New box_version** (e.g., `13.5.20260415`): The version number for
  the Vagrant box, typically formatted as `{major}.{minor}.{date}`

### 2. Determine Debian Codename

Based on the major version number, determine the Debian codename using
the official Debian releases page at https://www.debian.org/releases/:

| Major Version | Codename   | Status     |
|---------------|------------|------------|
| 13            | trixie     | Stable     |
| 12            | bookworm   | Oldstable  |
| 11            | bullseye   | LTS        |
| 10            | buster     | LTS        |
| 9             | stretch    | EOL        |
| 8             | jessie     | EOL        |
| 7             | wheezy     | EOL        |

For example, Debian 13.5 uses the codename `trixie`.

### 3. Determine Supported Architectures

By default, support `amd64` and `arm64` architectures. Ask the user if
additional architectures need to be supported (e.g., `i386`).

### 4. Validate Source Directory

Verify that the source directory `debian/debian-{MAJOR}/` exists before
proceeding (e.g., `debian/debian-13/`).

### 5. Update Template Files

For each `.pkr.hcl` file in the Debian version directory, update the
following variables:

**Variable: `box_version`**

- Update the default value to the new box_version provided by the user
- Example: `"13.4.20260314"` → `"13.5.20260415"`

**Variable: `os_version`**

- Update the OS version string to match the new release
- Example: `"13.4"` → `"13.5"`

### 6. Update Architecture-Specific Variable Files

For each architecture-specific `.pkrvars.hcl` file, update the following:

**Variable: `iso_name`**

- Update the ISO filename to match the new release
- Format: `debian-{major}.{minor}.{revision}-{arch}-{type}.iso`
- The revision is typically `0` for minor releases
- Example: `debian-13.4.0-amd64-netinst.iso` → `debian-13.5.0-amd64-netinst.iso`

**Variable: `iso_path`**

- Update the ISO path to match the new release
- Format: `{major}.{minor}.{revision}/{arch}/iso-cd`
- Example: `13.4.0/amd64/iso-cd` → `13.5.0/amd64/iso-cd`

**Variable: `iso_checksum`**

- Update the checksum URL to point to the new release
- For active releases (current stable): Use `debian-cd` path
  - Example: `file:https://cdimage.debian.org/debian-cd/13.5.0/amd64/iso-cd/SHA256SUMS`
- For older/archived releases: Use `cdimage/archive` path
  - Example: `file:https://cdimage.debian.org/cdimage/archive/12.12.0/amd64/iso-cd/SHA256SUMS`

**Note:** Determine whether to use `debian-cd` or `cdimage/archive`
based on whether the release is still current. For minor upgrades within
the same major version, typically the same URL pattern as the previous
version should be used.

### 7. Update README.md

Update the `README.md` file in the Debian version directory:

- Replace all references to the old version with the new version
  - Example: `Debian 13.4` → `Debian 13.5`
- Update box version examples in build commands
  - Example: `v13.4.20260314` → `v13.5.20260415`
- Update variant descriptions to reference the new version
- Update example box filenames to use the new version

### 8. Update Package Versions (Optional)

If instructed, update package versions using the Debian packages
repository:

#### General Package Updates

1. For each architecture (`amd64`, `arm64`, etc.):
   - Download and extract the Packages index from:
     `https://deb.debian.org/debian/dists/{codename}/main/binary-{arch}/Packages.xz`
   - Example for amd64 on Debian 13 (trixie):
     ```sh
     curl -sL https://deb.debian.org/debian/dists/trixie/main/binary-amd64/Packages.xz | \
       xz -d > /tmp/debian-packages-trixie-amd64.txt
     ```

2. Identify packages with hardcoded versions in `.pkr.hcl` files:
   - Look for `environment_vars` with version strings like
     `package=1.2.3`
   - Search the Packages index for the latest available version

3. Update package version strings using `replace_in_file`:
   - Replace old version with new version in `environment_vars`

#### Docker Package Updates

If updating Docker-related packages (docker.io, docker-compose), use a
different repository depending on the package source:

1. **For docker.io (from Debian repository):**
   - Download the Packages index from Debian:
     ```sh
     curl -fsSL https://deb.debian.org/debian/dists/{codename}/main/binary-amd64/Packages.xz | \
       xz -d > /tmp/debian-packages-{codename}-amd64.txt
     ```
   - Search for the latest docker.io version:
     ```sh
     grep "^Package: docker.io" /tmp/debian-packages-{codename}-amd64.txt -A 2 | \
       grep "^Version:" | tail -1
     ```
   - Update the `DOCKER_IO` environment variable in the docker template
     `.pkr.hcl` files with the new version

2. **For docker-ce (from Docker's official repository):**
   - Download the Packages file from Docker's repository:
     ```sh
     curl -fsSL https://download.docker.com/linux/debian/dists/{codename}/stable/binary-amd64/Packages.gz | \
       gunzip > /tmp/docker-packages-{codename}-amd64.txt
     ```
   - Search for the latest docker-ce version:
     ```sh
     grep "^Package: docker-ce$" /tmp/docker-packages-{codename}-amd64.txt -A 2 | \
       grep "^Version:" | tail -1
     ```
   - Update the `DOCKER_CE` environment variable if present

3. **For docker-compose (Debian repository):**
   - The latest version can be found in the same Debian Packages index:
     ```sh
     grep "^Package: docker-compose" /tmp/debian-packages-{codename}-amd64.txt -A 2 | \
       grep "^Version:" | tail -1
     ```
   - Update the `DOCKER_COMPOSE` environment variable in docker template files

4. Update the environment variables in the `provisioner "shell"` block of
   `debian-{major}-docker.pkr.hcl`:
   - Example: `"DOCKER_IO=docker.io=26.1.5+dfsg1-9+b13"`
   - Use `replace_in_file` to update these values in the appropriate
     templates


### 9. Update CHANGELOG.md

Add an entry to the root `CHANGELOG.md` file under the `[Unreleased]`
section:

- Add a bullet point under the "Changed" section
- Format: `* [Debian {MAJOR}](debian/debian-{MAJOR}/README.md): Upgrade templates to Debian {NEW_VERSION}.`
- Example:
  ```
  * [Debian 13](debian/debian-13/README.md): Upgrade templates to Debian 13.5.
  ```

### 10. Verify Results

After completing all steps:

- Verify that all `.pkr.hcl` files have been updated with the new
  version
- Confirm that all version references in `README.md` have been updated
- Check that all architecture-specific `.pkrvars.hcl` files have been
  updated
- Verify that `CHANGELOG.md` has been updated with the upgrade entry
- Optionally, run `packer validate` on the updated templates to ensure
  they are syntactically valid

## Example Usage

When a user says: "Update Debian 13 templates from 13.4 to 13.5 with box
version 13.5.20260415"

The skill will:

1. Confirm the details:
   - Current version: `13.4`
   - New version: `13.5`
   - Box version: `13.5.20260415`
   - Codename: `trixie` (auto-determined from major version 13)
   - Architectures: `amd64`, `arm64` (default, confirm with user)

2. Update all `.pkr.hcl` files in `debian/debian-13/`:
   - `debian-13-minimal.pkr.hcl`
   - `debian-13-dwm.pkr.hcl`
   - `debian-13-desktop.pkr.hcl`
   - `debian-13-docker.pkr.hcl`

3. Update architecture-specific variable files:
   - `vars-debian-13-amd64-netinst.pkrvars.hcl`:
     - `iso_name = "debian-13.5.0-amd64-netinst.iso"`
     - `iso_path = "13.5.0/amd64/iso-cd"`
     - `iso_checksum = "file:https://cdimage.debian.org/debian-cd/13.5.0/amd64/iso-cd/SHA256SUMS"`
   - `vars-debian-13-arm64-mini.pkrvars.hcl`:
     - Update similarly for arm64 architecture

4. Update `README.md` with new version references and box version examples

5. Update `CHANGELOG.md` with the upgrade entry

6. Confirm completion

## Notes

- This skill is designed for **minor version upgrades only** (e.g., 13.4 → 13.5)
- For major version releases (e.g., Debian 14.0), a separate skill
  should be used
- The codename remains the same within a major release series
- ISO revision is typically `0` for minor releases (e.g., `13.5.0`)
- Always verify URL patterns match the existing template structure
  before updating
- Package version updates use `Packages.xz` from Debian repositories,
  not packages.debian.org

## Important: Rate Limiting for Remote Host Requests

When fetching package information from remote repositories (Debian, Docker,
etc.), **maintain a minimum 60-second interval between successive HTTP
requests to the same remote host** to avoid overloading the server.

This is particularly important when:
- Fetching multiple package indexes from the same host
- Making multiple requests for different architectures
- Querying different repositories in a single workflow

**Implementation Guidelines:**

1. After downloading a Packages index (e.g., from `deb.debian.org`), wait
   at least 60 seconds before making the next request to that host
2. Cache downloaded Packages files locally to avoid redundant requests
3. Group requests to the same host together and add delays between
   different hosts
4. If you need to make multiple requests, consider using a pattern like:
   ```sh
   # Download first package index
   curl -fsSL https://deb.debian.org/debian/dists/trixie/main/binary-amd64/Packages.xz | xz -d > /tmp/packages-amd64.txt
   
   # Wait 60 seconds before next request to the same host
   sleep 60
   
   # Download second package index
   curl -fsSL https://deb.debian.org/debian/dists/trixie/main/binary-arm64/Packages.xz | xz -d > /tmp/packages-arm64.txt
   ```

**Rationale:** Remote package repositories have finite bandwidth and request
limits to serve the global community. Respectful spacing of requests helps
maintain service availability for all users.
