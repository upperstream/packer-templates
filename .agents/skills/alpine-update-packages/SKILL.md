---
name: alpine-update-packages
description: Update package versions in templates for Alpine Linux
---

# Alpine Linux Update Packages

Detailed instructions for agent to follow when this skill is activated.

## Special Instruction for Alpine Linux Templates

When instructed to update package versions in Alpine Linux templates:

1. Examine the `provisioner "shell"` blocks within the relevant
   `.pkr.hcl` files.
2. Identify any packages installed with **hardcoded versions** specified
   in the `environment_vars` (e.g., `PACKAGE_NAME=package=1.2.3-r0`).
   Packages without explicit versions do not need manual updates, as
   `apk` fetches the latest during build.
3. For each package with a hardcoded version:
   - Identify the target Alpine release (e.g., `v3.21`), repository
     (`main` or `community`), and architecture (`x86_64`, `aarch64`)
     based on the template context.
   - Construct the URL: `https://dl-cdn.alpinelinux.org/alpine/{alpine_version}/{repo}/{arch}/APKINDEX.tar.gz`.
   - Download and save the file locally to a cache directory (e.g.,
     `.cache/apkindex/{version}_{repo}_{arch}/`).
   - At least 1 minute has elapsed since the last HTTP request to
     `dl-cdn.alpinelinux.org` (regardless of which `{alpine_version}`,
     `{repo}`, or `{arch}` combination was previously downloaded)
   - This throttling prevents redundant downloads and avoids DoS-like
     traffic patterns by enforcing a 1-minute minimum interval between
     all consecutive HTTP requests to the same remote host.

4. Parse the `APKINDEX` metadata to extract package details:

   - Decompress the downloaded `.tar.gz` archive to access the plain-
     text `APKINDEX` file.
   - Scan the file for entries matching your target package name (`P:`).
     Each package entry is a block of key-value pairs separated by
     newlines, ending with an empty line or the next `P:` field.
   - Extract the following fields from the matched entry:
     - **Package Name:** Value immediately after `P:` (e.g., `7zip`)
     - **Version:** Value immediately after `V:` (e.g., `23.01-r0`)
     - **Target Architecture:** Value immediately after `A:` (e.g.,
       `x86_64`)
   - Compare the extracted version (`V:`) with the hardcoded version in
     your `.pkr.hcl` file.  If they differ, update the hardcoded value
     to match the latest available version from the metadata.

5. Validate that the target architecture (`A:`) matches the template's
   intended build environment before applying updates.
