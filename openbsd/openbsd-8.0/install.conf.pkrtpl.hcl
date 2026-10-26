%{ for config_key, config_value in configurations }
${config_key} = ${config_value}
%{ endfor ~}
System hostname = openbsd
Password for root account = $2b$10$yVi2IKf9waP5UzSWoEP6GeB/b62vogD4ld1VzBuuCyofRCdgCXiv6
Allow root ssh login = yes
Directory does not contain SHA256.sig. Continue without verification = yes
