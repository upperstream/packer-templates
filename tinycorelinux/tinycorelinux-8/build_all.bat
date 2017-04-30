for %%f in (vars-core*.json) do (
  for %%g in (tc-8-compiletc.json tc-8-minimal.json) do (
    packer build -var-file=%%f %%g
  )
)
for %%f in (vars-tinycore*.json) do (
  for %%g in (tc-8-*x11.json) do (
    packer build -var-file=%%f %%g
  )
)
