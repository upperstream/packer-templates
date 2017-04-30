for %%f in (vars-alpine-*.json) do (
  for %%g in (alpine-3.5.0-minimal.json alpine-3.5.0-ansible.json alpine-3.5.0-xorg.json) do (
    packer build -var-file=%%f %* %%g
  )
)
for %%f in (vars-alpine-*-x86_64.json) do (
  packer build -var-file=%%f %* alpine-3.5.0-docker.json
)
