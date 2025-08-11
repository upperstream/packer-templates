<!-- markdownlint-disable MD010 -->
# Cline Rules

## Execution Environment

Always use a POSIX-compliant shell as the execution environment.  On
Windows, use Git Bash or MSYS2 instead of PowerShell to ensure
UNIX-style commands can be properly executed.

### Common commands

* Building a template: `packer build -only=<builder> <template>.pkr.hcl`
* Validating a template: `packer validate <template>.pkr.hcl`
* Using variables: `packer build -var-file=<vars>.pkrvars.hcl <template>.pkr.hcl`

## Rules of Engagement

* Whenever you make changes in the project files, also update the
  CHANGELOG.md file so that it mentions the latest update.
* Whenever you modify template files to update any of the following,
  also update the relevant README.md file so that the latest changes
  are reflected in the document:
  * Vagrant box version (usually "box_version" variable)
  * VM name (usually "vm_name" or "vm_name_base" variable)
  * Vagrant box filename (usually referring to `vm_name`, `box_version`,
    and the provider name in the box filename)
* When you receive a request to update templates in order to upgrade OS
  version to create VM image, you should also inspect relevant
  *.pkrvars.hcl files.  These files usually specify filename, URL, and
  checksum for the ISO image to download.

## Documentation

When modifying any implementation, update the `README.md` document,
manual pages, and `CHANGELOG.md` to reflect the changes accurately.

### README.md structure

Each template directory should contain a README.md with:

* Description of the template
* Prerequisites
* Build instructions for each supported builder
* List of available variables and their descriptions
* Examples of usage

### CHANGELOG.md updates

When making changes, add an entry to CHANGELOG.md under the appropriate
version section following this format:

* Added: for new features
* Changed: for changes in existing functionality
* Fixed: for bug fixes
* Removed: for removed features

## Coding Standards

### HCL file standards

* Use 2-space indentation for HCL files
* Use snake_case for variable and resource names
* Group related blocks together
* Include descriptive comments for complex logic
* Provide type and description for all variables
* Use locals for values used in multiple places

### Shell script standards

* Include shebang line (`#!/bin/sh` for POSIX compliance)
* Use tab characters for indentation (not spaces), displayed as 4 spaces
  wide in editors
* Add error handling with appropriate exit codes
* Include comments explaining non-obvious operations
* Use double quotes for variables to handle spaces properly
* Set `-e` flag to exit on errors

Example of proper shell script formatting:

```
#!/bin/sh -e

# Function to display error message and exit
error_exit() {
	echo "Error: $1" >&2
	exit 1
}

# Process input file
process_file() {
	local file_name="$1"

	if [ ! -f "$file_name" ]; then
		error_exit "File $file_name not found"
	fi

	echo "Processing $file_name..."
	# Processing logic here
}

# Main script execution
main() {
	if [ $# -eq 0 ]; then
		error_exit "No input file specified"
	fi

	process_file "$1"
	echo "Processing complete"
}

main "$@"
```

Note how tab characters are used for indentation, with each level
visually represented as 4 spaces wide.

### VM name, output directory name, and box name

The standard format for VM names is {OS name and OS version}-{variant
name}-v{box version}-{architecture}.  For example, the VM name of the
minimal variant of FreeBSD 14.2-RELEASE for amd64 architecture is
`FreeBSD-14.2-RELEASE-minimal-v14.2.20241203-amd64`.  The box version
typically consists of the OS version and its release date.

The standard format for output directory names in the `output`
directory is {OS name and OS version}-{variant name}-v{box
version}-{architecture}-{builder}, which follows the VM name format
with the Packer builder name appended.  For example, the output
directory name for the minimal variant of FreeBSD 14.2-RELEASE for
amd64 architecture with VirtualBox builder is
`FreeBSD-14.2-RELEASE-minimal-v14.2.20241203-amd64-virtualbox`.

The standard format for box names is {OS name and OS version}-{variant
name}-v{box version}-{architecture}-{provider}.box, which again follows
the VM name format with the Vagrant provider name appended.  For
example, the box name for the minimal variant of FreeBSD 14.2-RELEASE
for amd64 architecture for VirtualBox provider is
`FreeBSD-14.2-RELEASE-minimal-v14.2.20241203-amd64-virtualbox.box`.

## Workflow

### Development process

