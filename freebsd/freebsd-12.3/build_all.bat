for %%f in (freebsd-12.3-beta-*.json) do packer build %* %%f
for %%f in (freebsd-12.3-beta-*.json) do packer build -var-file=vars-freebsd-12.3-i386.json %* %%f