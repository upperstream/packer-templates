for %%f in (vars-core*.json) do (
  for %%g in (tc-7-ansible.json tc-7-compiletc.json tc-7-minimal.json) do (
    packer build -var-file=%%f %%g
  )
)
for %%f in (vars-tinycore*.json) do (
  for %%g in (tc-7-*x11.json) do (
    packer build -var-file=%%f %%g
  )
)
