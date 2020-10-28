for %%f in (freebsd-12.2-release-*.json) do packer build %* %%f
for %%f in (freebsd-12.2-release-*.json) do packer build -var-file=vars-freebsd-12.2-i386.json %* %%f
