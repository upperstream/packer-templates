for %%f in (vars-core*.pkrvars.hcl) do (
  for %%g in (tc-17-compiletc.pkr.hcl tc-17-minimal.pkr.hcl tc-17-kernel.pkr.hcl) do (
    echo ------ %%f - %%g ------
    packer build -var-file=%%f %* %%g
  )
)
for %%f in (vars-tinycore*.pkrvars.hcl) do (
  for %%g in (tc-17-*x11.pkr.hcl) do (
    echo ------ %%f - %%g ------
    packer build -var-file=%%f %* %%g
  )
)
