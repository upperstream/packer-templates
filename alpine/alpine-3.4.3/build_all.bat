for %%f in (vars-alpine-3.4.3-*.json) do (
  for %%g in (alpine-3.4.3-minimal.json alpine-3.4.3-ansible.json) do (
    packer build -var-file=%%f %* %%g
  )
)
packer build -var-file=vars-alpine-3.4.3-x86_64.json %* alpine-3.4.3-docker.json 
