for %%f in (freebsd-12.1-release-*.json) do packer build -var-file=vars-freebsd-12.1-amd64.json %* %%f
for %%f in (freebsd-12.1-release-*.json) do packer build -var-file=vars-freebsd-12.1-i386.json %* %%f
