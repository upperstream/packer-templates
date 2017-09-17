for %%f in (freebsd-10.4-rc-*.json) do packer build %* %%f
for %%f in (freebsd-10.4-rc-*.json) do (
  if not "%%f"=="freebsd-10.4-rc-docker.json" (
    if  not "%%f"=="freebsd-10.4-rc-zfs.json" packer build -var-file=vars-freebsd-10.4-i386.json %* %%f
  )
)