1. Read the documentation for the OS you're working with
2. Check existing templates for similar functionality
3. Make changes to templates following the coding standards
4. Test your changes with all supported builders
5. Update documentation to reflect your changes
6. Submit your changes with a clear description

### OS-specific considerations

When working with templates for different operating systems, be aware
of their unique requirements:

* **Linux distributions**: Pay attention to package manager differences
  (apt, yum, pacman, etc.) and init systems (systemd, OpenRC, etc.)
* **BSD variants**: Note the differences in disk partitioning, network
  configuration, and base system utilities
* **Windows**: Consider driver requirements and automation limitations
  during installation

### Testing requirements

Before submitting changes, ensure:

* Templates validate with `packer validate`
* Templates build successfully with all supported builders
* Generated VMs boot and function as expected
* All provisioning scripts execute without errors

### Special instruction for Alpine Linux templates

This section applies when you are working for templates for Alpine
Linux (sitting in any directories in `alpine/`).

When you are instructed to update the template files to use the latest
available version of the packages, do the following:

1. Examine the `provisioner "shell"` blocks within the relevant
   `.pkr.hcl` files.
2. Identify any packages installed with **hardcoded versions** specified
   in the `environment_vars` (e.g., `PACKAGE_NAME=package=1.2.3-r0`).
   Packages installed without an explicit version (e.g., `apk add package`)
   do not need manual version updates, as `apk` will fetch the latest
   during the build.
3. For each package with a hardcoded version:
   * Determine the target Alpine version (e.g., `v3.21`), repository
     (usually `main` or `community`), and relevant architecture
     (e.g., `x86_64`, `aarch64`) based on the template context.
   * Use one of the following methods to obtain the latest package version:
     a) If working directly on an Alpine Linux system:
        * Use `apk search` to query the package index
        * Example: `apk search -v --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.21/main <package-name>`
     b) For remote or cross-platform version checking:
        * Visit the Alpine Linux package website: `https://pkgs.alpinelinux.org/package/<branch>/<repo>/<arch>/<package-name>`
        * Manually check the latest version
        * Use web scraping tools or API calls to extract the version if needed
   * Verify the extracted version is compatible with the target Alpine Linux version
   * Note the extracted version number.
4. Once all necessary latest versions are gathered, use the
   `replace_in_file` tool to update the hardcoded version strings
   within the `environment_vars` in the `.pkr.hcl` files.

### Instructions for Debian templates

SHA256 SUM for netboot ISO image (`mini.iso`) can be obtained from
https://deb.debian.org/debian/dists/{debian_release}/main/installer-{cpu}/{date}/images/SHA256SUMS,
where `debian_release` is Debian release version, e.g., `Debian13.0`,
`cpu` is CPU name, e.g., `amd64`, `date` is the most recent date, which
may be suffixed by something like `+debian13u1`.  SHA256 SUM for
`./netboot/mini.iso` is the one to retrieve and put into templates.

Latest package versions can be determined by
https://packages.debian.org/{debian_codename}/allpackages?format=txt.gz or
https://packages.debian.org/{debian_codename}/{package_name}.

### Instructions for OpenBSD templates

This section applies when you are working for templates for OpenBSD
(sitting in any directories in `openbsd/`).

When you are instructed to update the template files to use the latest
available version of the packages, do the following:

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
   * Determine each package's version from the package website.
4. Once all necessary latest versions are gathered, use the
   `replace_in_file` tool to update the hardcoded version strings
   within the `environment_vars` in the `.pkr.hcl` files.

## Common Patterns and Best Practices

### Template organization

* Use variables for values that might change
* Use locals for computed values
* Separate builder-specific configurations
* Use templatefile function for generating scripts
* Maintain consistent structure across similar templates

### Provisioning best practices

* Keep provisioning scripts idempotent
* Use shell provisioners for simple tasks
* Break complex provisioning into multiple scripts
* Handle errors and provide meaningful messages
* Clean up temporary files and artifacts

## Troubleshooting

### Common issues

* **SSH connection failures**: Check firewall settings, SSH service
  status, and network configuration in the VM
* **Boot failures**: Verify boot command sequence and timing
* **Provisioning errors**: Check script permissions, paths, and
  dependencies
* **Builder-specific issues**: Consult the relevant builder
  documentation for specific troubleshooting steps

### Debugging techniques

* Use `PACKER_LOG=1` environment variable for verbose logging
* Inspect generated artifacts in the output directory
* Use the `-debug` flag to pause at each step
* Check VM console output for error messages
