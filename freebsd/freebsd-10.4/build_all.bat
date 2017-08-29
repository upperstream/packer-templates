for %%f in (freebsd-10.4-beta-*.json) do packer build %* %%f
for %%f in (freebsd-10.4-beta-*.json) do (
  if not "%%f"=="freebsd-10.4-beta-docker.json" (
    if  not "%%f"=="freebsd-10.4-beta-zfs.json" packer build -var-file=vars-freebsd-10.4-i386.json %* %%f
  )
)
