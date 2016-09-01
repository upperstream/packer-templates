for %%f in (freebsd-11.0-rc-*.json) do packer build -var-file=vars-freebsd-11-amd64.json %* %%f
for %%f in (freebsd-11.0-rc-*.json) do (
  if not "%%f"=="freebsd-11.0-rc-docker.json" packer build -var-file=vars-freebsd-11-i386.json %* %%f
)
