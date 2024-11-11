Get-ADUser -Filter {badpwdcount -gt 0} -SearchBase "OU=USERS,OU=ABC,OU=DEF,OU=GHI,DC=domaine,DC=com" -Properties BadPwdCount -Server <IP_DC> | Select-Object Name, BadPwdCount
