for %%f in (centos-6.9-minimal.json centos-6.9-ansible) do (
  for %%g in (vars-centos-6.9-*.json) do (
    packer build -var-file=%%g %* %%f
  )
)
packer build -var-file=vars-centos-6.9-x86_64.json %* centos-6.9-docker.json
