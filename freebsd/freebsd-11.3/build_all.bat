for %%f in (freebsd-11.3-rc-*.json) do packer build %* %%f
for %%f in (freebsd-11.3-rc-*.json) do packer build -var-file=vars-freebsd-11.3-i386.json %* %%f
