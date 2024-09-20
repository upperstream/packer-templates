%{ for config_key, config_value in location_of_sets }
${config_key} = ${config_value}
%{ endfor ~}
%{ for config_key, config_value in server_directory }
${config_key} = ${config_value}
%{ endfor ~}
System hostname = foo
Password for root account = $2b$10$yVi2IKf9waP5UzSWoEP6GeB/b62vogD4ld1VzBuuCyofRCdgCXiv6
%{ for config_key, config_value in install_x11 }
${config_key} = ${config_value}
%{ endfor ~}
Allow root ssh login = yes
%{ for config_key, config_value in set_names }
${config_key} = ${config_value}
%{ endfor ~}
Directory does not contain SHA256.sig. Continue without verification = yes
