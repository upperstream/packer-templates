for %%f in (vars-alpine-*.json) do (
  for %%g in (alpine-3.6-minimal.json alpine-3.6-ansible.json alpine-3.6-dwm.json) do (
    packer build -var-file=%%f %* %%g
  )
)
for %%f in (vars-alpine-*-x86_64.json) do (
  packer build -var-file=%%f %* alpine-3.6-docker.json
)
