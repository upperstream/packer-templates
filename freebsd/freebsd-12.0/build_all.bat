for %%f in (freebsd-12.0-release-*.json) do packer build -var-file=vars-freebsd-12.0-amd64.json %* %%f
for %%f in (freebsd-12.0-release-*.json) do (
  if not "%%f"=="freebsd-12.0-release-docker.json" packer build -var-file=vars-freebsd-12.0-i386.json %* %%f
)
