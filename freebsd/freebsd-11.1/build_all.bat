for %%f in (freebsd-11.1-rc-*.json) do packer build -var-file=vars-freebsd-11.1-amd64.json %* %%f
for %%f in (freebsd-11.1-rc-*.json) do (
  if not "%%f"=="freebsd-11.1-rc-docker.json" packer build -var-file=vars-freebsd-11.1-i386.json %* %%f
)
