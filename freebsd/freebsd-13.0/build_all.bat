for %%f in (freebsd-13.0-release-*.json) do packer build %* %%f
for %%f in (freebsd-13.0-release-*.json) do packer build -var-file=vars-freebsd-13.0-i386.json %* %%f
