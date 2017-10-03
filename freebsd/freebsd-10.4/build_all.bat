for %%f in (freebsd-10.4-release-*.json) do packer build %* %%f
for %%f in (freebsd-10.4-release-*.json) do (
  if not "%%f"=="freebsd-10.4-release-docker.json" (
    if  not "%%f"=="freebsd-10.4-release-zfs.json" packer build -var-file=vars-freebsd-10.4-i386.json %* %%f
  )
)
