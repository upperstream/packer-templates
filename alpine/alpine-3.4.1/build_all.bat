for %%f in (vars-alpine-3.4.1-*.json) do (
  for %%g in (alpine-3.4.1-minimal.json alpine-3.4.1-ansible.json) do (
    packer build -var-file=%%f %* %%g
  )
)
packer build -var-file=vars-alpine-3.4.1-x86_64.json %* alpine-3.4.1-docker.json 
