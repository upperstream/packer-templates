for %%f in (freebsd-10.3-release-*.json) do packer build -var-file=vars-freebsd-10.3-amd64.json %* %%f
for %%f in (freebsd-10.3-release-*.json) do (
  if not "%%f"=="freebsd-10.3-release-docker.json" packer build -var-file=vars-freebsd-10.3-i386.json %* %%f
)
