for %%f in (vars-alpine-3.3-*.json) do (
  for %%g in (alpine-linux-3.3-minimal.json alpine-linux-3.3-ansible.json) do (
    packer build -var-file=%%f %* %%g
  )
)
packer build -var-file=vars-alpine-3.3-x86_64.json %* alpine-linux-3.3-docker.json
