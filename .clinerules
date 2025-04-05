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
