for %%f in (centos-6.8-minimal.json centos-6.8-ansible) do (
  for %%g in (vars-centos-6.8-*.json) do (
    packer build -var-file=%%g %* %%f
  )
)
packer build -var-file=vars-centos-6.8-x86_64.json %* centos-6.8-docker.json
