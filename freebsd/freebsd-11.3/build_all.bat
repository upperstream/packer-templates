for %%f in (freebsd-11.3-beta-*.json) do packer build -var-file=vars-freebsd-11.3-amd64.json %* %%f
for %%f in (freebsd-11.3-beta-*.json) do (
  if not "%%f"=="freebsd-11.3-beta-docker.json" packer build -var-file=vars-freebsd-11.3-i386.json %* %%f
)
